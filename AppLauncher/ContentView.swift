import SwiftUI

/// A TV-style home screen: dark background, a top bar with the time,
/// a large featured banner, and rows of wide app cards that scroll sideways.
struct ContentView: View {
    @State private var featuredIndex = 0
    private let featured = AppCatalog.apps.filter { $0.category == .streaming }
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(white: 0.10), .black],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    TopBar()

                    if !featured.isEmpty {
                        FeaturedBanner(app: featured[featuredIndex % featured.count])
                            .animation(.easeInOut(duration: 0.5), value: featuredIndex)
                    }

                    ForEach(AppCategory.allCases) { category in
                        let apps = AppCatalog.apps.filter { $0.category == category }
                        if !apps.isEmpty {
                            AppRow(title: category.rawValue, apps: apps)
                        }
                    }

                    AppStoreCard()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .preferredColorScheme(.dark)
        .onReceive(timer) { _ in featuredIndex += 1 }
    }
}

// MARK: - Top bar

private struct TopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
                .font(.title2)
            Text("Home")
                .font(.title2.bold())
            Spacer()
            TimelineView(.everyMinute) { context in
                Text(context.date, style: .time)
                    .font(.title3.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}

// MARK: - Featured banner

private struct FeaturedBanner: View {
    let app: LaunchApp

    var body: some View {
        Button { AppOpener.open(app) } label: {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(app.color.gradient)
                    .overlay(alignment: .trailing) {
                        Image(systemName: app.symbol)
                            .font(.system(size: 120))
                            .foregroundStyle(.white.opacity(0.25))
                            .padding(.trailing, 24)
                    }

                VStack(alignment: .leading, spacing: 8) {
                    Text("FEATURED")
                        .font(.caption.bold())
                        .foregroundStyle(.white.opacity(0.8))
                    Text(app.name)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Label("Open", systemImage: "play.fill")
                        .font(.headline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.white, in: Capsule())
                        .foregroundStyle(.black)
                }
                .padding(20)
            }
            .frame(height: 200)
            .id(app.id)
            .transition(.opacity)
        }
        .buttonStyle(TVCardStyle())
        .padding(.horizontal)
    }
}

// MARK: - Rows

private struct AppRow: View {
    let title: String
    let apps: [LaunchApp]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(apps) { app in
                        AppCard(app: app)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
        }
    }
}

/// A wide, landscape app card like the tiles on a TV home screen.
private struct AppCard: View {
    let app: LaunchApp

    var body: some View {
        Button { AppOpener.open(app) } label: {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(app.color.gradient)
                    .frame(width: 180, height: 101) // 16:9
                    .overlay {
                        Image(systemName: app.symbol)
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(.white.opacity(0.12))
                    }
                Text(app.name)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
                    .lineLimit(1)
            }
        }
        .buttonStyle(TVCardStyle())
    }
}

private struct AppStoreCard: View {
    var body: some View {
        Button {
            if let url = URL(string: "itms-apps://apple.com/app") {
                UIApplication.shared.open(url)
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "plus.app.fill")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("Get more apps").font(.headline)
                    Text("Open the App Store").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color(white: 0.18), in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(TVCardStyle())
    }
}

// MARK: - Press effect

/// Grows the card and adds a glow while pressed, like TV "focus".
private struct TVCardStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.06 : 1.0)
            .shadow(color: .white.opacity(configuration.isPressed ? 0.35 : 0), radius: 12)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Opening apps

enum AppOpener {
    /// Open the installed app; if it isn't installed, open its App Store page.
    static func open(_ app: LaunchApp) {
        guard let schemeURL = app.schemeURL else { openStore(app); return }
        UIApplication.shared.open(schemeURL, options: [:]) { success in
            if !success { openStore(app) }
        }
    }

    private static func openStore(_ app: LaunchApp) {
        if let url = app.appStoreURL {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ContentView()
}
