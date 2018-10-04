//
//  ViewController.swift
//  buzzmap
//
//  Created by kazu on 9/26/18.
//  Copyright © 2018 uemtp2018. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class HomeViewController: UIViewController {
  @IBOutlet var myLocationButton: UIButton!
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
  var track = false
  let lm = MyLocationManager.shared

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    gestureRecognizer.delegate = self
    gestureRecognizer.addTarget(self, action: #selector(onMapPanned(_:)))
    lm.delegate = self
    lm.startUpdatingLocation()
  }

  override func viewDidAppear(_ animated: Bool) {
    let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05,
                                       longitudeDelta: 0.05)
    mapView.setRegion(MKCoordinateRegion(center: mapView.region.center,
                                         span: defaultSpan), animated: false)
    myLocationButtonTapped("_")
  }

  @IBAction func myLocationButtonTapped(_ sender: Any) {
    if CommonUtil.checkLocationPermission(self, manager: lm, status: CLLocationManager.authorizationStatus()) {
      myLocationButton.isSelected = true
      track = true
    }
  }

  @objc func onMapPanned(_ sender: Any) {
    myLocationButton.isSelected = false
    track = false
  }
}

extension HomeViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

extension HomeViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    CommonUtil.checkLocationPermission(self, manager: manager, status: status)
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    NSLog("Location arrived, \(locations.last!.description)")
    if track {
      mapView.setRegion(MKCoordinateRegion(center: locations.last!.coordinate,
                                           span: mapView.region.span), animated: true)
    }
  }
}
