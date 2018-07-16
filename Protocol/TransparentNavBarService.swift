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

/*
class ViewController: UIViewController, TransparentNavBarService {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transparentNavigationBar()
    }
}
*/
