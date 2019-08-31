//
//  Highlight.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 26/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import UIKit

class Highlight {
    
    var videoId: String = ""
    var channelId: String = ""
    var channelTitle: String = ""
    var description: String = ""
    var publishedAt: String = ""
    var thumbnail: String = ""
    var title: String = ""
    
    init(videoId: String, channelId: String, channelTitle: String, description: String, publishedAt: String, thumbnail: String, title: String) {
        self.videoId = videoId
        self.channelId = channelId
        self.channelTitle = channelTitle
        self.description = description
        self.publishedAt = publishedAt
        self.thumbnail = thumbnail
        self.title = title
    }
    
}
