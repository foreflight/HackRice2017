//: [Previous](@previous)

import MapKit
import PlaygroundSupport

class MapViewController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView(frame: .zero)
    var polyline = MKPolyline()
    
    lazy var trackPoints: [TrackPoint] = {
        return getTrackPoints()
    }()
    
    override func loadView() {
        self.view = mapView

        NSLayoutConstraint.activate(
            [mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
             mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
             mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
             mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)]
        )
    }
    
    override func viewDidLoad() {
        mapView.delegate = self
        displayTrackPoints()
        super.viewDidLoad()
    }
    
    func displayTrackPoints() {
        DispatchQueue.global(qos: .userInitiated).async {
            _ = self.trackPoints //force lazy load
            DispatchQueue.main.async {
                self.addTrackPointOverlay()
                self.mapView.visibleMapRect = self.polyline.boundingMapRect
            }
        }
    }
    
    func addTrackPointOverlay() {
        polyline = generatePolyline(trackPoints: self.trackPoints)
        self.mapView.add(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer = MKPolylineRenderer(polyline: polyline)
        overlayRenderer.strokeColor = .blue
        overlayRenderer.lineWidth = 3.0
        return overlayRenderer
    }
    
}

func generatePolyline(trackPoints: [TrackPoint]) -> MKPolyline {
    let coords: [CLLocationCoordinate2D] = trackPoints.map {
        CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
    }
    let polyline = MKPolyline(coordinates: coords, count: coords.count)
    return polyline
}

PlaygroundPage.current.liveView = MapViewController(nibName: nil, bundle: nil)

//: [Next](@next)
