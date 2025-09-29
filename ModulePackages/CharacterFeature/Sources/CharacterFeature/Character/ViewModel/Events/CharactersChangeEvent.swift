import Foundation

enum CharactersChangeEvent {
    case reload
    case append(indexPaths: [IndexPath])
}
