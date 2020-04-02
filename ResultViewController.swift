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

}
