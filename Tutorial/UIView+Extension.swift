//
//  UIView+Extension.swift
//  Tutorial
//
//  Created by Michael on 21.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit

extension UIView {
    
    var viewController: UIViewController?{
        
        return traverseResponderChainToFindViewController()
    }
    private func traverseResponderChainToFindViewController() -> UIViewController?{
        if let responder = nextResponder() as? UIViewController{
            return responder
        }
        
        if let responder = nextResponder()  as? UIView{
            return responder.traverseResponderChainToFindViewController()
        }
     return nil
    }
    
}
