import Foundation

enum MovieGenre: String, CaseIterable, Identifiable {
    case action
    case comedy
    case drama
    case sciFi

    var id: String { rawValue }

    var title: String {
        switch self {
        case .action: "Боевик"
        case .comedy: "Комедия"
        case .drama: "Драма"
        case .sciFi: "Фантастика"
        }
    }

    var emoji: String {
        switch self {
        case .action: "🔥"
        case .comedy: "😄"
        case .drama: "🎭"
        case .sciFi: "🚀"
        }
    }

    var label: String {
        "\(emoji) \(title)"
    }
}
