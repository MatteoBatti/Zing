//
//  ZingAngleRecorderVC.swift
//  Zing
//
//  Created by Matteo Battistini on 21/03/16.
//  Copyright © 2016 Matteo Battistini. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import ChameleonFramework

func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}


class ZingAngleRecorderVC: UIViewController {
    
    lazy var motionManager = CMMotionManager()
    lazy var gmail = GMailSender()
    let queue = NSOperationQueue()
    var dateFormatter: NSDateFormatter?
    
    @IBOutlet weak var lblAngle: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var lblInfo: UILabel!
    
    var angle: Double = 0.0 {
        didSet {
            dispatch_async(dispatch_get_main_queue(),{
                self.lblAngle.text = "\(Int(self.angle))°"
            })
        }
    }
    
    var startSessionMessage: String?
    var endSessionMessage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gmail.setup()
        setupDateFormatter()
        motionManager.deviceMotionUpdateInterval = 0.01
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true
        showStart()
        setupAngleHandler()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        motionManager.stopDeviceMotionUpdates()
    }
    
    func setupAngleHandler() {
        motionManager.startDeviceMotionUpdatesToQueue(queue) { [unowned self] (deviceMotion, error) in
            if error == nil {
                self.angle = RadiansToDegrees((deviceMotion?.attitude.pitch)!)
            }
        }
    }
    
    func getDate() -> String {
        return (dateFormatter?.stringFromDate(NSDate()))!
    }
    
    func getUser() -> String {
        return "\(UD.stringForKey(key_first_name) ?? "") \(UD.stringForKey(key_last_name) ?? "")"
    }
    
    func getUserExtended() -> String {
        return "\(getUser()) - \(UD.stringForKey(key_cf) ?? "")"

    }
    
    func setupDateFormatter() {
        dateFormatter = NSDateFormatter()
        dateFormatter?.dateFormat = "dd/MM/yy HH:mm:ss"
    }
    
    @IBAction func startSession() {
        self.startSessionMessage = "START - \(getDate()) - ANGLE - \(lblAngle.text ?? "")"
        showStop()
    }
    
    @IBAction func endSession() {
        self.endSessionMessage = "STOP - \(getDate()) - ANGLE - \(lblAngle.text ?? "")"
        showSend()
    }
    
    
    @IBAction func sendMessage() {
        let htmlMessage = "<br/> \(getUserExtended()) <br/>\(startSessionMessage ?? "")<br/>\(endSessionMessage ?? "")"
        
        lblInfo.hidden = true
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        gmail.send(getUser(), message: htmlMessage) { (error) in
            
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
            
            if error == nil {
                self.showSuccessMessage()
                self.showStart()
            } else {
                self.showErrorMessage()
                self.showSend()
            }
        }
    }
    
    func showSuccessMessage() {
        lblInfo.hidden = false
        lblInfo.textColor = UIColor.flatGreenColor()
        lblInfo.text = "Dati Inviati con successo, Grazie!"
    }
    
    func showErrorMessage() {
        lblInfo.hidden = false
        lblInfo.textColor = UIColor.flatRedColor()
        lblInfo.text = "Errore nell'invio dei dati, vi pregiamo di riprovare."
    }
    
    func showStart() {
        activityIndicator.hidden = true
        btnStart.hidden = false
        btnStop.hidden = true
        btnSend.hidden = true
    }
    
    func showStop() {
        btnStart.hidden = true
        btnStop.hidden = false
        btnSend.hidden = true
    }
    
    func showSend() {
        btnStart.hidden = true
        btnStop.hidden = true
        btnSend.hidden = false
    }
    
    
}