import UIKit

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
        if let image = UIImage(named: "krang_maskot") {
            //shareToInstagramStories(image: image)
            shareToInstagramFeed(image: image)
        }
    }
    
    func shareToInstagramStories(image: UIImage...) {
        // NOTE: you need a different custom URL scheme for Stories, instagram-stories, add it to your Info.plist!
        guard let instagramUrl = URL(string: "instagram-stories://share") else {
            return
        }

        if UIApplication.shared.canOpenURL(instagramUrl) {
            let pasterboardItems = [["com.instagram.sharedSticker.backgroundImage": image as Any]]
            UIPasteboard.general.setItems(pasterboardItems)
            UIApplication.shared.open(instagramUrl)
        } else {
            // Instagram app is not installed or can't be opened, pop up an alert
            print("Not working")
        }
    }
    
    func shareToInstagramFeed(image: UIImage) {
    // build the custom URL scheme
    guard let instagramUrl = URL(string: "instagram://app") else {
        print("Instagram not installed")
        return
    }

    // check that Instagram can be opened
    if UIApplication.shared.canOpenURL(instagramUrl) {
        // build the image data from the UIImage
        guard let imageData = image.jpegData(compressionQuality: 100) else {
            print("Wrong image jpegData")
            return
        }

        // build the file URL
        let path = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.ig")
        let fileUrl = URL(fileURLWithPath: path)

        // write the image data to the file URL
        do {
            
            try imageData.write(to: fileUrl, options: .atomic)
        } catch {
            // could not write image data
            print("Could not write image data")
            
            return
        }
        }
    }
    
}
