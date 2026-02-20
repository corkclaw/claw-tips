# Claw Tips - Product Requirements Document

**Version:** 1.0  
**Date:** February 19, 2026  
**Product Manager:** PM  
**Status:** Planning

---

## 1. Product Overview

**Claw Tips** is a simple, elegant tipping calculator designed to help users quickly calculate tips and split bills with friends. The app removes the awkwardness of mental math at restaurants and ensures everyone pays their fair share.

### Goals

- **Primary:** Provide the fastest way to calculate tips and split bills
- **Secondary:** Reduce friction in group dining situations
- **Tertiary:** Build brand recognition for future Claw Suite products

### Success Metrics

- Time to complete calculation: < 10 seconds
- User retention: 30% monthly active users
- App Store rating: 4.5+ stars
- Net Promoter Score: > 40

---

## 2. Target Users & Use Cases

### Primary Users

**"Social Sarah" (25-40, Frequent Diner)**
- Eats out 2-3x per week with friends
- Values speed and accuracy
- Often splits bills with groups
- Wants to appear generous but fair

**"Business Bob" (30-55, Professional)**
- Expense reports require accuracy
- Tips consistently (18-20%)
- Occasionally splits with colleagues
- Values professionalism and simplicity

### Key Use Cases

1. **Quick Solo Tip:** Calculate 20% tip on personal meal in under 5 seconds
2. **Group Split:** Divide bill among 4 friends, each paying equal tip
3. **Custom Tipping:** Adjust tip percentage based on service quality
4. **Round Up:** Round final amount to whole dollar for easy payment

---

## 3. User Stories & Acceptance Criteria

### Epic: Core Calculation

#### US-001: Calculate Basic Tip

**As a** restaurant patron  
**I want** to enter my bill amount and see tip suggestions  
**So that** I know how much to leave without doing mental math

**Acceptance Criteria:**
- [ ] User can enter bill amount via numeric keypad
- [ ] App displays tip amounts for 15%, 18%, and 20%
- [ ] App displays total (bill + tip) for each percentage
- [ ] Calculations update in real-time as user types
- [ ] All amounts display with 2 decimal places (e.g., $12.34)
- [ ] App handles decimal inputs correctly

**Priority:** P0 (MVP Blocker)

---

#### US-002: Custom Tip Percentage

**As a** user who wants to tip based on service quality  
**I want** to adjust the tip percentage  
**So that** I can tip more or less than standard amounts

**Acceptance Criteria:**
- [ ] User can adjust tip percentage via slider (0% - 30%)
- [ ] Tip percentage displays as whole number (e.g., "18%")
- [ ] Calculated tip and total update immediately
- [ ] Slider has clear visual feedback
- [ ] User can also enter exact percentage via text input

**Priority:** P0 (MVP Blocker)

---

### Epic: Bill Splitting

#### US-003: Split Bill Evenly

**As a** diner sharing a meal with friends  
**I want** to split the total bill evenly among multiple people  
**So that** everyone pays their fair share including tip

**Acceptance Criteria:**
- [ ] User can select number of people (2-20)
- [ ] App displays amount per person including tip
- [ ] Split calculation respects selected tip percentage
- [ ] Per-person amount rounds to 2 decimal places
- [ ] Total amount across all people equals bill + tip (accounting for rounding)

**Priority:** P0 (MVP Blocker)

---

#### US-004: Round Up Final Amount

**As a** user paying with cash  
**I want** to round the total to the nearest dollar  
**So that** payment is easier

**Acceptance Criteria:**
- [ ] User can toggle "Round Up" option
- [ ] Rounded amount always rounds UP to next whole dollar
- [ ] Display shows both exact and rounded amounts clearly
- [ ] Rounded amount affects per-person calculation when splitting
- [ ] Toggle state is visually clear (on/off)

**Priority:** P1 (High Value)

---

### Epic: User Experience

#### US-005: Quick Access to Common Tips

**As a** user in a hurry  
**I want** to tap a button for common tip percentages  
**So that** I don't need to adjust the slider

**Acceptance Criteria:**
- [ ] Quick-select buttons for 15%, 18%, 20%
- [ ] Selected button is visually highlighted
- [ ] Tapping button updates calculations immediately
- [ ] Custom percentage remains visible but not highlighted

**Priority:** P1 (High Value)

---

#### US-006: Clear and Reset Input

**As a** user who made a mistake  
**I want** to quickly clear my input  
**So that** I can start over

**Acceptance Criteria:**
- [ ] Clear button visible when bill amount is entered
- [ ] Tapping clear resets bill to $0
- [ ] Tip percentage and split count are NOT reset
- [ ] Visual feedback confirms clear action

**Priority:** P2 (Nice to Have)

---

#### US-007: Dark Mode Support

**As a** user in a dimly lit restaurant  
**I want** the app to support dark mode  
**So that** it's easier on my eyes

**Acceptance Criteria:**
- [ ] App respects system dark mode setting
- [ ] All text remains readable in dark mode
- [ ] Color contrast meets WCAG AA standards
- [ ] Buttons and interactive elements are clearly visible

**Priority:** P2 (Nice to Have)

---

## 4. Feature Priorities

### MVP (Minimum Viable Product)
**Target: 4 weeks**

**Must Have:**
- Bill amount input with numeric keypad
- Tip percentage selector (slider + quick buttons for 15%, 18%, 20%)
- Real-time calculation display (tip amount + total)
- Bill splitting (2-20 people)
- Per-person amount display
- Clean, intuitive single-screen UI

**MVP Scope:**
- iOS only (start with iPhone, adapt to iPad)
- Portrait orientation only
- English language only
- No data persistence (fresh state on launch)

---

### Phase 2: Enhanced Experience
**Target: 8 weeks post-MVP**

**Nice to Have:**
- Round up feature
- Clear/reset button
- Dark mode support
- Landscape orientation support
- Calculator-style input (for complex bills)
- Tip history (last 10 calculations)

---

### Phase 3: Advanced Features
**Target: 16 weeks post-MVP**

**Future Enhancements:**
- Uneven split (e.g., "I only had appetizer")
- Tax calculation (enter pre-tax amount)
- Multiple tip options side-by-side comparison
- Custom tip presets (save favorite percentages)
- Share result (text/image for group chat)
- Multiple currency support
- Android version
- Tip guide by country/region
- Accessibility features (VoiceOver optimization)

---

## 5. Design Principles

1. **Speed First:** Users should complete calculation in under 10 seconds
2. **Zero Learning Curve:** Interface should be self-explanatory
3. **Large Touch Targets:** Easy to use in dim lighting, awkward positions
4. **Immediate Feedback:** Every input should update results instantly
5. **Minimal Chrome:** Focus on the numbers, reduce visual noise

---

## 6. Technical Considerations

### For Discussion with Architect:
- Offline-first design (no network required)
- Performance: sub-50ms calculation updates
- Platform: iOS first, React Native vs Swift
- State management approach
- Testing strategy for calculations

### For Discussion with QA:
- Edge cases: $0 bill, $999,999.99 bill, 0% tip, 1 person split
- Rounding accuracy across all calculations
- Accessibility testing requirements
- Device/OS version support matrix

---

## 7. Open Questions

1. **Minimum iOS version support?** (Affects design system choices)
2. **Monetization strategy?** (Free with ads? Premium? Freemium?)
3. **Analytics requirements?** (What do we track?)
4. **Localization timeline?** (When do we support other languages?)
5. **Branding consistency?** (Fits with other Claw Suite products?)

---

## 8. Dependencies & Risks

### Dependencies
- Design system/brand guidelines from marketing
- App Store account and deployment process
- Analytics platform decision

### Risks
- **Market saturation:** Many tip calculators exist (Mitigation: Focus on speed and simplicity)
- **Low engagement:** Users might only use once (Mitigation: Make it SO good they delete others)
- **Scope creep:** Feature requests will be endless (Mitigation: Strict MVP discipline)

---

## 9. Timeline

| Milestone | Target Date | Deliverables |
|-----------|-------------|--------------|
| Kickoff | Week 1 | PRD approval, tech design doc |
| Design Review | Week 2 | UI mockups, user flow |
| Dev Start | Week 2 | Architecture complete |
| Alpha | Week 3 | Internal testing build |
| Beta | Week 4 | TestFlight for friends & family |
| MVP Launch | Week 6 | App Store submission |

---

## 10. Success Criteria

**MVP is successful if:**
- 100 organic downloads in first week
- Average calculation time < 10 seconds
- Zero critical bugs reported
- 4+ star average rating
- Positive feedback from beta testers

**Ready for Phase 2 if:**
- 1,000+ total downloads
- 25%+ retention after 7 days
- Clear feature request patterns emerge
- Technical foundation is solid

---

## Appendix: Competitive Analysis

| App | Strengths | Weaknesses | Our Advantage |
|-----|-----------|------------|---------------|
| Tip Calculator | Clean design | Slow input | Faster UX |
| Splitwise | Group bills | Too complex for tips | Single-purpose focus |
| Built-in calc | Always there | Manual calculation | Automatic tip % |

---

**Next Steps:**
1. Review this PRD with stakeholders
2. Schedule design kickoff with UX team
3. Technical feasibility review with Architect
4. Create project in issue tracker
5. Begin user story breakdown for sprint planning
