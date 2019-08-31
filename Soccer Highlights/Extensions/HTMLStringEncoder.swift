//
//  HTMLStringEncoder.swift
//  Soccer Highlights
//
//  Created by Marco Marinò on 29/08/2019.
//  Copyright © 2019 Marco Marinò. All rights reserved.
//

import UIKit

extension String {
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string
        
        return decoded ?? self
    }
    
}
