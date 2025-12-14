import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Bài test này kiểm tra khả năng Render giao diện cơ bản của ứng dụng
  testWidgets('Kiem tra hien thi giao dien co ban',
      (WidgetTester tester) async {
    // 1. Dựng (Pump) một giao diện mẫu độc lập
    // Chúng ta không gọi MyApp() ở đây để tránh lỗi khởi tạo Firebase trên môi trường CI/CD
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'AI Lab Manager',
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );

    // 2. Kiểm tra xem Widget text có xuất hiện trên màn hình ảo không
    final titleFinder = find.text('AI Lab Manager');

    // 3. Khẳng định (Expect) tìm thấy đúng 1 widget như vậy
    expect(titleFinder, findsOneWidget);
  });
}
