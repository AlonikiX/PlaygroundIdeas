//
//  ChapterTableViewCell.swift
//  Playground Ideas
//
//  Created by Apple on 17/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var chapterLabel: UILabel!
    
    var chapter : String {
        get {
            return chapterLabel.text!
        }
        set {
            self.chapterLabel.text = newValue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
