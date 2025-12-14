import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/device.dart';
import '../data/firebase_service.dart';

class DeviceProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Device> _devices = [];
  bool _isLoading = true;

  List<Device> get devices => _devices;
  bool get isLoading => _isLoading;

  DeviceProvider() {
    // Tự động lắng nghe thay đổi từ Firebase ngay khi khởi tạo
    _listenToData();
  }

  void _listenToData() {
    _service.getDevicesStream().listen((data) {
      _devices = data;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addOrUpdateDevice(String? id, String name, String type,
      int quantity, bool isOperational) async {
    final String deviceId = id ?? const Uuid().v4();
    final newDevice = Device(
      id: deviceId,
      name: name,
      type: type,
      quantity: quantity,
      isOperational: isOperational,
    );
    await _service.saveDevice(newDevice);
  }

  Future<void> deleteDevice(String id) async {
    await _service.deleteDevice(id);
  }
}
