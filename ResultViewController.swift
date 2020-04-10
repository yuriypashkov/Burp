import UIKit
import Photos

class ResultViewController: UIViewController {
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartButtonClick(_ sender: Any) {
        arrayOfDb.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    var technics = 0.0
    var artistry = 0.0
    var skill = 0.0
    var charisma = 0.0
    var characterSum = 0.0
    var status: NSString = ""
    
    var maxDb = arrayOfDb[0]
    //let testLine = CAShapeLayer()
    
    var timerTechnics: Timer!
    //var timerArtistry: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for db in arrayOfDb {
            if db > maxDb {
                maxDb = db
            }
        }
        
        getCharacter()
        
        // РИСУЕМ КРУГИ
        let shapeLayerOne = createShapeLayer(x: view.frame.size.width / 4, y: view.frame.size.height / 3, color: .red)
        view.layer.addSublayer(shapeLayerOne)
        
        let shapeLayerTwo = createShapeLayer(x: 3 * view.frame.size.width / 4, y: view.frame.size.height / 3, color: .brown)
        view.layer.addSublayer(shapeLayerTwo)
        
        let shapeLayerThree = createShapeLayer(x: view.frame.size.width / 4, y: 4.3 * view.frame.size.height / 7, color: .green)
        view.layer.addSublayer(shapeLayerThree)
        
        let shapeLayerFour = createShapeLayer(x: 3 * view.frame.size.width / 4, y: 4.3 * view.frame.size.height / 7, color: .yellow)
        view.layer.addSublayer(shapeLayerFour)
        
        // ЗАКОНЧИЛИ РИСОВАТЬ КРУГИ
        // заполняющаяся линия
//        let linePath = UIBezierPath()
//        linePath.move(to: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2))
//        linePath.addLine(to: CGPoint(x: view.frame.size.width / 2 + 200, y: view.frame.size.height / 2))
//        testLine.path = linePath.cgPath
//        testLine.lineWidth = 4
//        testLine.fillColor = UIColor.red.cgColor
//        testLine.strokeColor = UIColor.black.cgColor
//        testLine.strokeEnd = 0
//        view.layer.addSublayer(testLine)
        
        // добавим надписи
        let labelTechnics = LabelShapeLayer(x: view.frame.size.width / 4, y: view.frame.size.height / 3, label: "ТЕХНИКА")
        view.addSubview(labelTechnics.myLabel)
        view.addSubview(labelTechnics.myValue)
        
        let labelCharisma = LabelShapeLayer(x: 3 * view.frame.size.width / 4, y: view.frame.size.height / 3, label: "ХАРИЗМА")
        view.addSubview(labelCharisma.myLabel)
        view.addSubview(labelCharisma.myValue)
        
        let labelSkill = LabelShapeLayer(x: view.frame.size.width / 4, y: 4.3 * view.frame.size.height / 7, label: "МАСТЕРСТВО")
        view.addSubview(labelSkill.myLabel)
        view.addSubview(labelSkill.myValue)
        
        let labelArtistry = LabelShapeLayer(x: 3 * view.frame.size.width / 4, y: 4.3 * view.frame.size.height / 7, label: "АРТИСТИЗМ")
        view.addSubview(labelArtistry.myLabel)
        view.addSubview(labelArtistry.myValue)

        // закончим с надписями
        
        // без runAfter нифига не работает
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            
            // анимация и заполнение цифр маркера Техника
            self.getTimer(value: self.technics, label: labelTechnics)
            basicAnimation.duration = self.technics
            basicAnimation.toValue = self.technics / 10
            shapeLayerOne.add(basicAnimation, forKey: "strokeOne")
            
            // анимация и заполнение цифр маркера Харизма
            self.getTimer(value: self.charisma, label: labelCharisma)
            basicAnimation.duration = self.charisma
            basicAnimation.toValue = self.charisma / 10
            shapeLayerTwo.add(basicAnimation, forKey: "strokeTwo")
            
            // анимация и заполнение цифр маркера Мастерство
            self.getTimer(value: self.skill, label: labelSkill)
            basicAnimation.duration = self.skill
            basicAnimation.toValue = self.skill / 10
            shapeLayerThree.add(basicAnimation, forKey: "strokeThree")
            
            // анимация и заполнение цифр маркера Артистизм
            self.getTimer(value: self.artistry, label: labelArtistry)
            basicAnimation.duration = self.artistry
            basicAnimation.toValue = self.artistry / 10
            shapeLayerFour.add(basicAnimation, forKey: "strokeFour")
//            basicAnimation.toValue = 0.8
//            self.testLine.add(basicAnimation, forKey: "testLine")
        }
        
        // ранг
        let labelStatus = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        labelStatus.center = CGPoint(x: view.frame.size.width / 2, y: 5.3 * view.frame.size.height / 7)
        labelStatus.textAlignment = .center
        labelStatus.text = String(status).uppercased()
        labelStatus.textColor = .systemRed
        view.addSubview(labelStatus)
        
        self.isModalInPresentation = true // свойство для того чтобы нельзя было смахнуть экран
        restartButton.layer.cornerRadius = restartButton.frame.width / 2
        
    }
    
    func getTimer(value: Double, label: LabelShapeLayer) {
        var counter = 0.00
        let _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            counter += 0.01
            label.myValue.text = "\(String(format: "%.2f", counter))"
            if counter >= value {
                timer.invalidate()
                label.myValue.text = "\(String(format: "%.2f", value))"
            }
        })
    }
    
//    func createLabel(x: CGFloat, y: CGFloat, value: Double, label: String) {
//        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
//        myLabel.center = CGPoint(x: x, y: y - 75)
//        myLabel.textAlignment = .center
//        myLabel.text = label
//        myLabel.textColor = .black
//        view.addSubview(myLabel)
//
//        let myValue = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        myValue.center = CGPoint(x: x, y: y)
//        myValue.textAlignment = .center
//        myValue.text = "\(String(format: "%.2f", value))"
//        myValue.textColor = .black
//        view.addSubview(myValue)
//    }
    
    func createShapeLayer(x: CGFloat, y: CGFloat, color: UIColor) -> CAShapeLayer {
        let result = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.systemGray.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        result.fillColor = UIColor.clear.cgColor
        result.path = circularPath.cgPath
        result.lineWidth = 6
        result.strokeColor = color.cgColor
        result.strokeEnd = 0
        result.lineCap = .round
        
        return result
    }
    
    func getCharacter() {
        let tempDb = 200 + maxDb
        switch tempDb {
        case 0..<170:
            technics = (100 * Double.random(in: 0.5...3.0)).rounded() / 100
            artistry = (100 * Double.random(in: 0.5...3.0)).rounded() / 100
            skill = (100 * Double.random(in: 0.5...3.0)).rounded() / 100
            charisma = (100 * Double.random(in: 0.5...3.0)).rounded() / 100
        case 170..<180:
            technics = (100 * Double.random(in: 3.0...5.0)).rounded() / 100
            artistry = (100 * Double.random(in: 3.0...5.0)).rounded() / 100
            skill = (100 * Double.random(in: 3.0...5.0)).rounded() / 100
            charisma = (100 * Double.random(in: 3.0...5.0)).rounded() / 100
        case 180..<190:
            technics = (100 * Double.random(in: 5.0...7.0)).rounded() / 100
            artistry = (100 * Double.random(in: 5.0...7.0)).rounded() / 100
            skill = (100 * Double.random(in: 5.0...7.0)).rounded() / 100
            charisma = (100 * Double.random(in: 5.0...7.0)).rounded() / 100
        default:
            technics = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            artistry = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            skill = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            charisma = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
        }
        
        switch burpDuration {
        case 0..<2:
            technics += (100 * Double.random(in: 0.5...1)).rounded() / 100
            artistry += (100 * Double.random(in: 0.5...1)).rounded() / 100
            skill += (100 * Double.random(in: 0.5...1)).rounded() / 100
            charisma += (100 * Double.random(in: 0.5...1)).rounded() / 100
        case 2..<4:
            technics += (100 * Double.random(in: 1...1.5)).rounded() / 100
            artistry += (100 * Double.random(in: 1...1.5)).rounded() / 100
            skill += (100 * Double.random(in: 1...1.5)).rounded() / 100
            charisma += (100 * Double.random(in: 1...1.5)).rounded() / 100
        case 4..<8:
            technics += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            artistry += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            skill += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            charisma += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
        default:
            technics += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            artistry += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            skill += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            charisma += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
        }
        characterSum = technics + artistry + skill + charisma
        switch characterSum {
        case 0..<12:
            status = "Салага"
        case 12..<16:
            status = "Тёртый салага"
        case 16..<20:
            status = "Мужик"
        case 20..<24:
            status = "Матёрый"
        case 24..<28:
            status = "Крепкий специалист"
        case 28..<32:
            status = "Кувалда"
        default:
            status = "ОТВРАТИТЕЛЬНЫЙ МУЖИК"
        }
        print("Technics = \(technics)")
        print("Charisma = \(charisma)")
        print("Skill = \(skill)")
        print("Artistry = \(artistry)")
        print("Sum = \(characterSum)")
    }
    
    
    @IBAction func instagramButtonClick(_ sender: Any) {
        createImageForStory { (image, error) in
            if let myImage = image {
                shareOnInstagram(image: myImage)
            }
        }
        
    }
    
    
    func createImageForStory(completion: @escaping (_ result: UIImage?, _ error: String?) -> Void) {
        let size = CGSize.init(width: 1080, height: 1920)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let image = UIImage(named: "inst_3")
            image?.draw(in: rect)
            
            func drawStr(number: Double, y: CGFloat) {
                let technicsStr = "\(String(format: "%.2f", number))" as NSString
                
                let technicsAttributes = [
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 70),
                    NSAttributedString.Key.foregroundColor : UIColor.systemRed
                ]
                let technicsSize = technicsStr.size(withAttributes: technicsAttributes)
                technicsStr.draw(
                    in: CGRect(x: size.width / 2 - technicsSize.width / 2, y: y, width: technicsSize.width, height: technicsSize.height
                    ),
                    withAttributes: technicsAttributes
                )
            }
            
            // поле Техника
            drawStr(number: technics, y: 570)
            // поле Артистизм
            drawStr(number: artistry, y: 770)
            // поле Мастерство
            drawStr(number: skill, y: 1000)
            // поле Харизма
            drawStr(number: charisma, y: 1190)
            // поле Ранг
            let technicsAttributes = [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 82),
                NSAttributedString.Key.foregroundColor : UIColor.systemRed
            ]
            let technicsSize = status.size(withAttributes: technicsAttributes)
            status.draw(
                in: CGRect(x: size.width / 2 - technicsSize.width / 2, y: 1500, width: technicsSize.width, height: technicsSize.height
                ),
                withAttributes: technicsAttributes
            )
//                    let profileImage = UIImage(named: "krang_maskot")
//                    let rectImage = CGRect(x: 278, y: 102, width: 196, height: 196)
//                    let bezierPath = UIBezierPath(arcCenter: CGPoint(x: rectImage.midX, y: rectImage.midY), radius: 98, startAngle: 0, endAngle: 2.0*CGFloat(Double.pi), clockwise: true)
//                    context.addPath(bezierPath.cgPath)
//                    context.clip()
//                    profileImage?.draw(in: rectImage)
            
                    if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                        UIGraphicsEndImageContext()
                        completion(newImage, nil)
                    }
                    else {
                        UIGraphicsEndImageContext()
                        completion(nil, "Error 1")
                    }
            }
            else {
                completion(nil, "Error 3")
            }
            UIGraphicsEndImageContext()
        }
        
    }
    
    func shareOnInstagram(image:UIImage) {
      PHPhotoLibrary.requestAuthorization({
          (newStatus) in
              PHPhotoLibrary.shared().performChanges({
                  PHAssetChangeRequest.creationRequestForAsset(from: image)
              }, completionHandler: { success, error in
                  let fetchOptions = PHFetchOptions()
                  fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                  let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                  if let lastAsset = fetchResult.firstObject {
                      let localIdentifier = lastAsset.localIdentifier
                      let u = "instagram://library?LocalIdentifier=" + localIdentifier
                      DispatchQueue.main.async {
                          UIApplication.shared.open(URL(string: u)!, options: [:], completionHandler: nil)
                      }
                  }
              })
      })
    }
