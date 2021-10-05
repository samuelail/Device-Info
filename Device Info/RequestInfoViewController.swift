//
//  RequestInfoViewController.swift
//  Device Info
//
//  Created by Samuel Ailemen on 10/5/21.
//

import UIKit

class RequestInfoViewController: UIViewController {

    @IBOutlet weak var chargingIndicator: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Hide the charging indicator and only display it when we have determined that a phone is plugged in and charging.
        */
        
        self.chargingIndicator.isHidden = true
        
        // Determine if the device is plugged in and charging
        // We also want to monitor the state changes in real-time
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateDidChange),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Set battery monitor
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    @objc private func batteryStateDidChange() {
        let state = UIDevice.current.batteryState
        if state == .charging || state == .full {
            self.chargingIndicator.isHidden = false
        } else {
            self.chargingIndicator.isHidden = true
        }
    }
    //Begin device scan to get all device information
    @IBAction func beginScan(_ sender: Any) {
        let VC =
            self.storyboard?.instantiateViewController(withIdentifier: "resultVC") as! ResultsViewController
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .overFullScreen
        VC.cc_setZoomTransition(originalView: self.scanBtn)
        self.present(VC, animated: true, completion: nil)
    }
    

}
