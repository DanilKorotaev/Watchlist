import Foundation

enum MovieListFilter: String, CaseIterable, Identifiable {
    case all
    case favorites

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: "К просмотру"
        case .favorites: "Избранное"
        }
    }

    var tabTitle: String {
        switch self {
        case .all: "Все"
        case .favorites: "Избранное"
        }
    }

    var systemImage: String {
        switch self {
        case .all: "film"
        case .favorites: "heart.fill"
        }
    }
}
