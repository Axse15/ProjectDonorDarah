import 'package:blood_donation/screens/halaman_login_screen.dart'; // Import WelcomeScreen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'dart:io'; // Import untuk File

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ktpNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _jobController = TextEditingController(); // Pekerjaan
  String? _selectedGender; // Jenis kelamin
  String? _selectedBloodGroup; // Menyimpan golongan darah
  DateTime? _selectedDate; // Menyimpan tanggal lahir
  File? _image; // Variabel untuk menyimpan gambar yang dipilih

  final List<String> bloodTypes = [
    'A',
    'A+',
    'A-',
    'B',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O',
  ];

  final List<String> genders = ['Laki-laki', 'Perempuan'];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Simpan gambar yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrasi')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 4, 0), Color.fromARGB(255, 255, 21, 0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol pemilihan gambar
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextFormField(controller: _nameController, label: 'Nama'),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan email Anda';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Silakan masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: _addressController,
                  label: 'Alamat',
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: _ktpNumberController,
                  label: 'Nomor KTP',
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: _passwordController,
                  label: 'Kata Sandi',
                  obscureText: true,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  decoration: InputDecoration(labelText: 'Golongan Darah', labelStyle: TextStyle(color: Colors.white)),
                  items: bloodTypes.map((String bloodType) {
                    return DropdownMenuItem<String>(
                      value: bloodType,
                      child: Text(bloodType),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodGroup = value; // Simpan nilai yang dipilih
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih golongan darah Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(labelText: 'Jenis Kelamin', labelStyle: TextStyle(color: Colors.white)),
                  items: genders.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value; // Simpan nilai yang dipilih
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih jenis kelamin Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  controller: _jobController,
                  label: 'Pekerjaan',
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == null
                        ? 'Pilih Tanggal Lahir'
                        : 'Tanggal Lahir: ${_selectedDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registrasi Berhasil')),
                        );

                        // Menambahkan pengguna baru ke map pengguna
                        WelcomeScreen.users[_emailController.text.toLowerCase()] = {
                          "password": _passwordController.text,
                          "userName": _nameController.text,
                          "userBloodGroup": _selectedBloodGroup,
                          "userGender": _selectedGender,
                          "userJob": _jobController.text,
                          "userBirthDate": _selectedDate,
                          "userAddress": _addressController.text,
                          "userKtpNumber": _ktpNumberController.text,
                          "userImagePath": _image?.path ?? '',
                        };

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(
                              userName: _nameController.text,
                              isRegistered: true,
                              registeredBloodGroup: _selectedBloodGroup,
                              userEmail: _emailController.text,
                              userPassword: _passwordController.text,
                              userGender: _selectedGender,
                              userJob: _jobController.text,
                              userBirthDate: _selectedDate,
                              userAddress: _addressController.text,
                              userKtpNumber: _ktpNumberController.text,
                              userImagePath: _image?.path ?? '', // Pass the image path here
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Silakan perbaiki kesalahan di formulir'),
                          ),
                        );
                      }
                    },
                    child: Text('Daftar', style: TextStyle(fontSize: 18, color: Colors.red)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      minimumSize: Size(180, 50),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}