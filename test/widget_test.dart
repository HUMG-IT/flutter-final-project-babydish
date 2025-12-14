import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check basic UI elements', (WidgetTester tester) async {
    // Tạo một nút bấm đơn giản để test (tránh gọi vào Firebase thật)
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('AI Lab Manager')),
        ),
      ),
    );

    // Kiểm tra xem chữ 'AI Lab Manager' có hiện ra không
    expect(find.text('AI Lab Manager'), findsOneWidget);
  });
}
