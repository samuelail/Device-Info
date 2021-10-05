//
//  ViewController.swift
//  Device Info
//
//  Created by Samuel Ailemen on 10/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signatureImage: UIImageView!
    @IBOutlet weak var deviceImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set signature alpha as zero
        self.signatureImage.alpha = 0
        
        /*
         I like to do a little animation before i display the main ViewController.
         For this animation, i'll be animating the alpha level of the signature
         to give the effect of fading in. Once that is done, the view will animate
         to the main ViewController using the custom ViewController animation class.
         
        */
        //Animate signature alpha with a duration of 3 seconds
        UIView.animate(withDuration: 3.0, animations: {
            self.signatureImage.alpha = 1
        })
        
        // Finally animate to the main ViewController once the signature animation is done.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let VC =
                self.storyboard?.instantiateViewController(withIdentifier: "requestVC") as! RequestInfoViewController
            VC.modalTransitionStyle = .crossDissolve
            VC.modalPresentationStyle = .overFullScreen
            VC.cc_setZoomTransition(originalView: self.deviceImage)
            self.present(VC, animated: true, completion: nil)
        })
    }


}

