//
//  NibInitable.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

protocol NibInitable {
    static func initFromNib() -> Self?
}

extension NibInitable where Self: UIView {
    static func initFromNib() -> Self? {
        let xibName = String(describing: self)
        guard let _ = bundle.path(forResource: xibName, ofType: "nib") else { return nil }
        return bundle.loadNibNamed(xibName, owner: nil, options: nil)?.first as? Self
    }
}

extension NibInitable where Self: UIViewController {
    static func initFromNib() -> Self? {
        let xibName = String(describing: self)
        return ((Self)(nibName: xibName, bundle: bundle))
    }
}

extension UIView: NibInitable {}
