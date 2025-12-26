import SwiftUI

// MARK: - Models

enum MusicTab: Hashable, Identifiable {
    case listenNow
    case radio
    case search
    case browse
    case library(LibraryTab)
    case playlists(Playlist)
    
    var id: String {
        switch self {
        case .listenNow: return "listenNow"
        case .radio: return "radio"
        case .search: return "search"
        case .browse: return "browse"
        case .library(let tab): return "library-\(tab.rawValue)"
        case .playlists(let playlist): return "playlist-\(playlist.id)"
        }
    }
    
    var showInBrowseTab: Bool {
        switch self {
        case .library, .playlists:
            return true
        default:
            return false
        }
    }
    
    @ViewBuilder
    func detail() -> some View {
        switch self {
        case .listenNow:
            ListenNowView()
        case .radio:
            RadioView()
        case .search:
            SearchDetailView()
        case .browse:
            EmptyView()
        case .library(let tab):
            tab.detailView()
        case .playlists(let playlist):
            playlist.detailView()
        }
    }
}

enum LibraryTab: String, CaseIterable, Hashable {
    case recentlyAdded = "Recently Added"
    case artists = "Artists"
    case albums = "Albums"
    case songs = "Songs"
    case genres = "Genres"
    
    @ViewBuilder
    func detailView() -> some View {
        switch self {
        case .recentlyAdded:
            RecentlyAddedView()
        case .artists:
            ArtistsView()
        case .albums:
            AlbumsView()
        case .songs:
            SongsView()
        case .genres:
            GenresView()
        }
    }
}

struct Playlist: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    
    init(_ name: String, image: String = "music.note.list") {
        self.name = name
        self.image = image
    }
    
    @ViewBuilder
    func detailView() -> some View {
        PlaylistDetailView(playlist: self)
    }
}

// MARK: - Detail Views

struct ListenNowView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...10, id: \.self) { item in
                    Text("Listen Now Item \(item)")
                }
            }
            .navigationTitle("Listen Now")
        }
    }
}

struct RadioView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self) { item in
                    Text("Radio Station \(item)")
                }
            }
            .navigationTitle("Radio")
        }
    }
}

struct SearchDetailView: View {
    var body: some View {
        NavigationStack {
            Text("Search View")
                .navigationTitle("Search")
        }
    }
}

struct RecentlyAddedView: View {
    var body: some View {
        List {
            ForEach(1...15, id: \.self) { item in
                Text("Recently Added Item \(item)")
            }
        }
        .navigationTitle("Recently Added")
    }
}

struct ArtistsView: View {
    var body: some View {
        List {
            ForEach(["Taylor Swift", "Ed Sheeran", "Ariana Grande", "The Weeknd", "Drake"], id: \.self) { artist in
                Text(artist)
            }
        }
        .navigationTitle("Artists")
    }
}

struct AlbumsView: View {
    var body: some View {
        List {
            ForEach(1...8, id: \.self) { item in
                Text("Album \(item)")
            }
        }
        .navigationTitle("Albums")
    }
}

struct SongsView: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { item in
                Text("Song \(item)")
            }
        }
        .navigationTitle("Songs")
    }
}

struct GenresView: View {
    var body: some View {
        List {
            ForEach(["Pop", "Rock", "Hip Hop", "Jazz", "Classical"], id: \.self) { genre in
                Text(genre)
            }
        }
        .navigationTitle("Genres")
    }
}

struct PlaylistDetailView: View {
    let playlist: Playlist
    
    var body: some View {
        List {
            ForEach(1...10, id: \.self) { item in
                Text("\(playlist.name) Song \(item)")
            }
        }
        .navigationTitle(playlist.name)
    }
}

// MARK: - Main View
struct BrowseTabExample: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    @State var selection: MusicTab = .listenNow
    @State var browseTabPath: [MusicTab] = []
    @State var playlists = [Playlist("All Playlists"), Playlist("Running")]
    
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Listen Now", systemImage: "play.circle", value: MusicTab.listenNow) {
                Text("ListenNowView()")
            }
            
            
            Tab("Radio", systemImage: "dot.radiowaves.left.and.right", value: MusicTab.radio) {
                Text("RadioView()")
            }
            
            
            Tab("Search", systemImage: "magnifyingglass", value: MusicTab.search) {
                SearchDetailView()
            }
            
            
            Tab("Browse", systemImage: "list.bullet", value: MusicTab.browse) {
                LibraryView(path: $browseTabPath)
            }
            .hidden(sizeClass != .compact)
            
            
            TabSection("Library") {
                Tab("Recently Added", systemImage: "clock", value: MusicTab.library(.recentlyAdded)) {
                    RecentlyAddedView()
                }
                
                
                Tab("Artists", systemImage: "music.mic", value: MusicTab.library(.artists)) {
                    ArtistsView()
                }
            }
            .hidden(sizeClass == .compact)
            
            
            TabSection("Playlists") {
                ForEach(playlists)  { playlist in
                    Tab(playlist.name, image: playlist.image, value: MusicTab.playlists(playlist)) {
                        playlist.detailView()
                    }
                }
            }
            .hidden(sizeClass == .compact)
        }
        .tabViewStyle(.sidebarAdaptable)
        .onChange(of: sizeClass, initial: true) { _, sizeClass in
            if sizeClass == .compact && selection.showInBrowseTab {
                browseTabPath = [selection]
                selection = .browse
            } else if sizeClass == .regular && selection == .browse {
                selection = browseTabPath.last ?? .library(.recentlyAdded)
            }
        }
    }
}

// MARK: - Library View
struct LibraryView: View {
    @Binding var path: [MusicTab]


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(LibraryTab.allCases, id: \.self) { tab in
                    NavigationLink(tab.rawValue, value: MusicTab.library(tab))
                }
                // Code to add playlists here
            }
            .navigationDestination(for: MusicTab.self) { tab in
                tab.detail()
            }
        }
    }
}

// MARK: - Preview

struct ContentView: View {
    var body: some View {
        // Coba salah satu dari dua solusi:
        BrowseTabExample() // Solusi kompleks dengan NavigationCoordinator
        //        BrowseTabExampleSimple() // Solusi sederhana yang lebih stabil
    }
}

#Preview {
    ContentView()
}
