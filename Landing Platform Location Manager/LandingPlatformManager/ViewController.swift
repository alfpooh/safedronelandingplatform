//
//  ViewController.swift
//  LandingPlatformManager
//
//  Created by donghoon bae on 2016. 11. 26..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapview: MKMapView!
    @IBAction func regBtn(_ sender: Any) {
        posting()
    }
    
    @IBOutlet weak var landingplatformName: UITextField!
    
    
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapview.showsUserLocation = true
        posting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapview.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
        latitude = location!.coordinate.latitude
        longitude = location!.coordinate.longitude
        
        print("mylocation is : \(location!.coordinate.latitude),\(location!.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Errors:" + error.localizedDescription)
    }
    
    func posting () {
        
        let myUrl = URL(string: "http://sample-env-1.nmp7pmu86m.us-west-2.elasticbeanstalk.com/")
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let Category = "A"
        let Name = "Alf's lading spot"
        let uniqueID = "alf0001"
        let Comment = "testingposting"
        let Availability = "true"
        let Temperature = "3"
        let Contact = "alfpooh@gmail.com"
        
        let postString = "Cateogry=\(Category)&Name=\(Name)&uniqueID=\(uniqueID)&latitude=\(latitude)&longitude=\(longitude)&Comment=\(Comment)&Availability=\(Availability)&Temperature=\(Temperature)&Contact=\(Contact)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
            print("posting.........!\(postString)")
            do {
                print("feedback received: \(data)")
                }
            catch {
                print("Last Error: \(error)")
            }
        }
        task.resume()
        
    }
    
    
}

