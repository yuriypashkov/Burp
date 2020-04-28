

import UIKit
import AVFoundation
import Photos
//import Speech

var arrayOfDb = [Float]()
var burpDuration: Double = 0.0


class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var pushButton: UIButton!
    
    @IBOutlet weak var testBtn: UIButton!
    
//@available(iOS 13.0, *)
    @IBAction func testButtonClick(_ sender: Any) {
        
        arrayOfDb.append(-22.45)
        burpDuration = 2.7
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if #available(iOS 13.0, *) {
        // улетаем на другой VC с подсчетами результата
            let resultVC = storyboard.instantiateViewController(identifier: "ResultViewController") as UIViewController
            resultVC.modalPresentationStyle = .fullScreen   // VC на весь экран
            present(resultVC, animated: true, completion: nil)
        } else {
            let oldResultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as UIViewController
            present(oldResultVC, animated: true, completion: nil)
        }
    }
    
    var recordingSession: AVAudioSession!
    var meterTimer: Timer!
    var audioRecorder: AVAudioRecorder!
    
    var imageStop: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testBtn.isHidden = true
        
        imageStop = UIImage(named: "stopButton")
        
        // пишем отдельно аудио для измерений параметров
        recordingSession = AVAudioSession.sharedInstance()
        recordingSession.requestRecordPermission { (allowed) in
            if allowed {
                print("Request done")
            }
        }
        
        // button animation
        pushButton.addTarget(self, action: #selector(pushBtn(sender:)), for: .touchDown)
        pushButton.addTarget(self, action: #selector(upBtn(sender:)), for: .touchUpInside)
    }
    
    @objc func pushBtn(sender: UIButton) {
        self.animateView(sender)
    }
    
    @objc func upBtn(sender: UIButton) {
        self.animateUp(sender)
    }
    
    func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func animateUp(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
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
    
    
    //var buttonPushed = false
    //@available(iOS 13.0, *)
    @IBAction func pushStart(_ sender: Any) {
        
        pushButton.setImage(UIImage(named: "burpButton"), for: .normal)
        
        
        
        burpDuration = audioRecorder.currentTime
        meterTimer.invalidate()
        finishRecording(success: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if #available(iOS 13.0, *) {
        // улетаем на другой VC с подсчетами результата
            let resultVC = storyboard.instantiateViewController(identifier: "ResultViewController") as UIViewController
            resultVC.modalPresentationStyle = .fullScreen   // VC на весь экран
            present(resultVC, animated: true, completion: nil)
        } else {
            let oldResultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as UIViewController
            present(oldResultVC, animated: true, completion: nil)
        }

    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        
        //sender.tapEffect()
        
        DispatchQueue.main.async {
            self.pushButton.setImage(self.imageStop, for: .normal)
        }
        
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
        
    }
    
    
}

