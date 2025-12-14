import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device.dart';
import '../providers/device_provider.dart';

class EditDeviceScreen extends StatefulWidget {
  // Nếu device là null => Thêm mới. Nếu có dữ liệu => Sửa.
  final Device? device;

  const EditDeviceScreen({super.key, this.device});

  @override
  State<EditDeviceScreen> createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Khởi tạo các biến để lưu dữ liệu form
  late String _name;
  late String _type;
  late int _quantity;
  late bool _isOperational;

  @override
  void initState() {
    super.initState();
    // Kiểm tra xem là đang Sửa hay Thêm mới để điền dữ liệu ban đầu
    if (widget.device != null) {
      _name = widget.device!.name;
      _type = widget.device!.type;
      _quantity = widget.device!.quantity;
      _isOperational = widget.device!.isOperational;
    } else {
      _name = '';
      _type = '';
      _quantity = 1;
      _isOperational = true;
    }
  }

  // Hàm xử lý khi nhấn nút Lưu
  void _saveForm() {
    // 1. Validate dữ liệu (check rỗng, số lượng > 0...)
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // 2. Gọi Provider để lưu vào database (Localstore)
      // Nếu widget.device?.id là null thì Provider sẽ tự tạo ID mới (Logic thêm mới)
      Provider.of<DeviceProvider>(context, listen: false).addOrUpdateDevice(
        widget.device?.id,
        _name,
        _type,
        _quantity,
        _isOperational,
      );

      // 3. Hiển thị thông báo và quay lại màn hình danh sách
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã lưu dữ liệu thành công!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.device == null ? 'Thêm Thiết Bị Mới' : 'Cập Nhật Thiết Bị'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- Nhập Tên Thiết Bị ---
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: 'Tên thiết bị',
                  hintText: 'Ví dụ: NVIDIA RTX 4090',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên thiết bị';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),

              // --- Nhập Loại Thiết Bị ---
              TextFormField(
                initialValue: _type,
                decoration: const InputDecoration(
                  labelText: 'Loại thiết bị',
                  hintText: 'Ví dụ: GPU, Sensor, Kit',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập loại thiết bị';
                  }
                  return null;
                },
                onSaved: (value) => _type = value!,
              ),
              const SizedBox(height: 16),

              // --- Nhập Số Lượng ---
              TextFormField(
                initialValue: _quantity.toString(),
                decoration: const InputDecoration(
                  labelText: 'Số lượng',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Vui lòng nhập số lượng';
                  if (int.tryParse(value) == null) return 'Phải nhập số';
                  if (int.parse(value) <= 0) return 'Số lượng phải lớn hơn 0';
                  return null;
                },
                onSaved: (value) => _quantity = int.parse(value!),
              ),
              const SizedBox(height: 16),

              // --- Switch Trạng Thái Hoạt Động ---
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SwitchListTile(
                  title: const Text('Trạng thái hoạt động tốt'),
                  subtitle: Text(
                      _isOperational ? 'Đang hoạt động' : 'Đang bảo trì/Hỏng'),
                  value: _isOperational,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    setState(() {
                      _isOperational = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),

              // --- Nút Lưu ---
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _saveForm,
                  icon: const Icon(Icons.save),
                  label: const Text('LƯU THIẾT BỊ',
                      style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
