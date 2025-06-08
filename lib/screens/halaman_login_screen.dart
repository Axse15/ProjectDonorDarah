import 'package:blood_donation/screens/home_screen.dart';
import 'package:blood_donation/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String userName; // Menyimpan nama pengguna
  final bool isRegistered; // Menandakan status registrasi
  final String? registeredBloodGroup; // Golongan darah dari registrasi (opsional)

  const WelcomeScreen({
    Key? key,
    required this.userName,
    this.isRegistered = false,
    this.registeredBloodGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFFF8A80)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'Selamat Datang, $userName di Aplikasi DonorYuk!',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Spacer(),
                _buildFormLogin(context),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormLogin(BuildContext context) {
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controllerEmail,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
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
          SizedBox(height: 12),
          TextFormField(
            controller: controllerPassword,
            decoration: InputDecoration(
              labelText: 'Kata Sandi',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Harap masukkan kata sandi Anda';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Logika autentikasi sederhana (dua set email dan kata sandi)
                if ((controllerEmail.text == "fazli@gmail.com" && controllerPassword.text == "0615") ||
                    (controllerEmail.text == "Diez@gmail.com" && controllerPassword.text == "2301") ||
                    (controllerEmail.text == "anggie@gmail.com" && controllerPassword.text == "1234")) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        userName: userName, 
                        userBloodGroup: registeredBloodGroup ?? 'A+', 
                        userGender: 'Laki-laki', 
                        userJob: 'Programmer', 
                        userBirthDate: DateTime(1995, 5, 15),
                        userAddress: 'Alamat Pengguna', 
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
            child: Text('Mulai'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFFE53935),
              minimumSize: Size(180, 50),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Belum punya akun? ',
            style: TextStyle(color: Colors.white.withOpacity(0.9)),
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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}