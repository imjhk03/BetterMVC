//
//  SimpleTableViewCell.swift
//  BetterMVC
//
//  Created by Joohee Kim on 2023/01/09.
//

import UIKit

final class SimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
