//
//  MyLocationManager.swift
//  tukumokkumokku
//
//  Created by kazu on 9/20/18.
//  Copyright © 2018 nakatake. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit

class CommonUtil: NSObject {
  public static func checkLocationPermission(_ vc: UIViewController, manager: CLLocationManager, status: CLAuthorizationStatus) -> Bool{
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      return true
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
      return true
    case .denied: // 全体でオフになっている、またはアプリに「許可しない」となっているとき
      alertLSDenied(vc, handler: nil)
      return false
    case .restricted: // 「機能制限」で位置情報サービスが禁止されているとき (Simulatorでは確認不可)
      alertLSRestricted(vc, handler: nil)
      return false
    }
  }

  public static func alertLSDenied(_ viewController: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    showAlert(viewController,
              title: "位置情報にアクセスできません",
              message: "「設定」アプリで、このアプリに位置情報へのアクセスが許可されているか確認してください。",
              handler: nil)
  }

  public static func alertLSRestricted(_ viewController: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    showAlert(viewController,
              title: "位置情報サービスが制限されています",
              message: "一部の機能はご利用いただけません。詳細については、デバイスの管理者にご確認ください。",
              handler: nil)
  }

  public static func showAlert(_ viewController: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: handler)
    controller.addAction(action)
    viewController.present(controller, animated: true)
  }
}
