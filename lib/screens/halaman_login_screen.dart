import 'dart:io'; // menambahkan import untuk penanganan file
import 'package:blood_donation/screens/home_screen.dart';
import 'package:blood_donation/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  final String userName; // Menyimpan nama pengguna dari registrasi
  final bool isRegistered; // Menandakan status registrasi
  final String? registeredBloodGroup; // Golongan darah dari registrasi (opsional)
  final String? userEmail;
  final String? userPassword;
  final String? userGender;
  final String? userJob;
  final DateTime? userBirthDate;
  final String? userAddress;
  final String? userKtpNumber;
  final String? userImagePath; // Parameter baru untuk gambar profil

  // Map statis untuk menyimpan data beberapa pengguna
  static Map<String, Map<String, dynamic>> users = {};

  WelcomeScreen({
    Key? key,
    required this.userName,
    this.isRegistered = false,
    this.registeredBloodGroup,
    this.userEmail,
    this.userPassword,
    this.userGender,
    this.userJob,
    this.userBirthDate,
    this.userAddress,
    this.userKtpNumber,
    this.userImagePath,
  }) : super(key: key) {
    // Jika pengguna baru terdaftar, tambahkan ke map pengguna statis
    if (isRegistered && userEmail != null) {
      users[userEmail!.toLowerCase()] = {
        "password": userPassword ?? '',
        "userName": userName,
        "userBloodGroup": registeredBloodGroup ?? '',
        "userGender": userGender ?? '',
        "userJob": userJob ?? '',
        "userBirthDate": userBirthDate ?? DateTime(2000, 1, 1),
        "userAddress": userAddress ?? '',
        "userKtpNumber": userKtpNumber ?? '',
        "userImagePath": userImagePath ?? '',
      };
    }
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 0, 0),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.40),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: widget.userImagePath != null && widget.userImagePath!.isNotEmpty
                      ? FileImage(File(widget.userImagePath!))
                      : AssetImage('assets/images/default_profile.png') as ImageProvider,
                  onBackgroundImageError: (error, stackTrace) {},
                ),
                SizedBox(height: 20),
                Text(
                  'Selamat Datang,',
                  style: GoogleFonts.poppins(
                    fontSize: 46,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(221, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.userName.isNotEmpty ? widget.userName : '',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Text(
                  'Masuk untuk melanjutkan ke aplikasi DonorYuk',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Color.fromARGB(255, 255, 255, 255),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 36),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap masukkan email Anda';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Harap masukkan email yang valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                        obscureText: true,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap masukkan kata sandi Anda';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String email = controllerEmail.text.toLowerCase();
                              String password = controllerPassword.text;

                              if (WelcomeScreen.users.containsKey(email) &&
                                  WelcomeScreen.users[email]!['password'] == password) {
                                final userData = WelcomeScreen.users[email]!;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      userName: userData['userName'] ?? 'Pengguna',
                                      userBloodGroup:
                                          userData['userBloodGroup'] ?? 'A+',
                                      userGender: userData['userGender'] ?? '',
                                      userJob: userData['userJob'] ?? '',
                                      userBirthDate: userData['userBirthDate'] ??
                                          DateTime(2000, 1, 1),
                                      userAddress: userData['userAddress'] ?? '',
                                      userKtpNumber: userData['userKtpNumber'] ?? '',
                                      userEmail: email,
                                      userPassword: password,
                                      userImagePath: userData['userImagePath'] ?? '',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Email atau kata sandi salah!')),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Masuk',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 255, 1, 1),
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Belum punya akun?',
                        style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationScreen()),
                          );
                        },
                        child: Text(
                          'Registrasi',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}