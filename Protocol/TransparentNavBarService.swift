//
//  UIViewController+TransparentNavBar.swift
//  BBS
//
//  Created by 이광용 on 2018. 7. 4..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

protocol TransparentNavBarService: class{
    func transparentNavigationBar()
}
extension TransparentNavBarService where Self: UIViewController {
    func transparentNavigationBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
}
