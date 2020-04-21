

import UIKit
import AVFoundation
import Photos
//import Speech

var arrayOfDb = [Float]()
var burpDuration: Double = 0.0


class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var previewView: PreviewView!
    
    @IBOutlet weak var testBtn: UIButton!
    
    @IBAction func testButtonClick(_ sender: Any) {
        
        arrayOfDb.append(-22.45)
        burpDuration = 2.7
        
        // улетаем на другой VC с подсчетами результата
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewController(identifier: "ResultViewController") as UIViewController
        resultVC.modalPresentationStyle = .fullScreen   // VC на весь экран
        present(resultVC, animated: true, completion: nil)
    }
    
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    private let session = AVCaptureSession()
    
    @objc dynamic var videoDeviceInput: AVCaptureDeviceInput!
    
    // Communicate with the session and other session objects on this queue.
    private let sessionQueue = DispatchQueue(label: "session queue")
    private var setupResult: SessionSetupResult = .success
 //   private var spinner: UIActivityIndicatorView!
    
    var recordingSession: AVAudioSession!
    var meterTimer: Timer!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testBtn.isHidden = true
        
//        let circleImage = UIImageView(frame: CGRect(x: previewView.frame.origin.x, y: previewView.frame.origin.y, width: previewView.bounds.size.width + 20, height: previewView.bounds.size.height + 20))
//        circleImage.image = UIImage(named: "circle")
//        
//        view.addSubview(circleImage)
        
        pushButton.layer.cornerRadius = pushButton.frame.width / 2
        previewView.layer.cornerRadius = previewView.frame.width / 2
        
        previewView.session = session
        
        let rootLayer: CALayer = previewView.layer
        rootLayer.masksToBounds = true
       // rootLayer.borderWidth = 5
        //rootLayer.borderColor = UIColor(red: 245/255, green: 82/255, blue: 123/255, alpha: 0.7).cgColor
        previewView.videoPreviewLayer.frame = rootLayer.bounds
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
        default:
            setupResult = .notAuthorized
        }
        
        sessionQueue.async {
            self.configureSession()
        }
        
//        DispatchQueue.main.async {
//            self.spinner = UIActivityIndicatorView(style: .large)
//            self.spinner.color = UIColor.white
//            self.previewView.addSubview(self.spinner)
//        }
        // пишем отдельно аудио для измерений параметров
        recordingSession = AVAudioSession.sharedInstance()
        
    }
    
    // ФУНКЦИОНАЛ ЗАПИСИ АУДИО ОТДЕЛЬНО
    @objc func updateAudioMeter(_ timer: Timer) {
        if let recorder = self.audioRecorder {
            if recorder.isRecording {
                let myAver = recorder.averagePower(forChannel: 0)
                arrayOfDb.append(myAver)
                recorder.updateMeters()
            }
        }
    }
    
    func startRecording() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent("tempRecording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            audioRecorder.isMeteringEnabled = true
        } catch {
            finishRecording(success: false)
        }
        
    }
    
    func finishRecording(success: Bool) {
       // print("\(String(format: "%.2f", audioRecorder.currentTime))")
        audioRecorder.stop()
        audioRecorder.deleteRecording()
        audioRecorder = nil

        if success {
            //myRecordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            //myRecordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    private func configureSession() {
           if setupResult != .success {
               return
           }
           
           session.beginConfiguration()
           session.sessionPreset = .photo
        
           let movieFileOutput = AVCaptureMovieFileOutput()
           
           if self.session.canAddOutput(movieFileOutput) {
               self.session.beginConfiguration()
               self.session.addOutput(movieFileOutput)
               self.session.sessionPreset = .high
               if let connection = movieFileOutput.connection(with: .video) {
                   if connection.isVideoStabilizationSupported {
                       connection.preferredVideoStabilizationMode = .auto
                   }
               }
               self.session.commitConfiguration()
            }
            self.movieFileOutput = movieFileOutput
           
           // Add video input.
           do {
               var defaultVideoDevice: AVCaptureDevice?
            defaultVideoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            
               guard let videoDevice = defaultVideoDevice else {
                   print("Default video device is unavailable.")
                   setupResult = .configurationFailed
                   session.commitConfiguration()
                   return
               }
               let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
               
               if session.canAddInput(videoDeviceInput) {
                   session.addInput(videoDeviceInput)
                   self.videoDeviceInput = videoDeviceInput
                   
                   DispatchQueue.main.async {
                       let initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                       self.previewView.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
                       //self.previewView.videoPreviewLayer.cornerRadius = self.previewView.frame.width
                   }
               } else {
                   print("Couldn't add video device input to the session.")
                   setupResult = .configurationFailed
                   session.commitConfiguration()
                   return
               }
           } catch {
               print("Couldn't create video device input: \(error)")
               setupResult = .configurationFailed
               session.commitConfiguration()
               return
           }
           
           // Add an audio input device.
           do {
               let audioDevice = AVCaptureDevice.default(for: .audio)
               let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
               
               if session.canAddInput(audioDeviceInput) {
                   session.addInput(audioDeviceInput)
               } else {
                   print("Could not add audio device input to the session")
               }
           } catch {
               print("Could not create audio device input: \(error)")
           }
           
           session.commitConfiguration()
       }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          sessionQueue.async {
              switch self.setupResult {
              case .success:
                  // Only setup observers and start the session if setup succeeded.
                  //self.addObservers()
                  self.session.startRunning()
                  //self.isSessionRunning = self.session.isRunning
              case .notAuthorized:
                  DispatchQueue.main.async {
                      let changePrivacySetting = "Burp doesn't have permission to use the camera, please change privacy settings"
                      let message = NSLocalizedString(changePrivacySetting, comment: "Alert message when the user has denied access to the camera")
                      let alertController = UIAlertController(title: "Burp", message: message, preferredStyle: .alert)
                      
                      alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                              style: .cancel,
                                                              handler: nil))
                      
                      alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                              style: .`default`,
                                                              handler: { _ in
                                                                  UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                                            options: [:],
                                                                                            completionHandler: nil)
                      }))
                      
                      self.present(alertController, animated: true, completion: nil)
                  }
                  
              case .configurationFailed:
                  DispatchQueue.main.async {
                      let alertMsg = "Alert message when something goes wrong during capture session configuration"
                      let message = NSLocalizedString("Unable to capture media", comment: alertMsg)
                      let alertController = UIAlertController(title: "Burp", message: message, preferredStyle: .alert)
                      
                      alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                              style: .cancel,
                                                              handler: nil))
                      
                      self.present(alertController, animated: true, completion: nil)
                  }
              }
          }
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        sessionQueue.async {
            if self.setupResult == .success {
                self.session.stopRunning()
               // self.isSessionRunning = self.session.isRunning
               // self.removeObservers()
            }
        }
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: Recording Movies
    
    private var movieFileOutput: AVCaptureMovieFileOutput?
    private var backgroundRecordingID: UIBackgroundTaskIdentifier?
    
    var buttonPushed = false
    
    @IBAction func pushStart(_ sender: Any) {
        guard let movieFileOutput = self.movieFileOutput else {
            return
        }
        
        buttonPushed = !buttonPushed
        
        if buttonPushed {
//            pushButton.backgroundColor = .systemRed
//            pushButton.setTitle("STOP", for: .normal)
            pushButton.setImage(UIImage(named: "stopButton"), for: .normal)
            // пишем аудио
            do {
                try recordingSession.setCategory(.playAndRecord, mode: .default)
                try recordingSession.setActive(true)
                
                recordingSession.requestRecordPermission { [unowned self] allowed in
                    DispatchQueue.main.async {
                        if allowed {
                            self.meterTimer = Timer.scheduledTimer(timeInterval: 0.2,
                            target: self,
                            selector: #selector(self.updateAudioMeter(_:)),
                            userInfo: nil,
                            repeats: true)
                            
                        } else {
                            print("Failed to record")
                        }
                    }
                }
            } catch  {
                // error
            }
            
            startRecording()
            
        } else {
//            pushButton.backgroundColor = UIColor(red: 115/255, green: 36/255, blue: 166/255, alpha: 1.0)
//            pushButton.setTitle("РЫГАТЬ", for: .normal)
            pushButton.setImage(UIImage(named: "burpButton"), for: .normal)
            
            burpDuration = audioRecorder.currentTime
            meterTimer.invalidate()
            finishRecording(success: true)
            
            // улетаем на другой VC с подсчетами результата
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewController(identifier: "ResultViewController") as UIViewController
            resultVC.modalPresentationStyle = .fullScreen   // VC на весь экран
            present(resultVC, animated: true, completion: nil)
        }

        
        sessionQueue.async {
            if !movieFileOutput.isRecording {
                if UIDevice.current.isMultitaskingSupported {
                    self.backgroundRecordingID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
                }
                
                // написать обработчик исключительной ситуации, когда нет доступа к камере, ВОТ ЗДЕСЬ
                
                // Start recording video to a temporary file.
                let outputFileName = NSUUID().uuidString
                let outputFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
                movieFileOutput.startRecording(to: URL(fileURLWithPath: outputFilePath), recordingDelegate: self)
            } else {
                movieFileOutput.stopRecording()
            }
        }
        
    }
    
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        // Note: Because we use a unique file path for each recording, a new recording won't overwrite a recording mid-save.
        func cleanup() {
            let path = outputFileURL.path
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    print("Could not remove file at url: \(outputFileURL)")
                }
            }
            
            if let currentBackgroundRecordingID = backgroundRecordingID {
                backgroundRecordingID = UIBackgroundTaskIdentifier.invalid
                
                if currentBackgroundRecordingID != UIBackgroundTaskIdentifier.invalid {
                    UIApplication.shared.endBackgroundTask(currentBackgroundRecordingID)
                }
            }
        }
  
        var success = true
        
        if error != nil {
            print("Movie file finishing error: \(String(describing: error))")
            success = (((error! as NSError).userInfo[AVErrorRecordingSuccessfullyFinishedKey] as AnyObject).boolValue)!
        }
        
        if success {
            // Check the authorization status.
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    // Save the movie file to the photo library and cleanup.
                    PHPhotoLibrary.shared().performChanges({
                        let options = PHAssetResourceCreationOptions()
                        options.shouldMoveFile = true
                        let creationRequest = PHAssetCreationRequest.forAsset()
                        creationRequest.addResource(with: .video, fileURL: outputFileURL, options: options)
                    }, completionHandler: { success, error in
                        if !success {
                            print("Burp couldn't save the movie to your photo library: \(String(describing: error))")
                        }
                        cleanup()
                    }
                    )
                } else {
                    cleanup()
                }
            }
        } else {
            cleanup()
        }
    }
    
//    override open var shouldAutorotate: Bool {
//        return false
//    }
    
}

