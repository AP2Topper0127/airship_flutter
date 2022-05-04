/// Custom event object.
class CustomEvent {
  static const EVENT_NAME = "event_name";
  static const EVENT_VALUE = "event_value";
  static const PROPERTIES = "properties";
  static const TRANSACTION_ID = "transaction_id";
  static const INTERACTION_ID = "interaction_id";
  static const INTERACTION_TYPE = "interaction_type";

  /// The event name.
  final String name;

  /// The event value.
  final int? value;

  /// The event transaction ID.
  String? transactionId;

  /// The event interaction ID.
  String? interactionId;

  /// The event interaction type.
  String? interactionType;

  /// The event properties.
  var _properties = new Map<String, dynamic>();

  CustomEvent(String name, int? value)
      : this.name = name,
        this.value = value;

  /// Adds a property to the custom event.
  void addProperty(String key, dynamic value) {
    if (value == null) {
      throw ArgumentError.notNull('value');
    }
    _properties[key] = value;
  }

  /// Sets the custom event properties.
  void setProperties(Map<String, dynamic> properties) {
    properties.forEach((key,value) => _properties[key] = value);
  }

  Map<String, dynamic> toMap() {
    return {
      EVENT_NAME: name,
      EVENT_VALUE: value,
      PROPERTIES: _properties,
      TRANSACTION_ID: transactionId,
      INTERACTION_ID: interactionId,
      INTERACTION_TYPE: interactionType
    };
  }
}
