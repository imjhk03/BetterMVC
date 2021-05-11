//
//  ListCollectionReusableView.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 05. 12..
//

import UIKit

final class ListCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
}
