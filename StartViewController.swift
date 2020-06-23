//
//  StartViewController.swift
//  Burp
//
//  Created by Yuriy Pashkov on 4/25/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func pushButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if #available(iOS 13.0, *) {
        // улетаем на другой VC с подсчетами результата
            let resultVC = storyboard.instantiateViewController(identifier: "mainViewController") as UIViewController
            resultVC.modalPresentationStyle = .fullScreen   // VC на весь экран
            present(resultVC, animated: true, completion: nil)
        } else {
            let oldResultVC = storyboard.instantiateViewController(withIdentifier: "mainViewController") as UIViewController
            present(oldResultVC, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
