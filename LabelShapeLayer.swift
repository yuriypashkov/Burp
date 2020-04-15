import UIKit


class LabelShapeLayer: CAShapeLayer {
    
    var myLabel: UILabel!
    var myValue: UILabel!
    
    init(x: CGFloat, y: CGFloat, label: String ) {
        super.init()
        myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        myLabel.center = CGPoint(x: x, y: y - 55)
        myLabel.textAlignment = .center
        myLabel.text = label
        //myLabel.textColor = UIColor(red: 115/255, green: 36/255, blue: 166.255, alpha: 1.0)
        myLabel.textColor = .white
        myLabel.font = UIFont.init(name: "AM Krang Appizza DEMO", size: 14)
        
        
        myValue = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        myValue.center = CGPoint(x: x, y: y)
        myValue.textAlignment = .center
        myValue.text = "0.00"
        //myValue.textColor = UIColor(red: 115/255, green: 36/255, blue: 166.255, alpha: 1.0)
        myValue.textColor = .white
       // myValue.font = UIFont.boldSystemFont(ofSize: 18)
        myValue.font = UIFont.init(name: "AM Krang Appizza DEMO", size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
