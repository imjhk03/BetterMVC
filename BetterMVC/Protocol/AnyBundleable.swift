//
//  AnyBundleable.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

protocol AnyBundleable {

    static var bundle: Bundle { get }

    var bundle: Bundle { get }

}

extension AnyBundleable where Self: NSObject {

    static var bundle: Bundle {
        return Bundle(for: self)
    }

    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

}

extension NSObject: AnyBundleable {}
