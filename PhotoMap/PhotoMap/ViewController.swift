//
//  ViewController.swift
//  PhotoMap
//
//  Created by Nathan DeHorn on 11/21/16.
//  Copyright © 2016 Nathan DeHorn. All rights reserved.
//

import UIKit
import MapKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagepicker: UIImagePickerController!
    var selectedCoords: CLLocationCoordinate2D!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var mapView: MKMapView!

    /**
        Function called when "View My Map" button is pressed
    */
    @IBAction func viewMyMap(_ sender: Any) {
    }
    
    /**
        Function called when "Photo Library" button is pressed
    */
    @IBAction func photoLibrary(_ sender: Any) {
        imagepickersetup(source:.photoLibrary)
    }
    
    /**
        Function called when "Add to Map" button is pressed
    */
    @IBAction func addToMap(_ sender: Any) {
        if (imageView.image == nil) {
            print("No image selected")
            return
        }
        let annotation = MKPointAnnotation()
        print(selectedCoords)
        annotation.coordinate = selectedCoords
        mapView.addAnnotation(annotation)
    }
    
    /**
        Loads the photo selected into the app home screen
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            let url = info[UIImagePickerControllerReferenceURL] as! NSURL
            let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url as URL], options: nil)
            let asset = fetchResult.firstObject
            selectedCoords = CLLocationCoordinate2D(
                latitude: asset!.location!.coordinate.latitude,
                longitude: asset!.location!.coordinate.longitude
            )
        }
        self.dismiss(animated: true, completion: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
