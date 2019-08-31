//
//  Leagues.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 27/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//
// TODO: REMEMBER TO LIMIT THE API CALLS OTHERWISE CHANGE API KEY

import UIKit

// Set the max Results in the URL

struct LeagueHighlights {
    var serieA: String = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLFTjYT0jsEKxPT8eg2BYFzSypKxZ8aPiS&key=AIzaSyCjb1SYgxqrFA9ZA8Wlg1UgnGwoe0nWkuE"
    var englishPL: String = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=15&playlistId=PLQ_voP4Q3cfdsmCD5bmf2nOMWARYqjP40&key=AIzaSyCjb1SYgxqrFA9ZA8Wlg1UgnGwoe0nWkuE"
    var bundesliga1: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UC6UL29enLNe4mqwTfAyeNuw&maxResults=15&key=AIzaSyCjb1SYgxqrFA9ZA8Wlg1UgnGwoe0nWkuE"
    var laLiga: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCTv-XvfzLX3i4IGWAm4sbmA&maxResults=15&key=AIzaSyCjb1SYgxqrFA9ZA8Wlg1UgnGwoe0nWkuE"
    var ligue1: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCQsH5XtIc9hONE1BQjucM0g&maxResults=15&key=AIzaSyCjb1SYgxqrFA9ZA8Wlg1UgnGwoe0nWkuE"
    
    var leagues: [String] = [
        "Serie A",
        "English Premier League",
        "Bundesliga 1",
        "La Liga Santander",
        "Ligue 1"
    ]
    
    var leaguesWidthLogo: [CGFloat] = [
        59.0,
        50.06,
        95.21,
        59.43,
        60.84
    ]
    
    func isPlaylist(selLeague: Int) -> Bool {
        if selLeague == 1 || selLeague == 0 {
            return true
        }
        
        return false
        
    }
}
