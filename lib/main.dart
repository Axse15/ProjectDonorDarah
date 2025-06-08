import 'package:blood_donation/screens/halaman_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFE53935),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFE53935),
          secondary: Color(0xFFFF8A80),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: WelcomeScreen(userName:''), // Ganti 'Pengguna' dengan nama default atau kosong
    );
  }
}