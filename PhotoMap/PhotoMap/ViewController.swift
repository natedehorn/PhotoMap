//
//  ViewController.swift
//  PhotoMap
//
//  Created by Nathan DeHorn on 11/21/16.
//  Copyright © 2016 Nathan DeHorn. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagepicker: UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    
    /**
    Function called when "Take Photo" button is pressed
    */
    @IBAction func takePhoto(_ sender: Any) {
        imagepickersetup(source: .camera)
    }
    
    /**
     Function called when "Photo Library" button is pressed
     */
    @IBAction func photoLibrary(_ sender: Any) {
        imagepickersetup(source:.photoLibrary)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    Loads the photo selected into the app home screen
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        let url = info[UIImagePickerControllerReferenceURL] as! NSURL
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url as URL], options: nil)
        let asset = fetchResult.firstObject
        print("Latitude: \(asset!.location!.coordinate.latitude)")
        print("Longitude: \(asset!.location!.coordinate.longitude)")
    }
    
    /**
     Opens image source type
    */
    func imagepickersetup(source:UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            imagepicker = UIImagePickerController()
            imagepicker.delegate = self
            imagepicker.sourceType = source
            self.present(imagepicker, animated: true, completion: nil)
        }
    }
}
