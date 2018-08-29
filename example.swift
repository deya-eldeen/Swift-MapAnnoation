import UIKit
import MapKit
import CoreLocation

class MapPickerVC: UIViewController {

    var map1 = MKMapView()
    var pointAnnotation:MKPointAnnotation = MKPointAnnotation()

    @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
        let location = gestureReconizer.location(in: map1)
        let coordinate = map1.convert(location,toCoordinateFrom: map1)
        pointAnnotation.coordinate = coordinate
    }

    override func viewDidAppear(_ animated: Bool) {
        map1 = self.view.viewWithTag(801) as! MKMapView
        map1.showsUserLocation = true
        map1.tintColor = UIColor.blue

        let initialLocation = CLLocation(latitude: Session.lat, longitude: Session.lon )
        self.centerMapOnLocation(initialLocation, map: map1, regionRadius: 707)
        var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Session.lat, longitude: Session.lon)
        pointAnnotation.coordinate = coordinates

        map1.addAnnotation(pointAnnotation)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        map1.addGestureRecognizer(gestureRecognizer)
    }

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    } 

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {return}
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        Session.lat = locValue.latitude
        Session.lon = locValue.longitude
    }
    
    func centerMapOnLocation(_ location: CLLocation,map : MKMapView, regionRadius : Double)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        map.setRegion(coordinateRegion, animated: false)
    }
}

extension MapPickerVC : UIGestureRecognizerDelegate {

}

extension MapPickerVC : CLLocationManagerDelegate
{

}
