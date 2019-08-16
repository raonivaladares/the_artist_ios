import UIKit

extension UIColor {
    struct AppColors {
        private init() {}
        
        static var black: UIColor {
            return UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        }
        
        static var yellow: UIColor {
            return  UIColor(red: 254/255, green: 211/255, blue: 0, alpha: 1)
        }
        
        static var white: UIColor {
            return  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
