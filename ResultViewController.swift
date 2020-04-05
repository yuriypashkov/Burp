import UIKit
import Photos

class ResultViewController: UIViewController {

    @IBOutlet weak var maxDbLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartButtonClick(_ sender: Any) {
        arrayOfDb.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true // свойство для того чтобы нельзя было смахнуть экран
        
        
        restartButton.layer.cornerRadius = restartButton.frame.width / 2
        
        var maxDb = arrayOfDb[0]
        for db in arrayOfDb {
            if db > maxDb {
                maxDb = db
            }
        }
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor.systemRed
        spinner.center = self.view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        
        runAfter(seconds: 2) {
            spinner.removeFromSuperview()
            self.maxDbLabel.text = String(format: "%.2f", maxDb)
            self.durationLabel.text = String(format: "%.2f", burpDuration)
        }
        
    }

    @IBAction func instagramButtonClick(_ sender: Any) {
//        print("full Screenshot")
//            UIGraphicsBeginImageContext(self.view.frame.size)
//            self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
//            self.sourceImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//            UIImageWriteToSavedPhotosAlbum(self.sourceImage, nil, nil, nil)
        
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
            let image = UIImage(named: "back_1")
            image?.draw(in: rect)
            let username = "username" as NSString
            
            let usernameAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 38),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            let usernameSize = username.size(withAttributes: usernameAttributes)
            username.draw(
                in: CGRect(x: size.width / 2 - usernameSize.width / 2, y: size.height / 2, width: usernameSize.width, height: usernameSize.height
                ),
                withAttributes: usernameAttributes
            )
                    let profileImage = UIImage(named: "krang_maskot")
                    let rectImage = CGRect(x: 278, y: 102, width: 196, height: 196)
                    let bezierPath = UIBezierPath(arcCenter: CGPoint(x: rectImage.midX, y: rectImage.midY), radius: 98, startAngle: 0, endAngle: 2.0*CGFloat(Double.pi), clockwise: true)
                    context.addPath(bezierPath.cgPath)
                    context.clip()
                    profileImage?.draw(in: rectImage)
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
    
//    func shareToInstagramStories(image: UIImage...) {
//        // NOTE: you need a different custom URL scheme for Stories, instagram-stories, add it to your Info.plist!
//        guard let instagramUrl = URL(string: "instagram-stories://share") else {
//            return
//        }
//
//        if UIApplication.shared.canOpenURL(instagramUrl) {
//            let pasterboardItems = [["com.instagram.sharedSticker.backgroundImage": image as Any]]
//            UIPasteboard.general.setItems(pasterboardItems)
//            UIApplication.shared.open(instagramUrl)
//        } else {
//            // Instagram app is not installed or can't be opened, pop up an alert
//            print("Not working")
//        }
//    }
