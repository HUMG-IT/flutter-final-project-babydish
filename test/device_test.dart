import 'package:flutter_test/flutter_test.dart';
import 'package:ai_lab_manager/models/device.dart'; // Đảm bảo đúng tên project của bạn

void main() {
  group('Device Model Tests', () {
    test('Device should be created with correct values', () {
      final device = Device(
        id: '123',
        name: 'NVIDIA Jetson Nano',
        type: 'Kit',
        quantity: 5,
        isOperational: true,
      );

      expect(device.id, '123');
      expect(device.name, 'NVIDIA Jetson Nano');
      expect(device.quantity, 5);
      expect(device.isOperational, true);
    });

    test('toMap should return valid map', () {
      final device = Device(
        id: '1',
        name: 'Test',
        type: 'GPU',
        quantity: 1,
        isOperational: false,
      );

      final map = device.toMap();

      expect(map['name'], 'Test');
      expect(map['isOperational'], false);
    });

    test('fromMap should create valid Device object', () {
      final map = {
        'id': '99',
        'name': 'Raspberry Pi 4',
        'type': 'IoT',
        'quantity': 10,
        'isOperational': true,
      };

      final device = Device.fromMap(map);

      expect(device.name, 'Raspberry Pi 4');
      expect(device.quantity, 10);
    });
  });
}
