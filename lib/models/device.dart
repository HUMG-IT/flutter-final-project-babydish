class Device {
  final String id;
  final String name;
  final String type;
  final int quantity;
  final bool isOperational;

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.isOperational,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'isOperational': isOperational,
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      quantity: map['quantity'] ?? 0,
      isOperational: map['isOperational'] ?? true,
    );
  }
}
