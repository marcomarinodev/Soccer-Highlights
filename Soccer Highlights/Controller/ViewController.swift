//
//  ViewController.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 26/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//
// TODO: LOAD OTHER HLs WHEN SCROLLING DOWN

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import TableViewReloadAnimation
import PullToRefreshKit
import PopMenu

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PopMenuViewControllerDelegate {
    
    // GUILLOTINE MENU
    fileprivate let cellHeight: CGFloat = 210
    fileprivate let cellSpacing: CGFloat = 20
    
    @IBOutlet weak var highlightsTableView: UITableView!
    
    var popMenuViewController = PopMenuViewController()
    let actionPopMenuManager = ActionPopMenuManager()
    
    var button: UIButton!
    var selectedLeague: Int = 0
    var currentLeagueAPI: String = ""
    var currentLeagueImage: String = ""
    var widthMenu: CGFloat = 0.0
    var heightMenu: CGFloat = 84.0
    
    var leagueHighlightsManager: LeagueHighlights!
    
    var highlights = [Highlight]() {
        didSet {
            pullToRefresh()
        }
    }
    
    var highlightToPass: Highlight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueHighlightsManager = LeagueHighlights()
        setUI()
        getVideos()
        
        highlightsTableView.delegate = self
        highlightsTableView.dataSource = self
        highlightsTableView.separatorStyle = .none
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUI() {
        routeLeagues()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01176470588, green: 0.03137254902, blue: 0.2745098039, alpha: 1)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    @IBAction func menuButton_Clicked(_ sender: UIButton) {
        
        popMenuViewController = PopMenuViewController(sourceView: sender,actions: [
            actionPopMenuManager.serieAAction,
            actionPopMenuManager.eplAction,
            actionPopMenuManager.bundesligaAction,
            actionPopMenuManager.laLigaAction,
            actionPopMenuManager.ligue1Action
        ])
        
        popMenuViewController.delegate = self
        
        popMenuViewController.appearance.popMenuColor.backgroundColor = .gradient(fill: #colorLiteral(red: 1, green: 0.2509803922, blue: 0.3176470588, alpha: 1), #colorLiteral(red: 0.005858031102, green: 0.03028713539, blue: 0.2751323879, alpha: 1)) // A gradient from yellow to pink
        
        for i in popMenuViewController.actions {
            i.iconWidthHeight = 40
        }
        
        self.present(popMenuViewController, animated: true, completion: nil)
    }
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        highlights.removeAll()
        selectedLeague = index
        routeLeagues()
        getVideos()
        refresh()
    }
    
    func routeLeagues() {
        switch selectedLeague {
        case 0:
            currentLeagueAPI = leagueHighlightsManager.serieA
            currentLeagueImage = leagueHighlightsManager.leagues[0]
            widthMenu = leagueHighlightsManager.leaguesWidthLogo[0]
            self.title = leagueHighlightsManager.leagues[0]
            break
        case 1:
            currentLeagueAPI = leagueHighlightsManager.englishPL
            currentLeagueImage = leagueHighlightsManager.leagues[1]
            widthMenu = leagueHighlightsManager.leaguesWidthLogo[1]
            self.title = "EPL"
            break
        case 2:
            currentLeagueAPI = leagueHighlightsManager.bundesliga1
            currentLeagueImage = leagueHighlightsManager.leagues[2]
            widthMenu = leagueHighlightsManager.leaguesWidthLogo[2]
            self.title = leagueHighlightsManager.leagues[2]
            break
        case 3:
            currentLeagueAPI = leagueHighlightsManager.laLiga
            currentLeagueImage = leagueHighlightsManager.leagues[3]
            widthMenu = leagueHighlightsManager.leaguesWidthLogo[3]
            self.title = leagueHighlightsManager.leagues[3]
            break
        default:
            currentLeagueAPI = leagueHighlightsManager.ligue1
            currentLeagueImage = leagueHighlightsManager.leagues[4]
            widthMenu = leagueHighlightsManager.leaguesWidthLogo[4]
            self.title = leagueHighlightsManager.leagues[4]
            break
        }
    }
    
    func pullToRefresh() {
        let qqHeader = QQVideoRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
        self.highlightsTableView.configRefreshHeader(with: qqHeader,container:self) { [weak self] in
            self!.refresh()
            self?.highlightsTableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }
    }
    
    func refresh() {
        self.highlightsTableView.reloadData(
            with: .simple(duration: 0.75, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        navigationController?.navigationBar.barStyle = .black
        
//        print("VC: viewDidAppear")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highlightCell", for: indexPath) as! HighlightTableViewCell
        
            if highlights.count > 0 {
                // GET IMAGES
                let imgURL = URL(string: highlights[indexPath.row].thumbnail)
                
                if imgURL != nil {
                    cell.thumbnailImageView!.af_setImage(
                        withURL: imgURL!,
                        placeholderImage: nil,
                        filter: nil,
                        imageTransition: .crossDissolve(0.5),
                        completion: nil
                    )
                }
                
                cell.titleLabel.text = highlights[indexPath.row].title.htmlDecoded
                cell.leagueLabel.text = highlights[indexPath.row].channelTitle
                cell.dateLabel.text = highlights[indexPath.row].publishedAt
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        highlightToPass = highlights[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            
            guard let highlight = self.highlightToPass else {
                print("ERROR")
                return
            }
            
            detailVC.highlightPassed = highlight
        }
    }
    
    func getVideos() {
        let indicatorView = CustomIndicatorView(frame: CGRect(x: self.view.frame.midX - 50.0, y: self.view.frame.midY - 50.0, width: 100.0, height: 100.0))
        
        indicatorView.isHidden = false
        indicatorView.rotationDuration = 1
        indicatorView.lineWidth = 6
        indicatorView.numSegments = 24
        indicatorView.strokeColor = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.3176470588, alpha: 1)
        indicatorView.startAnimating()
        
        self.view.addSubview(indicatorView)
        
        Alamofire.request(currentLeagueAPI, method: .get).responseJSON { (response) in
            indicatorView.stopAnimating()
            if response.result.isSuccess {
                //print("SUCCESS")
                //print(response.result.value!)
                
                let json: JSON = JSON(response.result.value!)
                //print(json)
                self.parseJSON(json: json)
            } else {
                //print("ERROR")
            }
        }

    }
    
    func parseJSON(json: JSON) {
        // TODO: Manage parsing for the playlists
        let isPlaylist = leagueHighlightsManager.isPlaylist(selLeague: selectedLeague)
        
        if isPlaylist {
            // PREMIER LEAGUE PLAYLIST
            // PARSE AS PLAYLIST SEARCH LIST
            for i in 0...14 {
                var currentHL = json["items"][i]
                self.highlights.append(Highlight(videoId: currentHL["snippet"]["resourceId"]["videoId"].stringValue, channelId: currentHL["snippet"]["channelId"].stringValue, channelTitle: currentHL["snippet"]["channelTitle"].stringValue, description: currentHL["snippet"]["description"].stringValue, publishedAt: currentHL["snippet"]["publishedAt"].stringValue, thumbnail: currentHL["snippet"]["thumbnails"]["high"]["url"].stringValue, title: currentHL["snippet"]["title"].stringValue))
            }
            
        } else {
            // OTHER LEAGUES
            // PARSE SEARCH LIST
            for i in 0...14 {
                var currentHL = json["items"][i]
                self.highlights.append(Highlight(videoId: currentHL["id"]["videoId"].stringValue, channelId: currentHL["snippet"]["channelId"].stringValue, channelTitle: currentHL["snippet"]["channelTitle"].stringValue, description: currentHL["snippet"]["description"].stringValue, publishedAt: currentHL["snippet"]["publishedAt"].stringValue, thumbnail: currentHL["snippet"]["thumbnails"]["high"]["url"].stringValue, title: currentHL["snippet"]["title"].stringValue))
            }
        }
        
        
        refresh()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return highlights.count
        if highlights.count == 0 {
            return 0
        }
        return highlights.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
    
    func userSelectedLeague(index: Int) {
        highlights.removeAll()
        selectedLeague = index
        
        routeLeagues()
        getVideos()
        refresh()
        
        button.setImage(UIImage(named: currentLeagueImage), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: widthMenu, height: heightMenu)
        
        
    }
    
}
