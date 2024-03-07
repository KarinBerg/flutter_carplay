import 'package:uuid/uuid.dart';

/// A template object that contains a collection of [CPMapTemplate] templates,
/// each of which occupies one tab in the tab bar.
class CPMapTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// When creating a [CPMapTemplate], provide an base map to display behind the map template.
  CPMapTemplate();

  Map<String, dynamic> toJson() => {
        "_elementId": _elementId,
      };

  String get uniqueId {
    return _elementId;
  }
}
