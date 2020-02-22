
import Foundation

struct Film : Codable, Equatable {
    public let title : String
    public let episodeId : Int?
    public let openingCrawl : String?
    public let director : String
    public let producer : String
    public let releaseDate : Date
    public let characters : [String]
    public let planets : [String]?
    public let starships : [String]?
    public let vehicles : [String]?
    public let species : [String]?
    public let created : String?
    public let edited : String?
    public let url : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case characters = "characters"
        case planets = "planets"
        case starships = "starships"
        case vehicles = "vehicles"
        case species = "species"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        episodeId = try values.decodeIfPresent(Int.self, forKey: .episodeId)
        openingCrawl = try values.decode(String.self, forKey: .openingCrawl)
        director = try values.decode(String.self, forKey: .director)
        producer = try values.decode(String.self, forKey: .producer)
        releaseDate = try values.decode(String.self, forKey: .releaseDate).toDate()
        characters = try values.decode([String].self, forKey: .characters)
        planets = try values.decodeIfPresent([String].self, forKey: .planets)
        starships = try values.decodeIfPresent([String].self, forKey: .starships)
        vehicles = try values.decodeIfPresent([String].self, forKey: .vehicles)
        species = try values.decodeIfPresent([String].self, forKey: .species)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    static func == (lhs: Film, rhs: Film) -> Bool {
        return lhs.episodeId == rhs.episodeId
    }
    

}

struct FilmResult: Codable {
    public let results: [Film]
    
    init(results: [Film]) {
        self.results = results
    }
}
