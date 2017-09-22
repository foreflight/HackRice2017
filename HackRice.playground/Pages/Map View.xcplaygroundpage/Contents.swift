//: [Previous](@previous)

import MapKit
import PlaygroundSupport

class MapViewController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView(frame: .zero)
    
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
        super.viewDidLoad()
    }
}

PlaygroundPage.current.liveView = MapViewController(nibName: nil, bundle: nil)

//: [Next](@next)
