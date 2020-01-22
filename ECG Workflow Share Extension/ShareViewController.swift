//
//  ShareViewController.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import ZipArchive
import SwiftCSV

@objc (ShareViewController)

class ShareViewController: UIViewController {
    
    var relativePathToZip: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        getURLOfExportedZip()
    }
    
    private func getURLOfExportedZip() {
        // Load the shared file
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        let zip_type = String(kUTTypeZipArchive)
        
        // Store the zip files relative path
        if itemProvider.hasItemConformingToTypeIdentifier(zip_type) {
            itemProvider.loadItem(forTypeIdentifier: zip_type, options: nil, completionHandler: { (item, error) -> Void in
                guard let url = item as? NSURL else { return }
                //print("\(item.debugDescription)")
                OperationQueue.main.addOperation {
                    self.relativePathToZip = url.relativePath
                }
            })
        } else {
            print("error")
        }
    }
    
    @IBAction func shareData(_ sender: UIButton) {
        unzipFile()
        let reader = CSVImporter()
        let arrayWithCSVs = reader.getCSVs()
        let converter = FHIRConverter()
        let ecgsAsFHIR = converter.getFHIRInstancesFromCSV(allECGs: arrayWithCSVs)
        print("Done")
    }
    
    func unzipFile() {
        // This apps own document folder
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let relativePathToDocuments = documentsURL.relativePath
        
        // Unzip the export into this apps document folder. Will evaluate to false or nil if unsuccessful
        let unzip: Void? = try? SSZipArchive.unzipFile(atPath: relativePathToZip!, toDestination: relativePathToDocuments, overwrite: true, password: nil)
    }
    
   func blurView() {
       // https://stackoverflow.com/questions/17041669/creating-a-blurring-overlay-view/25706250
       // only apply the blur if the user hasn't disabled transparency effects

       if UIAccessibility.isReduceTransparencyEnabled == false {
           view.backgroundColor = .clear

           let blurEffect = UIBlurEffect(style: .dark)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)
           //always fill the view
           blurEffectView.frame = self.view.bounds
           blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

           view.insertSubview(blurEffectView, at: 0)
       } else {
           view.backgroundColor = .white
       }
   }
}
