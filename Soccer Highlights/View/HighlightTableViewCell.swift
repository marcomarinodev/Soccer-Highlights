//
//  HighlightTableViewCell.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 26/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.bckView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.bckView.layer.cornerRadius = 15.0
        self.thumbnailImageView.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
