//: [Previous](@previous)

import MapKit
import PlaygroundSupport

class MapViewController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView(frame: .zero)
    
    var basicPolyline = MKPolyline()
    
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
        basicPolyline = MKPolyline(coordinates: coords, count: coords.count)
        
        // Add polyline to map
        mapView.add(basicPolyline)

        // Zoom map to fit the points
        mapView.visibleMapRect = basicPolyline.boundingMapRect
    }
    
    // MKMapView delegate method.
    // For each overlay we've added to the mapView,
    // this method is called to ask how the overlay should be rendered.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay as? MKPolyline == basicPolyline {
            let overlayRenderer = MKPolylineRenderer(polyline: basicPolyline)
            overlayRenderer.strokeColor = .blue
            overlayRenderer.lineWidth = 3.0
            return overlayRenderer
        }
        
        // If we added an overlay and forgot to define a renderer, return an uncustomized renderer.
        return MKOverlayRenderer(overlay: overlay)
    }
}

// Create map view controller
let mapViewController = MapViewController(nibName: nil, bundle: nil)
// Tell Playground to display the view
PlaygroundPage.current.liveView = mapViewController

// Tell map view controller to display the track points
mapViewController.displayTrackPoints()

//: [Next](@next)
