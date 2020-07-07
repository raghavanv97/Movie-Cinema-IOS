//
//  MoviesModel.swift
//  Movie
//
//  Created by vijay raghavan on 03/07/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

struct Movie {
    
    let moviePosterURL: String
    let movieName: String
    let twoDor3D: String
    let movieIMDB: String
    let movieCategory: String
    let movieShortDescription: String
    let movieTrailer: String

}

struct MoviesList {
    
    let avengersEndGame = Movie(moviePosterURL: "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg", movieName: "Avengers: Endgame (2019)", twoDor3D: "3D", movieIMDB: "IMDB: 8.4", movieCategory: "Action, Adventure, Drama", movieShortDescription: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.", movieTrailer: "TcMBFSGVi1c")
    
    let joker = Movie(moviePosterURL: "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg", movieName: "Joker (2019)", twoDor3D: "3D", movieIMDB: "IMDB: 8.5", movieCategory: "Crime, Drama, Thriller", movieShortDescription: "In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. He then embarks on a downward spiral of revolution and bloody crime. This path brings him face-to-face with his alter-ego: the Joker.", movieTrailer: "zAGVQLHvwOY")
    
    let johnWick = Movie(moviePosterURL: "https://image.tmdb.org/t/p/w500/ziEuG1essDuWuC5lpWUaw1uXY2O.jpg", movieName: "John Wick: Chapter 3 - Parabellum (2019)", twoDor3D: "3D", movieIMDB: "IMDB: 7.5", movieCategory: "Action, Crime, Thriller", movieShortDescription: "John Wick is on the run after killing a member of the international assassins' guild, and with a $14 million price tag on his head, he is the target of hit men and women everywhere.", movieTrailer: "M7XM597XO94")
    
    let F9 = Movie(moviePosterURL: "https://image.tmdb.org/t/p/w500/qIicLxr7B7gIt5hxZxo423BJLlK.jpg", movieName: "F9", twoDor3D: "3D", movieIMDB: "", movieCategory: "Action, Adventure, Crime", movieShortDescription: "Cypher enlists the help of Jakob, Dom's younger brother to take revenge on Dom and his team.", movieTrailer: "aSiDu3Ywi8E")
    
    let theDarkKnight = Movie(moviePosterURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", movieName: "The Dark Knight", twoDor3D: "2D", movieIMDB: "IMDB: 9.0", movieCategory: "Action, Crime, Drama", movieShortDescription: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.", movieTrailer: "EXeTwQWrcwY")
    
    
    func getAllMovies() -> [Movie] {
        let movies = [avengersEndGame, joker, johnWick, F9, theDarkKnight]
        return movies
    }
}
