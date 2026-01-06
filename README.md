# Hybrid Performance Dashboard

A premium SwiftUI app showcasing an athlete's hybrid performance across 8 domains with a clean, dark-themed interface.

## Project Structure

```
hybride/
├── HybridApp.swift                 # Main app entry point
├── ContentView.swift               # Tab bar navigation
│
├── Models/
│   ├── HybridDomain.swift          # Domain data model (8 performance domains)
│   ├── HybridSnapshot.swift        # Historical snapshot model
│   └── LeaderboardEntry.swift      # Leaderboard entry model
│
├── Views/
│   ├── HybridDashboardView.swift   # Main dashboard with 4 tabs
│   └── DomainDetailView.swift      # Detail view for individual domains
│
├── Components/
│   ├── PremiumSegmentedControl.swift  # Custom tab switcher
│   ├── HybridScoreHeader.swift        # Dashboard header
│   ├── HybridScoreCard.swift          # Large score display card
│   ├── DomainCard.swift               # Compact domain performance card
│   ├── LeaderboardRow.swift           # Leaderboard list row
│   ├── HistoryRow.swift               # History timeline row
│   └── RadarChartView.swift           # 8-domain radar chart visualization
│
└── Services/
    ├── ScoringService.swift        # Score calculation logic
    └── MockDataService.swift       # Mock data generation
```

## Features

### 4 Main Tabs

1. **Overview**
   - Large hybrid score card (0-100)
   - Interpretation badge (Bronze/Silver/Gold/Elite)
   - Radar chart visualization of 8 domains
   - Quick stats: strongest/weakest domain, rank percentile

2. **Domains**
   - List of 8 domain cards
   - Each card shows: name, metric value, points (0-100), progress bar
   - Tap to view detailed information and improvement tips

3. **Ranking**
   - Leaderboard showing user position ±5 athletes
   - Mock filter buttons (Age Group, Weight Class, Location)
   - Position change indicators

4. **History**
   - Timeline of historical scores
   - Date, score, badge display
   - Trend indicators (up/down arrows)

### 8 Performance Domains

1. Powerlifting SBD (normalized by bodyweight)
2. 10km Run (time)
3. 5km Run (time)
4. 100m Sprint (time)
5. Strict Pull-ups (reps)
6. Triathlon M (total time: 1.5km swim + 40km bike + 10km run)
7. 400m Freestyle Swim (time)
8. HYROX Full (official total time)

## Design

- **Theme**: Premium dark (near-black background, subtle gradients)
- **Typography**: System fonts with proper weight hierarchy
- **Colors**: High contrast with blue/purple gradient accents
- **Animations**: Spring animations for tab switches, card taps, progress bars
- **Components**: Fully reusable and componentized

## Usage

1. Open the project in Xcode
2. Build and run on iOS 15+ simulator or device
3. Navigate to the "Hybrid" tab in the tab bar
4. Explore the 4 tabs: Overview, Domains, Ranking, History
5. Tap domain cards to view detailed information and improvement tips

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- SwiftUI

## Architecture

- **MVVM-ready**: Models separated from views
- **Component-based**: Reusable UI components
- **Service layer**: Scoring and data services
- **Mock data**: Fully functional with placeholder data
- **Pure SwiftUI**: No external dependencies

## Customization

All components are designed to be easily customizable:

- Colors and gradients in component files
- Scoring algorithm in `ScoringService`
- Mock data generation in `MockDataService`
- Domain definitions in model files

## Future Enhancements

- Real data integration
- User authentication
- Backend API connectivity
- Advanced analytics
- Social sharing
- Push notifications


