//
//  ViewController.swift
//  Etikettierer2000
//
//  Created by Max Amanshauser on 24.10.18.
//  Copyright © 2018 Max Amanshauser. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    @IBOutlet weak var outputImage: NSImageView!
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func buttonClicked(_ sender: Any) {
        var name = textField.stringValue
        if name.isEmpty {
            name = "Hallo Klaus"
        }
        
        outputImage.image = generateCode128(from: name)
    }
    
    func generateCode128 (from string: String) -> NSImage? {
        if let data = string.data(using: .utf8) {
            if let bc = CIFilter(name : "CICode128BarcodeGenerator", parameters: [ "inputMessage" : data ] ) {
                if(bc.outputImage != nil) {
                    print("We have an output image.")
                    
                    return convert(image: bc.outputImage!)
                }
            }
        }
        return nil;
    }
    
    @IBAction func printButton(_ sender: Any) {
        let printView = NSImageView(frame: NSRect(x: 0, y: 0, width: 72*4, height: 72*6))
        let printInfo = NSPrintInfo()
        
        
        printInfo.bottomMargin = 0
        printInfo.topMargin = 0
        printInfo.leftMargin = 0
        printInfo.rightMargin = 0
        
        var name = textField.stringValue
        if name.isEmpty {
            name = "Hallo Klaus"
        }

        printView.image = generateCode128(from: name)
        
        let printOp = NSPrintOperation(view: printView, printInfo: printInfo)
        printOp.run()
    }
    /*    func generateBarcode(from string: String) -> NSImage? {
        if let data = string.data(using: .utf8) {

            let dm = CIDataMatrixCodeDescriptor(payload: data, rowCount: 10, columnCount: 10, eccVersion: CIDataMatrixCodeDescriptor.ECCVersion.v000)
            
            if let fi = CIFilter(name: "CIBarcodeGenerator", parameters: ["inputBarcodeDescriptor" : dm]){
                print("CIFilter created")
                
                if(fi.outputImage != nil) {
                    print("We have an output image.")
                }
                
                return nil;
//                return convert (image : fi.outputImage!)
            } else {
                return nil;
            }
        }
        return nil
    }*/
    
/*    func generateAztec(from string: String) -> NSImage? {
        if let data = string.data(using: .utf8) {
            
            let az = CIAztecCodeDescriptor(payload: data, isCompact: true, layerCount: 1, dataCodewordCount: 1)
            
            if let fi = CIFilter(name: "CIBarcodeGenerator", parameters: ["inputBarcodeDescriptor" : az]){
                print("CIFilter created")
                
                if(fi.outputImage != nil) {
                    print("We have an AZTEC image.")
                }
                
//                return nil;
                return convert (image : fi.outputImage!)
            } else {
                return nil;
            }
        }
        return nil
    }*/
    
    func convert(image: CIImage) -> NSImage {
        let rep = NSCIImageRep(ciImage: image)
        let nsImage = NSImage(size: image.extent.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
}

