//: [Previous](@previous)

import MapKit
import PlaygroundSupport

class MapViewController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView(frame: .zero)
    var polyline = MKPolyline()
    
    override func loadView() {
        self.view = mapView
        mapView.delegate = self
    }
    
    func displayTrackPoints() {
        // Load points from JSON
        let points = getTrackPoints()
        
        // Transform points into a polyline for the map
        let coords: [CLLocationCoordinate2D] = points.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        polyline = MKPolyline(coordinates: coords, count: coords.count)
        
        // Add polyline to map
        mapView.add(polyline)

        // Zoom map to fit the points
        mapView.visibleMapRect = polyline.boundingMapRect
    }
    
    // MKMapView delegate method
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer = MKPolylineRenderer(polyline: polyline)
        overlayRenderer.strokeColor = .blue
        overlayRenderer.lineWidth = 3.0
        return overlayRenderer
    }
}

// Create map view controller
let mapViewController = MapViewController(nibName: nil, bundle: nil)
// Tell Playground to display the view
PlaygroundPage.current.liveView = mapViewController

// Tell map view controller to display the track points
mapViewController.displayTrackPoints()

//: [Next](@next)
