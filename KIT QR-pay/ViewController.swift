//
//  ViewController.swift
//  KIT QR-pay
//
//  Created by Baibuz Oleksandr on 16.11.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var qrImageOutlet: UIImageView!
    
    var structQR: QRStructDecoder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedQRimage))
        qrImageOutlet.addGestureRecognizer(tap)
        qrImageOutlet.isUserInteractionEnabled = true
    }
    
    @objc func tappedQRimage(_ sender: Any) {
        performSegue(withIdentifier: "openScannerSegue", sender: nil)
    }

    //--------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openScannerSegue"  {
            let contoller = (segue.destination as! UINavigationController).topViewController as! ScannerViewController
            contoller.didReadQRStruct  =  {  (ReadQRStruct) in
                self.structQR = ReadQRStruct
                self.performSegue(withIdentifier: "openPaySegue", sender: nil)
            }
        }
        if segue.identifier == "openPaySegue"  {
            let contoller = (segue.destination as! UINavigationController).topViewController as! applePayViewController
            contoller.structQR = self.structQR
        }
    }

}

