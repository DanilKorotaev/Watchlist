import SwiftUI

struct DatePickerSheet: View {
    var title: String
    var initialDate: Date
    var onSelect: (Date) -> Void
    var onClear: (() -> Void)?

    @State private var date: Date
    @Environment(\.dismiss) private var dismiss

    init(
        title: String = "Выберите дату",
        initialDate: Date = .now,
        onSelect: @escaping (Date) -> Void,
        onClear: (() -> Void)? = nil
    ) {
        self.title = title
        self.initialDate = initialDate
        self.onSelect = onSelect
        self.onClear = onClear
        _date = State(initialValue: initialDate)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
        }
    }

    private var content: some View {
        VStack(spacing: 24) {
            datePicker
            Spacer()
        }
    }

    private var datePicker: some View {
        DatePicker(
            "Дата",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .padding(.horizontal)
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            cancelButton
        }
        if onClear != nil {
            ToolbarItem(placement: .bottomBar) {
                clearButton
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            doneButton
        }
    }

    private var cancelButton: some View {
        Button("Отмена") { dismiss() }
    }

    private var clearButton: some View {
        Button("Сбросить", role: .destructive) {
            onClear?()
            dismiss()
        }
    }

    private var doneButton: some View {
        Button("Готово") {
            onSelect(date)
            dismiss()
        }
    }
}

#Preview {
    DatePickerSheet { _ in }
}
