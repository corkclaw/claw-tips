# Claw Tips - Technical Architecture Document

**Version:** 1.0  
**Date:** February 19, 2026  
**Architect:** Sir Claw Alot (on behalf of Arc)  
**Status:** Design Phase

---

## 1. Technology Stack Recommendation

### **Decision: Native iOS with Swift + SwiftUI**

**Rationale:**
- **Performance:** Native Swift ensures <50ms calculation updates (requirement met)
- **Simplicity:** Single-screen app doesn't need cross-platform complexity
- **Modern UI:** SwiftUI provides declarative, reactive UI perfect for real-time updates
- **Future-proof:** Latest iOS features, excellent tooling
- **App size:** Smaller binary than React Native
- **Offline-first:** No JavaScript bridge overhead

**Alternative Considered:** React Native
- **Pros:** Potential Android reuse, web dev familiarity
- **Cons:** Overhead for simple app, slower performance, larger bundle
- **Verdict:** Overkill for MVP

### Stack Details

| Layer | Technology | Justification |
|-------|------------|---------------|
| **UI Framework** | SwiftUI | Declarative, reactive, modern |
| **Language** | Swift 5.9+ | Type-safe, performant, native |
| **State Management** | @Observable + @State | Built-in, simple, sufficient |
| **Testing** | XCTest + XCUITest | Native testing framework |
| **CI/CD** | GitHub Actions + Fastlane | Standard iOS automation |
| **Min iOS Version** | iOS 16.0+ | SwiftUI features, 95% device coverage |

---

## 2. System Architecture

###  Component Architecture

```
┌─────────────────────────────────────────────┐
│           ClawTips App (iOS)                 │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  ContentView (SwiftUI)               │  │
│  │  - Bill Input                        │  │
│  │  - Tip Percentage Selector           │  │
│  │  - Split Controls                    │  │
│  │  - Results Display                   │  │
│  └──────────┬───────────────────────────┘  │
│             │                               │
│             ▼                               │
│  ┌──────────────────────────────────────┐  │
│  │  TipCalculator (ViewModel)           │  │
│  │  - @Published billAmount             │  │
│  │  - @Published tipPercentage          │  │
│  │  - @Published splitCount             │  │
│  │  - Computed: tipAmount               │  │
│  │  - Computed: totalAmount             │  │
│  │  - Computed: amountPerPerson         │  │
│  └──────────┬───────────────────────────┘  │
│             │                               │
│             ▼                               │
│  ┌──────────────────────────────────────┐  │
│  │  Calculation Engine (Pure Logic)     │  │
│  │  - calculateTip(bill, %)             │  │
│  │  - calculateTotal(bill, tip)         │  │
│  │  - splitBill(total, people)          │  │
│  │  - roundAmount(amount)               │  │
│  └──────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
```

### Architecture Pattern: MVVM (Model-View-ViewModel)

**View (SwiftUI):**
- `ContentView`: Main UI
- `BillInputView`: Numeric input field
- `TipSelectorView`: Percentage picker (slider + buttons)
- `SplitControlView`: Number of people selector
- `ResultsView`: Displays calculated amounts

**ViewModel (Observable):**
- `TipCalculator`: Reactive state management
- Publishes changes to View
- Calls pure calculation functions

**Model (Structs):**
- `TipResult`: Immutable calculation result
- `TipConfiguration`: Settings and preferences

---

## 3. Data Models

### Core Models

```swift
// MARK: - Calculation Result
struct TipResult {
    let billAmount: Decimal
    let tipPercentage: Int
    let splitCount: Int
    
    var tipAmount: Decimal {
        billAmount * Decimal(tipPercentage) / 100
    }
    
    var totalAmount: Decimal {
        billAmount + tipAmount
    }
    
    var amountPerPerson: Decimal {
        totalAmount / Decimal(splitCount)
    }
    
    var roundedTotal: Decimal {
        totalAmount.rounded(.up, scale: 0)
    }
}

// MARK: - View Model (State)
@Observable
class TipCalculator {
    var billAmount: Decimal = 0
    var tipPercentage: Int = 18  // Default 18%
    var splitCount: Int = 1      // Default 1 person
    var roundUpEnabled: Bool = false
    
    var result: TipResult {
        TipResult(
            billAmount: billAmount,
            tipPercentage: tipPercentage,
            splitCount: splitCount
        )
    }
}

// MARK: - Configuration
struct TipConfiguration {
    let quickTipOptions: [Int] = [15, 18, 20]
    let minTipPercentage: Int = 0
    let maxTipPercentage: Int = 30
    let minSplitCount: Int = 1
    let maxSplitCount: Int = 20
}
```

---

## 4. Component Structure

### File Organization

```
ClawTips/
├── App/
│   ├── ClawTipsApp.swift              // App entry point
│   └── ContentView.swift              // Main screen
├── ViewModels/
│   └── TipCalculator.swift            // State management
├── Views/
│   ├── Components/
│   │   ├── BillInputView.swift        // Bill amount input
│   │   ├── TipSelectorView.swift      // Tip % picker
│   │   ├── SplitControlView.swift     // Split count
│   │   └── ResultsView.swift          // Calculated amounts
│   └── Modifiers/
│       └── CurrencyFormatter.swift    // $ formatting
├── Models/
│   ├── TipResult.swift                // Calculation model
│   └── TipConfiguration.swift         // App config
├── Utilities/
│   ├── CalculationEngine.swift        // Pure calculation functions
│   └── CurrencyFormatter.swift        // Number formatting
├── Resources/
│   ├── Assets.xcassets                // Images, colors
│   └── Localizable.strings            // Text (future i18n)
└── Tests/
    ├── CalculationEngineTests.swift   // Unit tests
    └── TipCalculatorTests.swift       // ViewModel tests
```

---

## 5. State Management

### Approach: SwiftUI @Observable + @State

**Why:**
- Built-in to SwiftUI (no external dependencies)
- Automatic UI updates on state changes
- Simple for single-screen app
- Type-safe and compile-time verified

**Flow:**
1. User enters bill amount → `billAmount` updates
2. ViewModel recomputes `result` (computed property)
3. SwiftUI automatically re-renders affected Views
4. All updates happen on main thread (<50ms guaranteed)

**State Ownership:**
- `TipCalculator` is `@StateObject` in `ContentView`
- All child views receive `@ObservedObject` or individual `@Binding` properties
- No global state needed (single-screen app)

---

## 6. Key Technical Decisions

### Decision 1: Decimal vs Double

**Choice:** `Decimal` for all money calculations

**Rationale:**
- Avoids floating-point rounding errors
- Essential for financial calculations
- Example: `0.1 + 0.2 = 0.30000000000000004` (Double) vs `0.3` (Decimal)

### Decision 2: Computed Properties vs Stored State

**Choice:** Compute `tipAmount`, `totalAmount`, etc. on-demand

**Rationale:**
- Single source of truth (`billAmount`, `tipPercentage`, `splitCount`)
- No sync issues
- Performance: calculations are trivial (<1ms)

### Decision 3: No Data Persistence (MVP)

**Choice:** Fresh state on every app launch

**Rationale:**
- MVP requirement: no saved state
- Simplifies architecture
- Phase 2: Add `@AppStorage` for last-used tip % and split count

---

## 7. API / Public Interfaces

### CalculationEngine (Pure Functions)

```swift
enum CalculationEngine {
    /// Calculate tip amount
    static func calculateTip(bill: Decimal, percentage: Int) -> Decimal {
        bill * Decimal(percentage) / 100
    }
    
    /// Calculate total with tip
    static func calculateTotal(bill: Decimal, tip: Decimal) -> Decimal {
        bill + tip
    }
    
    /// Split total among people
    static func splitBill(total: Decimal, people: Int) -> Decimal {
        guard people > 0 else { return total }
        return total / Decimal(people)
    }
    
    /// Round up to nearest dollar
    static func roundUp(_ amount: Decimal) -> Decimal {
        amount.rounded(.up, scale: 0)
    }
}
```

**Why Pure Functions?**
- Testable without mocking
- Reusable across view models
- Thread-safe (no shared state)
- Easy to reason about

---

## 8. Testing Strategy

### Unit Tests (XCTest)

**Coverage Target:** >90%

**Test Files:**
1. `CalculationEngineTests.swift`
   - Test all calculation functions
   - Edge cases: $0 bill, 0% tip, 1 person split, max values
   - Precision tests: verify Decimal accuracy

2. `TipCalculatorTests.swift`
   - Test view model state updates
   - Test computed properties
   - Test user input validation

**Example Tests:**
```swift
func testTipCalculation() {
    let tip = CalculationEngine.calculateTip(bill: 100, percentage: 18)
    XCTAssertEqual(tip, 18.00)
}

func testSplitBill() {
    let perPerson = CalculationEngine.splitBill(total: 120, people: 4)
    XCTAssertEqual(perPerson, 30.00)
}

func testRoundingAccuracy() {
    let total: Decimal = 47.23
    let rounded = CalculationEngine.roundUp(total)
    XCTAssertEqual(rounded, 48.00)
}
```

### UI Tests (XCUITest)

**Coverage:** Critical user flows

1. **Test: Basic Calculation**
   - Enter bill amount
   - Select tip percentage
   - Verify tip and total display correctly

2. **Test: Bill Splitting**
   - Enter bill
   - Set split count
   - Verify per-person amount

3. **Test: Round Up**
   - Calculate tip
   - Enable round up
   - Verify rounded total

---

## 9. Performance Requirements

| Metric | Target | How We Achieve It |
|--------|--------|-------------------|
| **Calculation Speed** | <50ms | Pure Swift functions, no I/O |
| **UI Response** | <16ms | SwiftUI automatic diffing |
| **App Launch** | <1s | No network, minimal initialization |
| **Memory Usage** | <20MB | No images, simple view hierarchy |
| **Binary Size** | <5MB | Native Swift, no dependencies |

---

## 10. Security & Privacy

**No Data Collection:**
- No analytics in MVP
- No network requests
- No data persistence (no storage)
- No permissions required

**Privacy by Design:**
- All calculations happen on-device
- No PII (Personally Identifiable Information)
- No third-party SDKs

---

## 11. Build & Deployment

### CI/CD Pipeline (GitHub Actions)

```yaml
name: iOS CI

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Tests
        run: xcodebuild test -scheme ClawTips -destination 'platform=iOS Simulator,name=iPhone 15'
      - name: Check Coverage
        run: xcrun xccov view --report --json
  
  build:
    runs-on: macos-latest
    steps:
      - name: Build App
        run: xcodebuild -scheme ClawTips -configuration Release
```

### Fastlane Setup

```ruby
# Fastfile
lane :test do
  run_tests(scheme: "ClawTips")
end

lane :beta do
  increment_build_number
  build_app(scheme: "ClawTips")
  upload_to_testflight
end

lane :release do
  build_app(scheme: "ClawTips")
  upload_to_app_store
end
```

---

## 12. Migration Path (Future Enhancements)

### Phase 2: Persistence

**Approach:** `@AppStorage` for simple key-value storage

```swift
@AppStorage("defaultTipPercentage") var defaultTip: Int = 18
@AppStorage("defaultSplitCount") var defaultSplit: Int = 1
```

### Phase 3: Advanced Features

**When adding:**
- Uneven splits → Introduce `SplitConfiguration` model
- Tax calculation → Add `taxPercentage` property
- History → CoreData or SwiftData for storage

---

## 13. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Calculation errors | Low | High | Extensive unit tests + Decimal precision |
| UI performance | Low | Medium | SwiftUI optimized for simple views |
| Platform fragmentation | Low | Low | iOS 16+ covers 95% devices |
| Scope creep | High | Medium | Strict MVP definition in PRD |

---

## 14. Dependencies

**External Libraries:** NONE

**Why No Dependencies:**
- Reduces binary size
- No security vulnerabilities from third parties
- No license concerns
- Faster builds
- Easier maintenance

**Native iOS Frameworks:**
- Foundation (Decimal, String formatting)
- SwiftUI (UI framework)
- Combine (reactive state, if needed)

---

## 15. Accessibility

**Minimum Standards:** WCAG AA

**Implementation:**
- All buttons have `.accessibilityLabel()`
- Input fields have `.accessibilityHint()`
- Results use `.accessibilityValue()`
- Support Dynamic Type (text scaling)
- VoiceOver navigation order

---

## 16. Localization (Future)

**MVP:** English only

**Phase 2+:**
- Currency symbols (€, £, ¥, etc.)
- Number formatting (1,000.00 vs 1.000,00)
- Localizable.strings for text
- Region-specific tip defaults

---

## 17. Next Steps

1. **For Engineer:**
   - Create Xcode project
   - Implement `CalculationEngine` with tests
   - Build `TipCalculator` view model
   - Create SwiftUI views
   - Wire up state bindings

2. **For QA:**
   - Review calculation test cases
   - Prepare test matrix for edge cases
   - Set up TestFlight for beta testing

3. **For DevOps:**
   - Create GitHub repo
   - Set up GitHub Actions CI
   - Configure Fastlane for builds
   - Prepare App Store Connect

---

## Architecture Review Checklist

- [x] Technology stack chosen with clear rationale
- [x] Architecture pattern defined (MVVM)
- [x] Data models documented
- [x] Component structure organized
- [x] State management approach defined
- [x] Performance targets specified
- [x] Testing strategy outlined
- [x] Security/privacy considered
- [x] Build/deployment plan included
- [x] Future extensibility addressed

---

**Status:** ✅ Ready for implementation

**Estimated Implementation Time:** 2-3 weeks

**Next Document:** Engineer implementation plan + code structure
