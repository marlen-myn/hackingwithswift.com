//
//  MapView.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var contact: Person
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = contact.name
        annotation.coordinate = contact.placeCoordinate
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let town = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        uiView.setRegion(MKCoordinateRegion(center: contact.placeCoordinate, span: town), animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // will be called to provide a custom view to represent our map pin.
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
    }
}
