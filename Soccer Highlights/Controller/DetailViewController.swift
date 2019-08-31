//
//  DetailViewController.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 26/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class DetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var hlTitle: UILabel!
    @IBOutlet weak var hlDescription: UITextView!
    @IBOutlet weak var playerView: WKYTPlayerView!
    
    var highlightPassed: Highlight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .white
        self.title = "Match Summary"
        
        guard let highlight = highlightPassed else {
            print("ERROR")
            return
        }
        
        playerView.load(withVideoId: highlight.videoId)
        hlTitle.text = highlight.title
        hlDescription.text = highlight.description
        
    }
    
}
