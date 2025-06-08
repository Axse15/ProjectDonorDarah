import 'package:flutter/material.dart';

class DonationRequestScreen extends StatefulWidget {
  final String userName; // Menyimpan nama pengguna
  final String userBloodGroup; // Menyimpan golongan darah

  const DonationRequestScreen({
    Key? key,
    required this.userName,
    required this.userBloodGroup,
  }) : super(key: key);

  @override
  State<DonationRequestScreen> createState() => _DonationRequestScreenState();
}

class _DonationRequestScreenState extends State<DonationRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  // Menyimpan jawaban untuk setiap pertanyaan
  String? selectedLocation;
  String? _question1Answer;
  String? _question2Answer;
  String? _question3Answer;
  String? _question4Answer;
  String? _question5Answer;

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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: false,
            pinned: true,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFE53935)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Donor Sekarang!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bantu Seseorang yang Membutuhkan!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                        "Detail Pendonor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Tampilkan biodata pengguna dalam TextFormField
                      _buildTextFormField(
                        controller: TextEditingController(
                          text: widget.userName,
                        ),
                        label: "Nama",
                        icon: Icons.person,
                        enabled: false, // Nonaktifkan untuk edit
                      ),
                      SizedBox(height: 8),
                      _buildTextFormField(
                        controller: TextEditingController(
                          text: widget.userBloodGroup,
                        ),
                        label: "Golongan Darah",
                        icon: Icons.bloodtype,
                        enabled: false, // Nonaktifkan untuk edit
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
                      SizedBox(height: 16),
                      Text(
                        "Pertanyaan untuk Pendonor Darah",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildQuestion(
                        question:
                            "Apakah Anda pernah mendonorkan darah sebelumnya?",
                        groupValue: _question1Answer,
                        onChanged: (value) {
                          setState(() {
                            _question1Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: "Apakah Anda dalam keadaan sehat saat ini?",
                        groupValue: _question2Answer,
                        onChanged: (value) {
                          setState(() {
                            _question2Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: "Apakah Anda sedang mengonsumsi obat-obatan?",
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
                            "Apakah Anda memiliki riwayat penyakit serius?",
                        groupValue: _question4Answer,
                        onChanged: (value) {
                          setState(() {
                            _question4Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                      _buildQuestion(
                        question: "Apakah Anda berusia di atas 17 tahun?",
                        groupValue: _question5Answer,
                        onChanged: (value) {
                          setState(() {
                            _question5Answer = value;
                          });
                        },
                        options: ['Ya', 'Tidak'],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Tampilkan dialog pop-up setelah submit
              _showConfirmationDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: Color(0xFFE53935),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            "Kirim Donasimu!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permintaan Donasi Dikirim'),
          content: Text('Permintaan donasi Anda telah berhasil dikirim.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    IconData? suffixIcon,
    int maxLines = 1,
    String? Function(String?)? validator,
    bool enabled =
        true, // Menambahkan parameter untuk mengatur apakah field dapat diedit
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      enabled: enabled, // Mengatur apakah field dapat diedit
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon:
            suffixIcon != null
                ? IconButton(
                  icon: Icon(suffixIcon, color: Theme.of(context).primaryColor),
                  onPressed: () {},
                )
                : null,
      ),
      validator: validator,
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
}
