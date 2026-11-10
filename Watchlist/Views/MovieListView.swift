import SwiftUI

struct MovieListView: View {
    let store: WatchlistStore

    var body: some View {
        List {
            ForEach(store.movies) { movie in
                NavigationLink {
                    MovieDetailView(store: store, movieID: movie.id)
                } label: {
                    MovieRowView(movie: movie)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    store.remove(id: store.movies[index].id)
                }
            }
        }
        .navigationTitle("К просмотру")
        .overlay {
            if store.movies.isEmpty {
                ContentUnavailableView(
                    "Нет фильмов",
                    systemImage: "film",
                    description: Text("Нажмите +, чтобы добавить первый фильм.")
                )
            }
        }
        .toolbar {
            Button {
                store.add(Movie(title: "Новый фильм", genre: .drama))
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
