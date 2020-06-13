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
import SMART

@objc (ShareViewController)

class ShareViewController: UIViewController {
    
    var pathToArchive: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        getURLOfExportedArchive()
    }
    
    @IBAction func shareData(_ sender: UIButton) {
        let ecgManager = EcgManager()
        ecgManager.importEcgsAndSendThemToServer(pathToArchive: pathToArchive)
    }
    
    private func getURLOfExportedArchive() {
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
                    self.pathToArchive = url.relativePath
                }
            })
        } else {
            print("error")
        }
    }
}
