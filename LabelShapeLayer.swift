import UIKit


class LabelShapeLayer: CAShapeLayer {
    
    var myLabel: UILabel!
    var myValue: UILabel!
    
    init(x: CGFloat, y: CGFloat, label: String ) {
        super.init()
        myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        myLabel.center = CGPoint(x: x, y: y - 75)
        myLabel.textAlignment = .center
        myLabel.text = label
        myLabel.textColor = .black
        
        
        myValue = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myValue.center = CGPoint(x: x, y: y)
        myValue.textAlignment = .center
        //myValue.text = "\(String(format: "%.2f", "0.00"))"
        myValue.text = "0.00"
        myValue.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
