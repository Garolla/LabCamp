//
//  Utility.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
}

extension UIButton {
    open override var isEnabled: Bool {
        get{
            return super.isEnabled
        }
        
        set{
            super.isEnabled = newValue
            self.alpha = newValue ? 1 : 0.3
        }
    }
}
