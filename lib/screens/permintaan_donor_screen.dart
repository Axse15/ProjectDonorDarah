import 'package:flutter/material.dart';

class PermintaanDonorScreen extends StatefulWidget {
  const PermintaanDonorScreen({super.key});

  @override
  State<PermintaanDonorScreen> createState() => _PermintaanDonorScreenState();
}

class _PermintaanDonorScreenState extends State<PermintaanDonorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController =
      TextEditingController(); // field alamat
  final TextEditingController _ktpController =
      TextEditingController(); // field nomor KTP

  String? _selectedBloodGroup;
  String? selectedLocation;
  String? _question1Answer;
  String? _question2Answer;
  String? _question3Answer;
  String? _question4Answer;
  String? _question5Answer;

  final List<String> bloodGroups = [
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
  final List<String> locations = [
    'PMI Kota Jakarta Pusat',
    'PMI Kota Jakarta Barat',
    'PMI Kota Jakarta Timur',
    'PMI Kota Jakarta Selatan',
    'PMI Kota Jakarta Utara',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permintaan Donor'),
        backgroundColor: Color(0xFFE53935),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buat Permintaan Donor Darah',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 24),
                      // Nama Pemohon
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Pemohon',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFFE53935),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silakan masukkan nama pemohon';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Alamat
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          prefixIcon: Icon(
                            Icons.home,
                            color: Color(0xFFE53935),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silakan masukkan alamat';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Nomor KTP
                      TextFormField(
                        controller: _ktpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nomor KTP',
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: Color(0xFFE53935),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silakan masukkan nomor KTP';
                          }
                          if (value.length < 5) {
                            return 'Nomor KTP tidak valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Golongan Darah
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Golongan Darah',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(
                            Icons.bloodtype,
                            color: Color(0xFFE53935),
                          ),
                        ),
                        items:
                            bloodGroups.map((golongan) {
                              return DropdownMenuItem<String>(
                                value: golongan,
                                child: Text(golongan),
                              );
                            }).toList(),
                        value: _selectedBloodGroup,
                        onChanged: (value) {
                          setState(() {
                            _selectedBloodGroup = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Silakan pilih golongan darah';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Lokasi
                      DropdownButtonFormField<String>(
                        value: selectedLocation,
                        decoration: InputDecoration(
                          labelText: 'Pilih Lokasi PMI',
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Color(0xFFE53935),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items:
                            locations.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value;
                          });
                        },
                      ),
                      SizedBox(height: 24),

                      Text(
                        'Pertanyaan untuk Pasien Donor Darah',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),

                      _buildQuestion(
                        question:
                            'Apakah Anda pernah mendonorkan darah sebelumnya?',
                        groupValue: _question1Answer,
                        onChanged: (value) {
                          setState(() {
                            _question1Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: 'Apakah Anda dalam keadaan sehat saat ini?',
                        groupValue: _question2Answer,
                        onChanged: (value) {
                          setState(() {
                            _question2Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: 'Apakah Anda sedang mengonsumsi obat-obatan?',
                        groupValue: _question3Answer,
                        onChanged: (value) {
                          setState(() {
                            _question3Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question:
                            'Apakah Anda memiliki riwayat penyakit serius?',
                        groupValue: _question4Answer,
                        onChanged: (value) {
                          setState(() {
                            _question4Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: 'Apakah Anda berusia di atas 17 tahun?',
                        groupValue: _question5Answer,
                        onChanged: (value) {
                          setState(() {
                            _question5Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_question1Answer == null ||
                                _question2Answer == null ||
                                _question3Answer == null ||
                                _question4Answer == null ||
                                _question5Answer == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Silakan jawab semua pertanyaan terlebih dahulu',
                                  ),
                                ),
                              );
                              return;
                            }
                            _showConfirmationDialog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE53935),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Kirim Permintaan Donor',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion({
    required String question,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
    required List<String> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(fontSize: 16, color: Colors.black87)),
        SizedBox(height: 8),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        }).toList(),
        SizedBox(height: 16),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permintaan Donor Dikirim'),
          content: Text('Permintaan donor darah Anda telah berhasil dikirim.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Color(0xFFE53935))),
            ),
          ],
        );
      },
    );
  }
}
