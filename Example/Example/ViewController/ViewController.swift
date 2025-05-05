//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/9/21.
//

import UIKit
import WWLabel

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: WWLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = myLabel.startLoadingText(prefixString: "Loading")
    }
    
    @IBAction func stopLoading(_ sender: UIButton) {
        myLabel.stopLoadingText()
        myLabel.text = "iPhone 16e has an incredible design — inside and out — and is available in an elegant black or white finish. Made from durable aerospace‑grade aluminum, the enclosure on iPhone 16e is built to go the distance and survive life’s oops, whoops, and oh nooos."
    }
}

