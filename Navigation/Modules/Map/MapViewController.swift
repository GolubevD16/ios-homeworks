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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        setupMapView()
        configureMapView()
        checkUserLocationPermissions()
        addPin()
        //view.backgroundColor = UIColor(red: 0.54, green: 0.35, blue: 0.84, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Построить маршрут", style: .plain, target: self, action: #selector(addRoute))
    }
    
    private func setupMapView(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            let region = MKCoordinateRegion(center: centerCoordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkUserLocationPermissions(){
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        case .denied, .restricted:
            print("Требуется разрешение")
        
        @unknown default:
            fatalError("Не обрабатыаемый статус")
        }
    }
    
    private func addPin(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30)
        pin.title = "Пин"
        mapView.addAnnotation(pin)
    }
    
    @objc func addRoute(){
        let directionRequest = MKDirections.Request()
        
        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.9, longitude: 30.35))
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationPlaceMark = MKPlacemark(coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
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
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationPermissions()
    }
    
    
}
