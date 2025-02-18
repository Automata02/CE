# CE (Country Encyclopedia) iOS App

A Swift-based iOS application that provides detailed information about countries worldwide, utilizing the REST Countries API.

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 6+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/automata02/CE
```


## Build and Run

1. Open `CE.xcodeproj` in Xcode
2. Select your target device/simulator
3. Press Run (⌘R) or click the Play button

## Features

- Search countries by name and native translations
- Detailed country information including:
- Official and common names
- Country codes
- Population statistics with global ranking
- Flag display (emoji in list, API flags in details)
- Interactive map locations
- Language information with cross-referencing
- Neighboring countries with navigation
- Favorite country management with persistence
- Modern SwiftUI interface
- Native iOS map integration

## Additional Information

### APIs
- All data is fetched from public APIs
- No API key required
- Rate limiting may apply

### Data Privacy
- No personal data is collected
- Favorites are stored locally only - UserDefaults
- No network caching implemented

### Accessibility
- Supports Dynamic Type
- VoiceOver compatible
- Follows iOS Human Interface Guidelines

### Device Support
- Optimized for iPhone
- Supports both portrait and landscape orientations
- Supports iOS system dark mode

### Known Limitations
- No offline support
- Some country data might be incomplete depending on API response
- Map view requires internet connection
