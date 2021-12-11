//
//  SubRedditTableViewCell.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import UIKit

/// Custom table view cell we will be using.
class SubRedditTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subredditLabel: UILabel?
    
    /// Static reuse identifier
    static let reuseIdentifier = "cellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
