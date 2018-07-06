//
//  UIView+Gradient.swift
//  BBS
//
//  Created by 이광용 on 2018. 7. 3..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

protocol GradientService {
    func createGradient(view: UIView, startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer
}
extension GradientService {
    func createGradient(view: UIView,
                        startColor: UIColor = UIColor.Default.lightCoral,
                        endColor: UIColor = UIColor.Default.lightPupple,
                        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.3),
                        endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        view.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
