//
//  QQVideoRefreshHeader.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 26/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import Foundation
import UIKit
import PullToRefreshKit

class QQVideoRefreshHeader:UIView,RefreshableHeader{
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: 27, height: 10)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        imageView.image = UIImage(named: "loading15")
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func heightForHeader() -> CGFloat {
        return 50.0
    }
    func stateDidChanged(_ oldState: RefreshHeaderState, newState: RefreshHeaderState) {
        if newState == .pulling{
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
        if newState == .idle{
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    func didBeginRefreshingState(){
        imageView.image = nil
        let images = (0...29).map{return $0 < 10 ? "loading0\($0)" : "loading\($0)"}
        imageView.animationImages = images.map{return UIImage(named:$0)!}
        imageView.animationDuration = Double(images.count) * 0.04
        imageView.startAnimating()
    }
    
    func didBeginHideAnimation(_ result:RefreshResult){}
    
    func didCompleteHideAnimation(_ result:RefreshResult){
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.image = UIImage(named: "loading15")
    }
}
