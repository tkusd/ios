//
//  QRCodeScanViewController.swift
//  
//
//  Created by SkyArrow on 2015/9/14.
//
//

import UIKit
import QRCodeReader
import AVFoundation

class QRCodeScanViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    lazy var reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: String) {
        println(result)
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        //
    }
}
