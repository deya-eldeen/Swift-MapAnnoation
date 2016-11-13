var map1 = MKMapView()
var pointAnnotation:MKPointAnnotation = MKPointAnnotation()

func handleTap(gestureReconizer: UITapGestureRecognizer)
{
    let location = gestureReconizer.locationInView(map1)
    let coordinate = map1.convertPoint(location,toCoordinateFromView: map1)
    pointAnnotation.coordinate = coordinate
}

override func viewDidAppear(animated: Bool)
{
    map1 = self.scrollView.viewWithTag(801) as! MKMapView
    map1.showsUserLocation = true
    map1.tintColor = UIColor.blueColor()

    let initialLocation = CLLocation(latitude: ram.currentLat, longitude: ram.currentLon )
    self.centerMapOnLocation(initialLocation, map: map1, regionRadius: 707)
    var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: ram.currentLat, longitude: ram.currentLon)
    pointAnnotation.coordinate = coordinates

    map1.addAnnotation(pointAnnotation)

    let gestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
    gestureRecognizer.delegate = self
    map1.addGestureRecognizer(gestureRecognizer)
}
