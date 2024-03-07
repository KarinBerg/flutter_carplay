//
//  FCPMapButton.swift
//  flutter_carplay
//
//  Created by Karin Berg on 07.03.2024.
//

import CarPlay

@available(iOS 14.0, *)
class FCPMapButton {
  private(set) var _super: CPMapButton?
  private(set) var elementId: String
  private var isEnabled: Bool
  private var isHidden: Bool
  private var image: String

  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.image = obj["image"] as! String
    self.isEnabled = obj["isEnabled"] as! Bool
    self.isHidden = obj["isHidden"] as! Bool
  }

  var get: CPMapButton {
    let mapButton = CPMapButton.init(handler: { _ in
                                          DispatchQueue.main.async {
                                            FCPStreamHandlerPlugin.sendEvent(type: FCPChannelTypes.onMapButtonPressed,
                                                                            data: ["elementId": self.elementId])
                                          }
                                        }
                                    )

    mapButton.image = UIImage().fromFlutterAsset(name: self.image)
    mapButton.isEnabled = self.isEnabled
    mapButton.isHidden = self.isHidden

    self._super = mapButton
    return mapButton
  }
}
