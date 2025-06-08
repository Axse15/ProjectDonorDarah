import 'package:blood_donation/screens/detail_history_screen.dart';
import 'package:blood_donation/screens/pmi_location_screen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Sample history data
  final List<Map<String, dynamic>> historyData = [
    {
      'name': 'Muhammad Fazli Adrianto',
      'bloodGroup': 'A',
      'address': 'Jl. Kebon Kelapa No.6, Jakarta Timur',
      'location': 'PMI Klender Jakarta Timur',
      'ktpNumber': '3174012309870001',
      'lastDonationDate': DateTime(2025, 04, 15),
    },
    {
      'name': 'Adiesty Widya Farahdina',
      'bloodGroup': 'B',
      'address': 'Jl. Pisangan Baru No.13, Jakarta Timur',
      'location': 'PMI Condet Jakarta Selatan',
      'ktpNumber': '3175021408760002',
      'lastDonationDate': DateTime(2025, 2, 28),
    },
    {
      'name': 'Anggie Permana',
      'bloodGroup': 'AB+',
      'address': 'Jl. Kartini No. 12, Jakarta',
      'location': 'PMI Plumpang Jakarta Utara',
      'ktpNumber': '3176011509650003',
      'lastDonationDate': DateTime(2025, 5, 8),
    },
    {
      'name': 'Trisna Kurniawan',
      'bloodGroup': 'O',
      'address': 'Jl. Pahlawan No. 12, Jakarta',
      'location': 'PMI Grogol Jakarta Barat',
      'ktpNumber': '3176111509650001',
      'lastDonationDate': DateTime(2025, 5, 1),
    },
    {
      'name': 'Destria Rahman',
      'bloodGroup': 'B+',
      'address': 'Jl. Pegangsaan Timur No. 12, Jakarta',
      'location': 'PMI Tarakan Jakarta Pusat',
      'ktpNumber': '3176112509650005',
      'lastDonationDate': DateTime(2025, 1, 8),
    },
  ];

  // List of blood groups for filter dropdown
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

  String? selectedBloodGroup;

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  String _getImagePathByLocation(String locationName) {
    final location = PmiLocationData.lokasiPmi.firstWhere(
      (loc) => loc['nama'] == locationName,
      orElse: () => {},
    );
    if (location.isNotEmpty && location['assetGambar'] != null) {
      return location['assetGambar']!;
    }
    return 'assets/images/pmi_default.jpg'; // fallback default image
  }

  @override
  Widget build(BuildContext context) {
    // Filter history data based on selected blood group
    final filteredHistoryData = selectedBloodGroup == null
        ? historyData
        : historyData.where((history) => history['bloodGroup'] == selectedBloodGroup).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Donor', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFE53935),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Dropdown for selecting blood group filter
            DropdownButtonFormField<String>(
              value: selectedBloodGroup,
              decoration: InputDecoration(
                labelText: 'Filter Golongan Darah',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.bloodtype, color: Color(0xFFE53935)),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Semua Golongan Darah'),
                ),
                ...bloodGroups.map((bg) => DropdownMenuItem<String>(
                      value: bg,
                      child: Text(bg),
                    )),
              ],
              onChanged: (value) {
                setState(() {
                  selectedBloodGroup = value;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredHistoryData.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data untuk golongan darah ini.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredHistoryData.length,
                      itemBuilder: (context, index) {
                        final history = filteredHistoryData[index];
                        final imagePath = _getImagePathByLocation(
                          history['location'] as String,
                        );

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailHistoryScreen(historyEntry: history),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(bottom: 24),
                            shadowColor: Colors.black12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    imagePath,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 180,
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        history['name'],
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                      _buildInfoRow(
                                        Icons.bloodtype,
                                        'Golongan Darah',
                                        history['bloodGroup'],
                                      ),
                                      _buildInfoRow(
                                        Icons.home,
                                        'Alamat',
                                        history['address'],
                                      ),
                                      _buildInfoRow(
                                        Icons.location_on,
                                        'Lokasi PMI',
                                        history['location'],
                                      ),
                                      _buildInfoRow(
                                        Icons.credit_card,
                                        'No. KTP',
                                        history['ktpNumber'],
                                      ),
                                      _buildInfoRow(
                                        Icons.calendar_today,
                                        'Tanggal Terakhir Donor',
                                        _formatDate(history['lastDonationDate']),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFFE53935), size: 22),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label: ',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.25,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      fontSize: 16,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}