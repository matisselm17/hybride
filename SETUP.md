# Setup Instructions

## Adding Files to Xcode Project

Since the files were created in the root directory, you'll need to add them to your Xcode project:

### Option 1: Drag and Drop (Recommended)

1. Open `hybride.xcodeproj` in Xcode
2. Right-click on the `hybride` folder in the Project Navigator
3. Select "Add Files to 'hybride'..."
4. Navigate to the workspace root (`/Users/matisselemao/Desktop/hybride`)
5. Select the following folders/files:
   - `Models/` folder (add as a group, create folder references if needed)
   - `Views/` folder (add as a group)
   - `Components/` folder (add as a group)
   - `Services/` folder (add as a group)
6. Make sure "Copy items if needed" is **unchecked** (files are already in place)
7. Select "Create groups" and ensure your target is selected
8. Click "Add"

### Option 2: Manual File Addition

For each file:
1. Right-click on the `hybride` folder in Project Navigator
2. Select "Add Files to 'hybride'..."
3. Select the individual Swift files
4. Ensure target membership is checked

### File Structure in Xcode

After adding, your project should look like:

```
hybride (project)
├── hybride (target)
│   ├── Assets.xcassets
│   ├── hybrideApp.swift
│   ├── ContentView.swift (updated)
│   ├── Models/
│   │   ├── HybridDomain.swift
│   │   ├── HybridSnapshot.swift
│   │   └── LeaderboardEntry.swift
│   ├── Views/
│   │   ├── HybridDashboardView.swift
│   │   └── DomainDetailView.swift
│   ├── Components/
│   │   ├── PremiumSegmentedControl.swift
│   │   ├── HybridScoreHeader.swift
│   │   ├── HybridScoreCard.swift
│   │   ├── DomainCard.swift
│   │   ├── LeaderboardRow.swift
│   │   ├── HistoryRow.swift
│   │   └── RadarChartView.swift
│   └── Services/
│       ├── ScoringService.swift
│       └── MockDataService.swift
```

### Verify Build

1. Clean build folder (Shift + Cmd + K)
2. Build project (Cmd + B)
3. Run (Cmd + R)

The app should compile and run, showing the Hybrid dashboard as the first tab.

## Notes

- All files are pure SwiftUI with no external dependencies
- Works on iOS 15.0+
- Dark mode is enforced via `.preferredColorScheme(.dark)`
- Mock data is included for immediate testing

