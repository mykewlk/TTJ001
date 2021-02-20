//
//  ViewController.swift
//  TTJ001
//
//  Created by Rodney Hermes on 2/17/21.
//

import UIKit
import MapKit  //enables Map API
import CoreLocation  //enables User Location


class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tfTown: UITextField!
    @IBOutlet weak var tfCounty: UITextField!
    @IBOutlet weak var tfMaterial: UITextField!
    @IBOutlet weak var tfLong: UITextField!
    @IBOutlet weak var tfLat: UITextField!
    @IBOutlet weak var tfInfo: UITextField!
    @IBOutlet weak var tfRemoveJail: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    var annotation:MKPointAnnotation!
    

    
    @IBAction func buttonB(_ sender: UIButton) {
        self.getLocation()
        print("Jail Loaded!")
    }
    
    
    @IBAction func tfSubmit(_ sender: Any) {
        let newJail = Jail(context: self.context)
        newJail.town = tfTown.text
        newJail.material = tfMaterial.text
        newJail.county = tfCounty.text
        let lat:Double? = Double(tfLat.text!)
        let long:Double? = Double(tfLong.text!)
        newJail.lat = lat!
        newJail.long = long!
        
        
        do {
            try self.context.save()
        }
        catch {
            nameLabel.text = "Error"
        }
        
        
    }
    
    @IBAction func btnPrint(_ sender: Any) {
        self.fetchJail()
        var ct = 0
        let jailCt = items?.count
        
        if jailCt == 0 {
            print("Core Data is empty.")
            print("\n")
        }
        else{
        
        while ct < jailCt! {
            let jailLoaded = self.items![ct]
            //print(jailLoaded.town!)
            print(jailLoaded.county!)
            print(jailLoaded.material!)
            print(jailLoaded.lat)
            print(jailLoaded.long)
            print("DB Item#:  \(ct)")
            print("\n")
            ct+=1
        }
        }
        
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        
        self.deleteJail()
        
        
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Jail]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.fetchJail()
        var ct = 0
        let jailCt = items?.count
        
        while ct < jailCt! {
            let jailLoaded = self.items![ct]
            //print(jailLoaded.town!)
            print(jailLoaded.county!)
            print(jailLoaded.material!)
            print("DB Item#:  \(ct)")
            print("\n")
            ct+=1
        }
        */
    
        //let jailLoaded = self.items![3]
        //nameLabel.text = jailLoaded.name
        
        
        // Do any additional setup after loading the view.
        
    
    }
    
    func fetchJail() {
        do{
            self.items = try context.fetch(Jail.fetchRequest())
            DispatchQueue.main.async {
                //after DB is reloaded
                
            }
        }
        catch{
            
        }
    }
    
    func deleteJail() {
        var stringJail = tfRemoveJail.text
        var removeJail = Int(stringJail!)!
        let jailToRemove = self.items![removeJail]
        self.context.delete(jailToRemove)
        
        do{
            try self.context.save()
        }
        catch {
            
        }
        self.fetchJail()
        
    }
    
    func getLocation() {
        self.fetchJail()
        let jailCt = (items?.count)!
        let jailLoaded = self.items![jailCt-1]
        //let location = CLLocation(latitude: jailLoaded.lat, longitude: jailLoaded.long)
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(jailLoaded.lat, jailLoaded.long)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.region = region
        mapView.mapType = MKMapType.standard
        addAnnotation(coordinate, title: "The Jail", subtitle: "Texas" )
        
        
    }
    
    func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        
    }


}

