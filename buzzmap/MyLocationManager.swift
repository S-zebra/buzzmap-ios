//
//  LocationViewController.swift
//  buzzmap
//
//  Created by kazu on 2018/09/30.
//  Copyright © 2018年 uemtp2018. All rights reserved.
//

import CoreLocation

class MyLocationManager: CLLocationManager {
  private var locationManager: CLLocationManager!
  static var shared = MyLocationManager()
  private override init() {
    locationManager = CLLocationManager()
  }
}
