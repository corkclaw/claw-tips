# Claw Tips 🦀

A simple, elegant tipping calculator for iOS.

## Overview

Claw Tips helps users quickly calculate tips and split bills with friends. Built with Swift and SwiftUI, it's designed to be the fastest way to figure out the tip at a restaurant.

## Features (MVP)

- **Bill Input:** Enter your bill amount
- **Tip Calculation:** Quick-select 15%, 18%, or 20% tips
- **Custom Tip:** Adjust tip percentage with slider (0-30%)
- **Bill Splitting:** Split total among 2-20 people
- **Real-time Updates:** See tip and total instantly

## Tech Stack

- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI
- **Min iOS Version:** iOS 16.0+
- **Architecture:** MVVM (Model-View-ViewModel)
- **Testing:** XCTest + XCUITest

## Project Structure

```
ClawTips/
├── App/                    # App entry point
├── ViewModels/             # State management
├── Views/                  # SwiftUI views
├── Models/                 # Data models
├── Utilities/              # Helpers & extensions
└── Tests/                  # Unit & UI tests
```

## Documentation

- [Product Requirements Document](docs/claw-tips-prd.md)
- [Technical Architecture](docs/claw-tips-architecture.md)

## Getting Started

### Prerequisites

- Xcode 15+
- macOS 14+ (Sonoma or later)
- iOS 16+ device or simulator

### Setup

1. Clone the repository
   ```bash
   git clone https://github.com/YOUR_USERNAME/claw-tips.git
   cd claw-tips
   ```

2. Open in Xcode
   ```bash
   open ClawTips.xcodeproj
   ```

3. Build and run
   - Select iOS Simulator
   - Press `Cmd+R`

## Development

### Running Tests

```bash
# All tests
xcodebuild test -scheme ClawTips -destination 'platform=iOS Simulator,name=iPhone 15'

# Unit tests only
xcodebuild test -scheme ClawTips -only-testing:ClawTipsTests

# UI tests only
xcodebuild test -scheme ClawTips -only-testing:ClawTipsUITests
```

### Code Style

- Follow Swift API Design Guidelines
- Use SwiftLint for consistency
- Write tests for all business logic

## Deployment

### TestFlight (Beta)

```bash
fastlane beta
```

### App Store

```bash
fastlane release
```

## Team

- **Product Manager:** PM (requirements, user stories)
- **Architect:** Arc (system design, technical specs)
- **Engineer:** Dev (implementation, testing)
- **QA:** QA (quality assurance, test plans)
- **DevOps:** Ops (CI/CD, deployment)

## Timeline

- **Week 1-2:** Design & setup
- **Week 3-4:** Core implementation
- **Week 5:** Testing & polish
- **Week 6:** App Store submission

## License

Copyright © 2026 Claw Suite. All rights reserved.

## Contact

For questions or support, contact: corkonian@gmail.com
