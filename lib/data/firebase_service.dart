import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/device.dart';

class FirebaseService {
  final CollectionReference _deviceRef =
      FirebaseFirestore.instance.collection('devices');

  // Thêm / Sửa
  Future<void> saveDevice(Device device) async {
    return _deviceRef.doc(device.id).set(device.toMap());
  }

  // Lấy dữ liệu Realtime (Stream)
  Stream<List<Device>> getDevicesStream() {
    return _deviceRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Device.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Xóa
  Future<void> deleteDevice(String id) async {
    return _deviceRef.doc(id).delete();
  }
}
