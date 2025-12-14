import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';
import 'edit_device_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe dữ liệu từ Provider
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Lab Inventory (Firebase)'),
        // Không cần nút Refresh nữa vì Firebase tự cập nhật realtime
      ),
      body: deviceProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : deviceProvider.devices.isEmpty
              ? const Center(child: Text("Chưa có thiết bị nào. Hãy thêm mới!"))
              : ListView.builder(
                  itemCount: deviceProvider.devices.length,
                  itemBuilder: (context, index) {
                    final device = deviceProvider.devices[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              device.isOperational ? Colors.green : Colors.red,
                          child: const Icon(Icons.memory, color: Colors.white),
                        ),
                        title: Text(device.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle:
                            Text('${device.type} | SL: ${device.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EditDeviceScreen(device: device)),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Hiển thị hộp thoại xác nhận xóa
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Xác nhận xóa'),
                                    content: const Text(
                                        'Bạn có chắc muốn xóa thiết bị này?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Hủy'),
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                      ),
                                      TextButton(
                                        child: const Text('Xóa',
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          deviceProvider
                                              .deleteDevice(device.id);
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditDeviceScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
