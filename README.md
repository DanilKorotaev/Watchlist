# Watchlist

SwiftUI app for a personal movie watchlist: list, details, add flow, planned watch date, and favorites tab.

## Requirements

- Xcode 15+
- iOS 17+

## Run

```bash
xcodegen generate
open Watchlist.xcodeproj
```

Or open the generated `Watchlist.xcodeproj` directly.

## Lecture tags

| Tag | Focus |
|---|---|
| `step-01-monolith` | Everything in one file |
| `step-02-store` | Models + store; genre display split from `rawValue` |
| `step-03-views` | Row + list |
| `step-04-details` | Detail screen (thick body) |
| `step-05-readable-sections` | Detail broken into sections / buttons |
| `step-06-detail-viewmodel` | Detail actions via ViewModel |
| `step-07-add-via-store` | Add screen writes into shared store |
| `step-08-add-viewmodel` | Add form state in ViewModel |
| `step-09-date-picker` | Reusable date picker with callback |
| `step-10-list-viewmodel` | List ViewModel + interactive row actions |
| `step-11-tabs` | Tabs with all / favorites filter |
