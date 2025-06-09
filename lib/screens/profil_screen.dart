import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // Import for File
import 'package:blood_donation/screens/halaman_login_screen.dart'; // Import the login screen

class ProfilScreen extends StatelessWidget {
  final String name;
  final String address;
  final String bloodGroup;
  final DateTime birthDate;
  final String job;
  final String gender; // New parameter for gender
  final String ktpNumber;
  final String email;
  final String password;
  final String imagePath; // New parameter for profile image

  const ProfilScreen({
    Key? key,
    required this.name,
    required this.address,
    required this.bloodGroup,
    required this.birthDate,
    required this.job,
    required this.gender, // Accept gender
    required this.ktpNumber,
    required this.email,
    required this.password,
    required this.imagePath, // Accept image path
  }) : super(key: key);

  String get formattedBirthDate {
    return DateFormat('dd MMMM yyyy').format(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = GoogleFonts.poppins(
      color: Colors.grey[600],
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    final textStyleValue = GoogleFonts.poppins(
      color: Colors.grey[800],
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna', style: GoogleFonts.poppins()),
        backgroundColor: Color(0xFFE53935),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              // Profile Image
              Center(
                child: CircleAvatar(
                  radius: 60, // Adjust the size as needed
                  backgroundImage: imagePath.isNotEmpty 
                      ? FileImage(File(imagePath)) // Use FileImage for local images
                      : AssetImage('assets/images/default_profile.png') as ImageProvider, // Default image if no image path
                  onBackgroundImageError: (error, stackTrace) {
                    // Handle error if image fails to load
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Data Pengguna',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 28),
              _buildInfoRow('Nama', name, textStyleLabel, textStyleValue),
              _buildInfoRow('Alamat', address, textStyleLabel, textStyleValue),
              _buildInfoRow(
                'Golongan Darah',
                bloodGroup,
                textStyleLabel,
                textStyleValue,
              ),
              _buildInfoRow(
                'Tanggal Lahir',
                formattedBirthDate,
                textStyleLabel,
                textStyleValue,
              ),
              _buildInfoRow('Pekerjaan', job, textStyleLabel, textStyleValue),
              _buildInfoRow('Jenis Kelamin', gender, textStyleLabel, textStyleValue), // Display gender
              _buildInfoRow(
                'Nomor KTP',
                ktpNumber,
                textStyleLabel,
                textStyleValue,
              ),
              _buildInfoRow('Email', email, textStyleLabel, textStyleValue),
              _buildInfoRow(
                'Password',
                password.replaceAll(RegExp(r'.'), '•'),
                textStyleLabel,
                textStyleValue,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen(userName: '')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE53935), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text('$label:', style: labelStyle)),
          Expanded(flex: 3, child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}