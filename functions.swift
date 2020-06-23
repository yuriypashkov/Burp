
import Foundation
import UIKit

func runAfter(seconds: Int, complition: @escaping () -> Void) {
    let deadline = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        complition()
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

extension UIButton {
    
    func tapEffect() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        //pulse.duration = 1.0
        //pulse.fromValue = 1
        //pulse.damping = 1.0
        pulse.toValue = 0.9
        pulse.autoreverses = true
        layer.add(pulse, forKey: nil)
    }
    
}
