import SwiftUI

struct AddMovieView: View {
    let store: WatchlistStore
    @State private var title = ""
    @State private var genre: MovieGenre = .drama
    @State private var markAsFavorite = false
    @Environment(\.dismiss) private var dismiss

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            formContent
                .navigationTitle("Новый фильм")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
        }
    }

    private var formContent: some View {
        Form {
            movieSection
        }
    }

    private var movieSection: some View {
        Section("Фильм") {
            TextField("Название", text: $title)
            Picker("Жанр", selection: $genre) {
                ForEach(MovieGenre.allCases) { item in
                    Text(item.label).tag(item)
                }
            }
            Toggle("Сразу в избранное", isOn: $markAsFavorite)
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            cancelButton
        }
        ToolbarItem(placement: .confirmationAction) {
            saveButton
        }
    }

    private var cancelButton: some View {
        Button("Отмена") { dismiss() }
    }

    private var saveButton: some View {
        Button("Сохранить") {
            let cleaned = title.trimmingCharacters(in: .whitespacesAndNewlines)
            store.add(
                Movie(
                    title: cleaned,
                    genre: genre,
                    isFavorite: markAsFavorite
                )
            )
            dismiss()
        }
        .disabled(!canSave)
    }
}
