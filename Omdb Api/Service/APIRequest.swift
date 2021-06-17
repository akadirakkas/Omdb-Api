//
//  APIRequest.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 16.06.2021.
//

import Foundation

enum APIError : Error{
    case noDataAvailable
    case canNotProcessData
    
}



struct  APIRequest {
    var resourceURL : URL
    let API_KEY = "aa370b87"
    
    
    init(filmName : String) {
       
        let destinationURL = "https://www.omdbapi.com/?s=\(filmName.lowercased())&apikey=\(API_KEY)"
        
        guard let resourceURL = URL(string: destinationURL.replacingOccurrences(of: " ", with: "+")) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    
    func getFilms(compleation : @escaping(Result<[DetailFilm] , APIError >) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data , _ ,_ in
            guard let jsonDAta = data else {
                compleation(.failure(.noDataAvailable))
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let filmResponse = try decoder.decode(SearchFilmResponse.self, from: jsonDAta)
                let filmDetails =  filmResponse.Search
                compleation(.success(filmDetails))
            }catch{
                compleation(.failure(.canNotProcessData))
            }
  
        }
        dataTask.resume()
  
    }
    
    
}
