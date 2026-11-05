# AppLauncher (iPhone)

A simple SwiftUI iPhone app that works like a home-screen launcher:

- A big **Open the App Store** button.
- A grid of app tiles. Tap a tile to **open that app** if it's installed; if it
  isn't, it **opens that app's App Store page** so you can download it.

> **Note on the Samsung TV:** an iPhone app can't reboot, reset, or re-flash a
> Samsung TV — iOS apps are sandboxed and TVs don't accept that kind of command
> from a phone. The official way to control/cast to a Samsung Smart TV from an
> iPhone is Samsung's **SmartThings** app, so it's the first tile in the grid.
> To reset a Samsung TV to its original state, use the TV's own menu:
> *Settings → General → Reset* (or *Support → Self Diagnosis → Reset*).

## Requirements

- A Mac with **Xcode 15 or newer** (iOS apps can only be built on macOS).
- To run on a real iPhone you need a free Apple ID for signing; the Simulator
  needs no account.

## Open & run

1. Open `AppLauncher.xcodeproj` in Xcode.
2. Select a Simulator (e.g. *iPhone 15*) or your connected iPhone.
3. If building to a device: select the **AppLauncher** target → *Signing &
   Capabilities* → pick your Apple ID team and change the Bundle Identifier to
   something unique (e.g. `com.yourname.AppLauncher`).
4. Press **Run** (⌘R).

## Customize the app list

Edit `AppLauncher/AppCatalog.swift`. Each tile is one `LaunchApp`:

```swift
LaunchApp(name: "YouTube", scheme: "youtube://", appStoreID: "544007664",
          symbol: "play.rectangle.fill", color: .red)
```

- `scheme` — the app's URL scheme (opens it if installed).
- `appStoreID` — the numeric App Store id (used as the download fallback).
- `symbol` — any [SF Symbol](https://developer.apple.com/sf-symbols/) name.

If you add a new app, also add its scheme (without `://`) to
`LSApplicationQueriesSchemes` in `AppLauncher/Info.plist`, otherwise iOS won't
report whether it's installed.

## Files

| File | Purpose |
|------|---------|
| `AppLauncherApp.swift` | App entry point |
| `ContentView.swift` | The grid UI + App Store button |
| `AppCatalog.swift` | The editable list of apps |
| `Info.plist` | App config + allowed URL schemes |
