import 'package:flutter_carplay/models/map/map_button.dart';
import 'package:uuid/uuid.dart';

/// A template object that contains a collection of [CPMapTemplate] templates,
/// each of which occupies one tab in the tab bar.
class CPMapTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The array of map buttons as [CPMapButton] displayed on the trailing bottom
  /// corner of the map template. Note: The map template may display a maximum
  /// of 4 buttons. Setting more than 4 buttons to this property will only
  /// display the first 4 buttons.
  final List<CPMapButton> mapButtons;

  /// When creating a [CPMapTemplate], provide an base map to display behind the map template.
  CPMapTemplate({required this.mapButtons});

  Map<String, dynamic> toJson() => {
        "_elementId": _elementId,
        "mapButtons": mapButtons.map((e) => e.toJson()).toList(),
      };

  String get uniqueId {
    return _elementId;
  }
}
