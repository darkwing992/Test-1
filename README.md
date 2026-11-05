# AppLauncher (iPhone)

A SwiftUI iPhone app with a **TV-style home screen**:

- Dark background, a top bar with the time, and a big **featured banner** that
  rotates through your streaming apps.
- **Rows of wide app cards** (TV & Casting, Streaming, Music, Social, Tools)
  that scroll sideways, with a grow-and-glow effect when pressed.
- A **Get more apps** card that opens the App Store.
- Every card Tap a tile to **open that app** if it's installed; if it
  isn't, it **opens that app's App Store page** so you can download it.

> This is an original TV-style look built for the iPhone. It doesn't copy the
> real interface from any TV stick: that software is locked to the stick's
> hardware and can't be downloaded or installed on an iPhone.

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
          symbol: "play.rectangle.fill", color: .red, category: .streaming)
```

- `scheme` — the app's URL scheme (opens it if installed).
- `appStoreID` — the numeric App Store id (used as the download fallback).
- `category` — which row it appears in (`.tv`, `.streaming`, `.music`,
  `.social`, `.tools`).
- `symbol` — any [SF Symbol](https://developer.apple.com/sf-symbols/) name.

If you add a new app, also add its scheme (without `://`) to
`LSApplicationQueriesSchemes` in `AppLauncher/Info.plist`, otherwise iOS won't
report whether it's installed.

## Files

| File | Purpose |
|------|---------|
| `AppLauncherApp.swift` | App entry point |
| `ContentView.swift` | The TV-style home screen (banner, rows, cards) |
| `AppCatalog.swift` | The editable list of apps |
| `Info.plist` | App config + allowed URL schemes |
