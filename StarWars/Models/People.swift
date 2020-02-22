
import Foundation

struct People : Codable {
    
    let name : String
    let height : String?
    let mass : String?
    let hairColor : String?
    let skinColor : String?
    let eyeColor : String?
    let birthYear : String?
    let gender : String?
    let homeworld : String?
    let films : [String]?
    let species : [String]?
    let vehicles : [String]?
    let starships : [String]?
    let created : String?
    let edited : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
        case homeworld = "homeworld"
        case films = "films"
        case species = "species"
        case vehicles = "vehicles"
        case starships = "starships"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        mass = try values.decodeIfPresent(String.self, forKey: .mass)
        hairColor = try values.decodeIfPresent(String.self, forKey: .hairColor)
        skinColor = try values.decodeIfPresent(String.self, forKey: .skinColor)
        eyeColor = try values.decodeIfPresent(String.self, forKey: .eyeColor)
        birthYear = try values.decodeIfPresent(String.self, forKey: .birthYear)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        homeworld = try values.decodeIfPresent(String.self, forKey: .homeworld)
        films = try values.decodeIfPresent([String].self, forKey: .films)
        species = try values.decodeIfPresent([String].self, forKey: .species)
        vehicles = try values.decodeIfPresent([String].self, forKey: .vehicles)
        starships = try values.decodeIfPresent([String].self, forKey: .starships)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}
