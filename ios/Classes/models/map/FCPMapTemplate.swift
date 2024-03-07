//
//  FCPMapTemplate.swift
//  flutter_carplay
//
//  Created by Karin Berg on 23.02.2024.
//

import CarPlay

@available(iOS 12.0, *)
class FCPMapTemplate {
  private(set) var elementId: String
  private var automaticallyHidesNavigationBar: Bool = true
  private var hidesButtonsWithNavigationBar: Bool = true
  private var mapButtons: [CPMapButton] = []
  private var objcMapButtons: [FCPMapButton] = []

  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.automaticallyHidesNavigationBar = obj["automaticallyHidesNavigationBar"] as? Bool ?? true
    self.hidesButtonsWithNavigationBar = obj["hidesButtonsWithNavigationBar"] as? Bool ?? true

    self.objcMapButtons = (obj["mapButtons"] as! Array<[String : Any]>).map {
      FCPMapButton(obj: $0)
    }
    self.mapButtons = self.objcMapButtons.map {
      $0.get
    }
  }

  var get: CPMapTemplate {
    let mapTemplate = CPMapTemplate.init()
    mapTemplate.automaticallyHidesNavigationBar = automaticallyHidesNavigationBar
    mapTemplate.hidesButtonsWithNavigationBar = hidesButtonsWithNavigationBar
    mapTemplate.mapButtons = self.mapButtons
    return mapTemplate
  }
}

@available(iOS 12.0, *)
extension FCPMapTemplate: FCPRootTemplate { }
