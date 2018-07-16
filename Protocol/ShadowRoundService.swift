import UIKit

protocol ShadowRoundService {
    func shadowRounded(view: UIView, cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float)
}
extension ShadowRoundService {
    func shadowRounded(view: UIView,
                       cornerRadius: CGFloat = 10,
                       shadowColor: UIColor = UIColor.black,
                       shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0),
                       shadowRadius: CGFloat = 2,
                       shadowOpacity: Float = 0.3) {
        if let sublayers = view.layer.sublayers {
            let shadowLayers = sublayers.filter({$0.name == "ShadowLayer"})
            
            var shadowLayer = CAShapeLayer()
            shadowLayer.name = "ShadowLayer"
            
            if !shadowLayers.isEmpty {
                guard let preShadowLayer = shadowLayers.first as? CAShapeLayer else {return}
                shadowLayer = preShadowLayer
            }
            else {
                view.layer.insertSublayer(shadowLayer, at: 0)
                shadowLayer.fillColor = view.backgroundColor?.cgColor
                view.backgroundColor? = .clear
            }
            shadowLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowRadius = shadowRadius
            shadowLayer.shadowOpacity = shadowOpacity
        }
    }
}

/*
class RoundedShadowButton: UIButton, ShadowRoundService {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.shadowRounded(view: self, cornerRadius: cornerRadius)
    }
}
*/
