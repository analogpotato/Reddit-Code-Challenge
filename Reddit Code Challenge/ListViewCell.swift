//
//  ListViewCellsTableViewCell.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postURL: UILabel!
    @IBOutlet weak var postSubreddit: UILabel!
    @IBOutlet weak var postVoteCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
