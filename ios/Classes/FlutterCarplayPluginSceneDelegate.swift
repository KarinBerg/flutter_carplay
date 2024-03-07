//
//  FlutterCarPlayPluginsSceneDelegate.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
open class FlutterCarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
  static private var interfaceController: CPInterfaceController?
  static private var mapController: FlutterCarPlayMapViewController?

  static public func setFlutterCarPlayMapViewController(controller: FlutterCarPlayMapViewController) {
    self.mapController = controller
  }

  static public func forceUpdateRootTemplate() {
    let rootTemplate = SwiftFlutterCarplayPlugin.rootTemplate
    let animated = SwiftFlutterCarplayPlugin.animated

    self.interfaceController?.setRootTemplate(rootTemplate!, animated: animated)
  }

  // Fired when just before the carplay become active
  public func sceneDidBecomeActive(_ scene: UIScene) {
    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.connected)
  }

  // Fired when carplay entered background
  public func sceneDidEnterBackground(_ scene: UIScene) {
    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.background)
  }

  static public func pop(animated: Bool) {
    self.interfaceController?.popTemplate(animated: animated)
  }

  static public func popToRootTemplate(animated: Bool) {
    self.interfaceController?.popToRootTemplate(animated: animated)
  }

  static public func push(template: CPTemplate, animated: Bool) {
    self.interfaceController?.pushTemplate(template, animated: animated)
  }

  static public func closePresent(animated: Bool) {
    self.interfaceController?.dismissTemplate(animated: animated)
  }

  static public func presentTemplate(template: CPTemplate, animated: Bool,
                                     onPresent: @escaping (_ completed: Bool) -> Void) {
    self.interfaceController?.presentTemplate(template, animated: animated, completion: { completed, error in
      guard error != nil else {
        onPresent(false)
        return
      }
      onPresent(completed)
    })
  }

  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didConnect interfaceController: CPInterfaceController) {
    FlutterCarPlaySceneDelegate.interfaceController = interfaceController

    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.connected)
    let rootTemplate = SwiftFlutterCarplayPlugin.rootTemplate

    guard rootTemplate != nil else {
      FlutterCarPlaySceneDelegate.interfaceController = nil
      return
    }

    FlutterCarPlaySceneDelegate.interfaceController?.setRootTemplate(rootTemplate!, animated: SwiftFlutterCarplayPlugin.animated)
  }

  // note: This method is provided only for navigation apps; other apps should use the variant that does not provide a window.
  open func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didConnect interfaceController: CPInterfaceController, to window: CPWindow) {
    FlutterCarPlaySceneDelegate.interfaceController = interfaceController

    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.connected)
    let rootTemplate = SwiftFlutterCarplayPlugin.rootTemplate

    guard rootTemplate != nil else {
      FlutterCarPlaySceneDelegate.interfaceController = nil
      return
    }

    if (rootTemplate is CPMapTemplate) {
      let mapViewController = FlutterCarPlaySceneDelegate.mapController
      guard mapViewController != nil else {
        FlutterCarPlaySceneDelegate.interfaceController = nil
        return
      }

      (rootTemplate as! CPMapTemplate).mapDelegate = mapViewController!

      // MapViewController is main view controller for the provided CPWindow.
      window.rootViewController = mapViewController
    }

    FlutterCarPlaySceneDelegate.interfaceController?.setRootTemplate(rootTemplate!, animated: SwiftFlutterCarplayPlugin.animated)
  }

  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didDisconnect interfaceController: CPInterfaceController, from window: CPWindow) {
    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.disconnected)

    //FlutterCarPlaySceneDelegate.interfaceController = nil
  }

  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didDisconnectInterfaceController interfaceController: CPInterfaceController) {
    SwiftFlutterCarplayPlugin.onCarplayConnectionChange(status: FCPConnectionTypes.disconnected)

    //FlutterCarPlaySceneDelegate.interfaceController = nil
  }

  /**
    If your application posts a @c CPNavigationAlert while backgrounded, a notification banner may be presented to the user.
    If the user taps on that banner, your application will launch on the car screen and this method will be called
    with the alert the user tapped.
    */
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didSelect navigationAlert: CPNavigationAlert){

  }

  /**
    If your application posts a @c CPManeuver while backgrounded, a notification banner may be presented to the user.
    If the user taps on that banner, your application will launch on the car screen and this method will be called
    with the maneuver the user tapped.
    */
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didSelect maneuver: CPManeuver){

  }

}
