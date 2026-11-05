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

    /// The deep-link URL that opens the installed app.
    var schemeURL: URL? { URL(string: scheme) }

    /// The App Store URL used when the app is not installed.
    var appStoreURL: URL? {
        URL(string: "itms-apps://itunes.apple.com/app/id\(appStoreID)")
    }
}

/// The curated list of apps shown on the launcher grid.
///
/// SmartThings is included first because it is Samsung's official iPhone app
/// for controlling and casting to Samsung Smart TVs.
enum AppCatalog {
    static let apps: [LaunchApp] = [
        LaunchApp(name: "SmartThings", scheme: "smartthings://", appStoreID: "1222333548", symbol: "tv.badge.wifi", color: .blue),
        LaunchApp(name: "YouTube",     scheme: "youtube://",     appStoreID: "544007664",  symbol: "play.rectangle.fill", color: .red),
        LaunchApp(name: "Netflix",     scheme: "nflx://",        appStoreID: "363590051",  symbol: "film.fill", color: .red),
        LaunchApp(name: "Disney+",     scheme: "disneyplus://",  appStoreID: "1446075923", symbol: "sparkles.tv.fill", color: .indigo),
        LaunchApp(name: "Spotify",     scheme: "spotify://",     appStoreID: "324684580",  symbol: "music.note", color: .green),
        LaunchApp(name: "Twitch",      scheme: "twitch://",      appStoreID: "460177396",  symbol: "gamecontroller.fill", color: .purple),
        LaunchApp(name: "Instagram",   scheme: "instagram://",   appStoreID: "389801252",  symbol: "camera.fill", color: .pink),
        LaunchApp(name: "TikTok",      scheme: "tiktok://",      appStoreID: "835599320",  symbol: "music.mic", color: .black),
        LaunchApp(name: "WhatsApp",    scheme: "whatsapp://",    appStoreID: "310633997",  symbol: "message.fill", color: .green),
        LaunchApp(name: "Gmail",       scheme: "googlegmail://", appStoreID: "422689480",  symbol: "envelope.fill", color: .red),
        LaunchApp(name: "Maps",        scheme: "maps://",        appStoreID: "915056765",  symbol: "map.fill", color: .teal),
        LaunchApp(name: "X",           scheme: "twitter://",     appStoreID: "333903271",  symbol: "bird.fill", color: .black)
    ]
}
