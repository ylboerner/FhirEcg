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
import CSV

@objc (ShareViewController)

class ShareViewController: UIViewController {
    
    var relativePathToZip: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        getURLOfExportedZip()
    }
    
    @IBAction func shareData(_ sender: UIButton) {
        unzipExport()
        let reader = CSVImporter()
        let arrayWithCSVs = reader.getCSVs()
        let converter = FHIRConverter()
        let ecgsAsFHIR = converter.getFHIRInstancesFromCSV(allECGs: arrayWithCSVs)
        print("Done")
    }
    
    func unzipExport() {
        let unzipper = Unzipper()
        unzipper.unzipFile(relativePathToZip: relativePathToZip)
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
}
