
import Foundation

// MARK: - Welcome
public struct MovieGenre: Codable {
    let genres: [GenreResult]
}

// MARK: - Genre
public struct GenreResult: Codable {
    let id: Int
    let name: String
    
    func convertToGenreVo()-> GenreVO{
        let vo = GenreVO(id: id,name: name, isSelected: false)
        return vo
    }
    
}
