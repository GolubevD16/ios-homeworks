//
//  MapViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.07.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var mapView = MKMapView()
    private lazy var locationManager = CLLocationManager()
    
    private lazy var tap = UILongPressGestureRecognizer(target: self, action: #selector(foundTap))
    
    private lazy var deleteButton: UIButton = {
        deleteButton = UIButton()
        deleteButton.backgroundColor = UIColor(red: 14.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 0.8)
        deleteButton.addTarget(self, action: #selector(removePins), for: .touchUpInside)
        deleteButton.setTitle("delete all points".localized, for: .normal)
        deleteButton.toAutoLayout()
        mapView.addSubview(deleteButton)
        
        return deleteButton
    }()
    
    var actualRoute: MKPolyline?
    var actualRouteLoc: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        setupMapView()
        configureMapView()
        checkUserLocationPermissions()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Build a route".localized, style: .plain, target: self, action: #selector(addRoute))
    }
    
    private func setupMapView(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func configureMapView(){
        mapView.mapType = .hybridFlyover
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        
        let centerCoordinates = CLLocationCoordinate2D(latitude: 59.937500, longitude: 30.308611)
        mapView.setCenter(centerCoordinates, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let myLocation = self?.locationManager.location?.coordinate else { return }
            let region = MKCoordinateRegion(center: myLocation, latitudinalMeters: 100000, longitudinalMeters: 100000)
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkUserLocationPermissions(){
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = 50
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        case .denied, .restricted:
            print("Permission required".localized)
        
        @unknown default:
            fatalError("Status not being processed".localized)
        }
    }
    
    
    @objc func foundTap(_ recognizer: UITapGestureRecognizer) {
        let point: CGPoint = recognizer.location(in: mapView)
        let tapPoint: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
        actualRouteLoc = tapPoint
        let point1 = MKPointAnnotation()
        point1.coordinate = tapPoint
        mapView.addAnnotation(point1)
    }
    
    @objc func addRoute(){
        let directionRequest = MKDirections.Request()
        if let route = actualRoute {
            mapView.removeOverlay(route)
        }
        
        let sourcePlaceMark = MKPlacemark(coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        
        guard let route = actualRouteLoc else {
            showAlert()
            return
        }
        
        let destinationPlaceMark = MKPlacemark(coordinate: route)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.delegate = self
            self.actualRoute = route.polyline
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255, alpha: 1)
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error".localized, message: "You must specify the end point of the route".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func removePins(){
        let annotations = mapView.annotations.filter({ $0 !== self.mapView.userLocation })
        mapView.removeAnnotations(annotations)
        actualRoute = nil
        actualRouteLoc = nil
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationPermissions()
    }
}
