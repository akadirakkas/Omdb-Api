//
//  Omdb.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 15.06.2021.
//

import Foundation

struct SearchFilmResponse : Codable{
    var Search : [DetailFilm]
}


struct DetailFilm  : Codable {
   
    var title_films : String
    var year_films : String
    var type_films :  String
    var poster_films : String
  
    
    private enum CodingKeys : String, CodingKey {
        
        case title_films = "Title"
        case year_films = "Year"
        case type_films  = "Type"
        case poster_films = "Poster"
     
    }
    
}
