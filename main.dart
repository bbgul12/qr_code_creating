import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Убедись, что путь к экрану совпадает со структурой твоих папок

void main() {
  runApp(const QrGeneratorApp());
}

class QrGeneratorApp extends StatefulWidget {
  const QrGeneratorApp({super.key});

  @override
  State<QrGeneratorApp> createState() => _QrGeneratorAppState();
}

class _QrGeneratorAppState extends State<QrGeneratorApp> {
  
  ThemeMode _themeMode = ThemeMode.system;

  
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      debugShowCheckedModeBanner: false,
      
      
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      
      
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      
      
      themeMode: _themeMode,
      
      home: HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}