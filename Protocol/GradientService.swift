import UIKit

protocol GradientService {
    func createGradient(view: UIView, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer
}
extension GradientService {
    func createGradient(view: UIView,
                        colors: [UIColor] = [UIColor.Default.lightCoral, UIColor.Default.lightPupple],
                        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.3),
                        endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)) -> CAGradientLayer {
        var gradientLayer = view.layer.sublayers?.filter({$0 is CAGradientLayer}).first as? CAGradientLayer
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            view.layer.insertSublayer(gradientLayer!, at: 0)
        }
        gradientLayer?.frame = view.bounds
        gradientLayer?.colors = colors.map({$0.cgColor})
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
        return gradientLayer!
    }
}

/*
import UIKit

@IBDesignable
class GradientView: UIView, GradientService {
    @IBInspectable var colors: [UIColor] = [UIColor.Default.lightCoral, UIColor.Default.lightPupple] {
        didSet {
            gradientLayer = createGradient(view: self,
                                           colors: colors)
        }
    }
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        gradientLayer = createGradient(view: self, colors: colors)
    }
    
    override func layoutSubviews() {
        self.gradientLayer?.frame = self.bounds
    }
}
*/

