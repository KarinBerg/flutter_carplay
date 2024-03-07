import 'package:uuid/uuid.dart';

/// A map button object displayed on a map template.
class CPMapButton {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The image displayed on the button.
  ///
  /// Image asset path in pubspec.yaml file.
  /// For example: images/flutter_logo.png
  ///
  /// **[!] When creating a map button, do NOT provide an animated image. If you do, the button
  /// uses the first image in the animation sequence.**
  final String image;

  /// The image displayed on the button when focused.
  ///
  /// Image asset path in pubspec.yaml file.
  /// For example: images/flutter_logo.png
  ///
  /// **[!] When creating a map button, do NOT provide an animated image. If you do, the button
  /// uses the first image in the animation sequence.**
  /// TODO:Support this: final String focusedImage;

  /// A Boolean value indicating whether the button is hidden.
  final bool isHidden = false;

  /// A Boolean value indicating whether the button is enabled.
  final bool isEnabled = true;

  /// Fired after the user taps the button.
  final Function() onPress;

  CPMapButton({
    required this.image,
    required this.onPress,
  });

  Map<String, dynamic> toJson() => {
        "_elementId": _elementId,
        "image": image,
        "isEnabled": isEnabled,
        "isHidden": isHidden,
      };

  String get uniqueId {
    return _elementId;
  }
}
