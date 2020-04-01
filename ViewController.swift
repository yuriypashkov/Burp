

import UIKit
import AVFoundation


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var pushButton: UIButton!
    // вьюху пришлось вытянуть в высоту, т.к. если сделать ее квадратной, камера криво вписывает картинку во вьюху, ибо прямоугольная
    @IBOutlet weak var videoView: UIView!
    
    @IBAction func pushStart(_ sender: Any) {
        imagePickers?.startVideoCapture()
    }
    
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var imagePickers: UIImagePickerController?
    
    let videoFileName = "/video.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushButton.layer.cornerRadius = pushButton.frame.width / 2
        videoView.layer.cornerRadius = videoView.frame.width / 2
        addCameraView()
//        if let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
//
//        } else {
//            // not found camera
//            fatalError("Not found front camera")
//        }
        //present(imagePickers!, animated: true, completion: nil)
    }

    func addCameraView() {
        imagePickers = UIImagePickerController()
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front) {
            imagePickers?.delegate = self
            imagePickers?.sourceType = UIImagePickerController.SourceType.camera
            imagePickers?.cameraDevice = UIImagePickerController.CameraDevice.front
            
            addChild(imagePickers!)
            
            videoView.addSubview((imagePickers?.view)!)
            imagePickers?.view.frame = videoView.bounds
            imagePickers?.allowsEditing = false
            imagePickers?.showsCameraControls = false
            imagePickers?.view.layer.cornerRadius = videoView.frame.width / 2
            imagePickers?.view.autoresizingMask = [.flexibleWidth,  .flexibleHeight]
            
        }
    }
    
}

