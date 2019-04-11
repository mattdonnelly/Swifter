//
//  TweetCell.swift
//  Swifter
//
//  Created by Andy Liang on 2016-08-11.
//  Copyright © 2016 Matt Donnelly. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        textLabel?.font = .systemFont(ofSize: 14)
        detailTextLabel?.textColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
