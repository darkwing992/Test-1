import SwiftUI

/// A single launchable app tile.
struct LaunchApp: Identifiable {
    let id = UUID()
    let name: String
    /// The custom URL scheme used to open the app if it is installed, e.g. "youtube://".
    let scheme: String
    /// The numeric App Store identifier, used to open the App Store page as a fallback.
    let appStoreID: String
    /// An SF Symbol name used as the tile icon.
    let symbol: String
    /// Tile tint color.
    let color: Color
    /// Which row the app appears in on the TV-style home screen.
    var category: AppCategory = .streaming

    /// The deep-link URL that opens the installed app.
    var schemeURL: URL? { URL(string: scheme) }

    /// The App Store URL used when the app is not installed.
    var appStoreURL: URL? {
        URL(string: "itms-apps://itunes.apple.com/app/id\(appStoreID)")
    }
}

/// The rows shown on the TV-style home screen, in order.
enum AppCategory: String, CaseIterable, Identifiable {
    case tv = "TV & Casting"
    case streaming = "Streaming"
    case music = "Music"
    case social = "Social"
    case tools = "Tools"

    var id: String { rawValue }
}

/// The curated list of apps shown on the launcher grid.
///
/// SmartThings is included first because it is Samsung's official iPhone app
/// for controlling and casting to Samsung Smart TVs.
enum AppCatalog {
    static let apps: [LaunchApp] = [
        LaunchApp(name: "SmartThings", scheme: "smartthings://", appStoreID: "1222333548", symbol: "tv.badge.wifi", color: .blue, category: .tv),
        LaunchApp(name: "YouTube",     scheme: "youtube://",     appStoreID: "544007664",  symbol: "play.rectangle.fill", color: .red, category: .streaming),
        LaunchApp(name: "Netflix",     scheme: "nflx://",        appStoreID: "363590051",  symbol: "film.fill", color: .red, category: .streaming),
        LaunchApp(name: "Disney+",     scheme: "disneyplus://",  appStoreID: "1446075923", symbol: "sparkles.tv.fill", color: .indigo, category: .streaming),
        LaunchApp(name: "Spotify",     scheme: "spotify://",     appStoreID: "324684580",  symbol: "music.note", color: .green, category: .music),
        LaunchApp(name: "Twitch",      scheme: "twitch://",      appStoreID: "460177396",  symbol: "gamecontroller.fill", color: .purple, category: .streaming),
        LaunchApp(name: "Instagram",   scheme: "instagram://",   appStoreID: "389801252",  symbol: "camera.fill", color: .pink, category: .social),
        LaunchApp(name: "TikTok",      scheme: "tiktok://",      appStoreID: "835599320",  symbol: "music.mic", color: .black, category: .social),
        LaunchApp(name: "WhatsApp",    scheme: "whatsapp://",    appStoreID: "310633997",  symbol: "message.fill", color: .green, category: .social),
        LaunchApp(name: "Gmail",       scheme: "googlegmail://", appStoreID: "422689480",  symbol: "envelope.fill", color: .red, category: .tools),
        LaunchApp(name: "Maps",        scheme: "maps://",        appStoreID: "915056765",  symbol: "map.fill", color: .teal, category: .tools),
        LaunchApp(name: "X",           scheme: "twitter://",     appStoreID: "333903271",  symbol: "bird.fill", color: .black, category: .social)
    ]
}
