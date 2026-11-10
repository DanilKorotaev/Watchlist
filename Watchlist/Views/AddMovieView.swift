import SwiftUI

struct AddMovieView: View {
    @State private var viewModel: AddMovieViewModel
    @Environment(\.dismiss) private var dismiss

    init(store: WatchlistStore) {
        _viewModel = State(initialValue: AddMovieViewModel(store: store))
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
            TextField("Название", text: Bindable(viewModel).title)
            Picker("Жанр", selection: Bindable(viewModel).genre) {
                ForEach(MovieGenre.allCases) { item in
                    Text(item.label).tag(item)
                }
            }
            Toggle("Сразу в избранное", isOn: Bindable(viewModel).markAsFavorite)
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
            viewModel.saveButtonTapped()
            dismiss()
        }
        .disabled(!viewModel.canSave)
    }
}
