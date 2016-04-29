//
//  ViewController.swift
//  FitNote
//
//  Created by Admin on 3/3/16.
//  Copyright © 2016 FitPeople. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    

    @IBOutlet weak var mapViewBox: GMSMapView!
    
    @IBOutlet weak var pin: UIImageView!
    //var gms: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    var searchedTypes = ["gym"]
    var placePicker: GMSPlacePicker!
    var latitude: Double!
    var longitude: Double!
    
    //var placesClient: GMSPlacesClient?
    
    //let dataProvider = GoogleDataProvider()
    //let searchRadius: Double = 1000
    
    
    @IBAction func refresh(sender: AnyObject) {
        fetchNearbyPlaces(mapViewBox.camera.target)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        
        if CLLocationManager.locationServicesEnabled()
            && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
                mapViewBox.myLocationEnabled = true
                //mapViewBox.userTrackingMode = .Follow
                
        }
        
        let  position = CLLocationCoordinate2DMake(10, 10)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapViewBox
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        mapViewBox.clear()
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            
            mapViewBox.myLocationEnabled = true
            mapViewBox.settings.myLocationButton = true
            mapViewBox.userInteractionEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
            
            let location:CLLocation = locations.last!
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            
            let coordinates = CLLocationCoordinate2DMake(self.latitude, self.longitude)
            let marker = GMSMarker(position: coordinates)
            marker.title = "POINT"
            marker.map = self.mapViewBox
            marker.tracksInfoWindowChanges = true
            
            
            self.mapViewBox.animateToLocation(coordinates)
            
            if let location = locations.first {
                
                mapViewBox.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
                
                locationManager.stopUpdatingLocation()
                
                print("location:: \(location)")
            }
            
            fetchNearbyPlaces(location.coordinate)
            
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
    
    
    
    
    
}

