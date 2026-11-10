import SwiftUI

struct ContentView: View {
    @State private var store = WatchlistStore()

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.movies) { movie in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title)
                                .font(.headline)
                                .strikethrough(movie.isWatched)
                                .foregroundStyle(movie.isWatched ? .secondary : .primary)
                            Text(movie.genre.label)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if movie.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                        Image(systemName: movie.isWatched ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(movie.isWatched ? .green : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        store.toggleWatched(id: movie.id)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        store.remove(id: store.movies[index].id)
                    }
                }
            }
            .navigationTitle("К просмотру")
            .toolbar {
                Button {
                    store.add(Movie(title: "Новый фильм", genre: .drama))
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
