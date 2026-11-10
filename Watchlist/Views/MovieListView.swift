import SwiftUI

struct MovieListView: View {
    @State private var viewModel: MovieListViewModel

    init(store: WatchlistStore, filter: MovieListFilter = .all) {
        _viewModel = State(initialValue: MovieListViewModel(store: store, filter: filter))
    }

    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(store: viewModel.store, movieID: movie.id)
                } label: {
                    MovieRowView(
                        movie: movie,
                        onFavoriteTap: { viewModel.favoriteButtonTapped(id: movie.id) },
                        onWatchedTap: { viewModel.watchedButtonTapped(id: movie.id) }
                    )
                }
                .navigationLinkIndicatorVisibility(.hidden)
            }
            .onDelete { indexSet in
                viewModel.deleteMovies(at: indexSet)
            }
        }
        .navigationTitle(viewModel.title)
        .overlay { emptyOverlay }
        .toolbar { toolbarContent }
        .sheet(isPresented: Bindable(viewModel).isAddingMovie) {
            addMovieSheet
        }
    }

    @ViewBuilder
    private var emptyOverlay: some View {
        if viewModel.movies.isEmpty {
            ContentUnavailableView(
                viewModel.filter == .favorites ? "Пока пусто" : "Нет фильмов",
                systemImage: viewModel.filter == .favorites ? "heart" : "film",
                description: Text(
                    viewModel.filter == .favorites
                        ? "Добавьте фильм в избранное сердцем в списке или на деталях."
                        : "Нажмите +, чтобы добавить первый фильм."
                )
            )
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if viewModel.filter == .all {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewModel.addButtonTapped()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private var addMovieSheet: some View {
        AddMovieView(store: viewModel.store)
    }
}
