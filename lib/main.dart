import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/device_provider.dart';
import 'screens/home_screen.dart';
import 'package:flutter/foundation.dart'; // Thư viện để kiểm tra Web/Mobile

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // KIỂM TRA: Nếu là Web thì dùng cấu hình này
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCWJQB432BsUTRWe4bs5dnaWzwQkkY3f2k",
        authDomain: "ai-lab-manager.firebaseapp.com",
        projectId: "ai-lab-manager",
        storageBucket: "ai-lab-manager.firebasestorage.app",
        messagingSenderId: "559186569560",
        appId: "1:559186569560:web:434e36adcf5edf8aa35d2d",
        measurementId: "G-JNVMR9X22Z",
      ),
    );
  } else {
    // Nếu là Android (Mobile) thì tự đọc từ file google-services.json
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Lab Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
