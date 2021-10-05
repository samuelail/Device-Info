//
//  ResultsViewController.swift
//  Device Info
//
//  Created by Samuel Ailemen on 10/5/21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalStorageTxt: UILabel!
    @IBOutlet weak var usedStorageTxt: UILabel!
    @IBOutlet weak var batteryTxt: UILabel!
    @IBOutlet weak var remainingStorageTxt: UILabel!
    @IBOutlet weak var battery: BatteryView!
    @IBOutlet weak var deviceTypeTxt: UILabel!
    @IBOutlet weak var wifiConnectedTxt: UILabel!
    @IBOutlet weak var lowPowerTxt: UILabel!
    @IBOutlet weak var carrierTxt: UILabel!
    @IBOutlet weak var bootTimeTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        battery.borderWidth = 4
        battery.borderColor = UIColor.clear
        battery.highLevelColor = hexStringToUIColor(hex: "63D6BC")
        battery.lowLevelColor = hexStringToUIColor(hex: "d63031")
        battery.lowThreshold = 40
     //   battery.backgroundColor = UIColor.lightGray
        battery.level = Int(Luminous.Battery.level ?? -1)
        
        
        //SET LABEL VALUES
        self.totalStorageTxt.text = "Total Space: \(Luminous.Disk.totalSpace)"
        self.usedStorageTxt.text = "Used Space: \(Luminous.Disk.usedSpace)"
        self.remainingStorageTxt.text = "Available Space: \(Luminous.Disk.freeSpace)"
        
        self.deviceTypeTxt.text = "Device Type: \(Luminous.Hardware.Device.current.type)"
        self.wifiConnectedTxt.text = "Wifi Connected: \(Luminous.Network.isConnectedViaWiFi)"
        if #available(iOS 9.0, *) {
            self.lowPowerTxt.text = "Low Power Mode: \(Luminous.Hardware.isLowPowerModeEnabled)"
        }
        
        
        self.carrierTxt.text = "Network Carrier:  \(Luminous.Carrier.name ?? "-")"
        
        self.bootTimeTxt.text = "Boot Time: \(Luminous.Hardware.physicalMemory(with: Luminous.MeasureUnit.megabytes))"
        
        self.batteryTxt.text = "Battery percent: \(Luminous.Battery.level ?? -1)%"
        

    }
    
    //Custom function to convert HEX string to UIColor
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
