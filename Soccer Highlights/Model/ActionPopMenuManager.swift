//
//  actionPopMenuManager.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 29/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import UIKit
import PopMenu

struct ActionPopMenuManager {
    let serieAAction = PopMenuDefaultAction(title: "Serie A", image: UIImage(named: "Serie A"))
    let bundesligaAction = PopMenuDefaultAction(title: "Bundesliga", image: UIImage(named: "Bundesliga 1"))
    let eplAction = PopMenuDefaultAction(title: "EPL", image: UIImage(named: "English Premier League"))
    let ligue1Action = PopMenuDefaultAction(title: "Ligue 1", image: UIImage(named: "Ligue 1"))
    let laLigaAction = PopMenuDefaultAction(title: "La Liga", image: UIImage(named: "La Liga Santander"))
    
    init() {
        serieAAction.imageRenderingMode = .alwaysOriginal
        bundesligaAction.imageRenderingMode = .alwaysOriginal
        eplAction.imageRenderingMode = .alwaysOriginal
        ligue1Action.imageRenderingMode = .alwaysOriginal
        laLigaAction.imageRenderingMode = .alwaysOriginal
    }
}
