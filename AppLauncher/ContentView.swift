import SwiftUI

struct ContentView: View {
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 16)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    appStoreButton

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(AppCatalog.apps) { app in
                            AppTile(app: app)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Launcher")
        }
    }

    /// A prominent button that opens the App Store directly.
    private var appStoreButton: some View {
        Button {
            if let url = URL(string: "itms-apps://apple.com/app") {
                UIApplication.shared.open(url)
            }
        } label: {
            HStack {
                Image(systemName: "bag.fill")
                    .font(.title2)
                Text("Open the App Store")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.gradient, in: RoundedRectangle(cornerRadius: 16))
            .foregroundStyle(.white)
        }
        .padding(.horizontal)
    }
}

/// A tappable tile that opens an app if installed, or its App Store page otherwise.
struct AppTile: View {
    let app: LaunchApp

    var body: some View {
        Button {
            open()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: app.symbol)
                    .font(.system(size: 34))
                    .frame(width: 72, height: 72)
                    .background(app.color.gradient, in: RoundedRectangle(cornerRadius: 18))
                    .foregroundStyle(.white)
                Text(app.name)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }

    /// Try to open the installed app; if it is not installed, open its App Store page.
    private func open() {
        guard let schemeURL = app.schemeURL else { openAppStore(); return }

        UIApplication.shared.open(schemeURL, options: [:]) { success in
            if !success { openAppStore() }
        }
    }

    private func openAppStore() {
        if let url = app.appStoreURL {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ContentView()
}
