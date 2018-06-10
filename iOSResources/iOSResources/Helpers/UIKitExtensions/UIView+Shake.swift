import UIKit

extension UIView {
    func shake() {
        let positionAnimation = CASpringAnimation()

        positionAnimation.beginTime = self.layer.convertTime(CACurrentMediaTime(), from: nil) + 0.000001
        positionAnimation.duration = 0.8
        positionAnimation.keyPath = "position"
        positionAnimation.toValue = CGPoint(x: center.x, y: center.y)
        positionAnimation.fromValue = CGPoint(x: center.x + 10, y: center.y)
        positionAnimation.stiffness = 200
        positionAnimation.damping = 2.2
        positionAnimation.mass = 0.3
        positionAnimation.initialVelocity = 4

        layer.add(positionAnimation, forKey: "positionAnimation")
    }
}
