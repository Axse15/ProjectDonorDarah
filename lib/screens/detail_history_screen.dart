import 'package:blood_donation/screens/pmi_location_screen.dart';
import 'package:flutter/material.dart';

class DetailHistoryScreen extends StatelessWidget {
  final Map<String, dynamic> historyEntry;

  const DetailHistoryScreen({Key? key, required this.historyEntry}) : super(key: key);

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2,'0')}-${date.month.toString().padLeft(2,'0')}-${date.year}";
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
    final imagePath = _getImagePathByLocation(historyEntry['location'] as String);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Riwayat Donor'),
        backgroundColor: Color(0xFFE53935),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          shadowColor: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 240,
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      historyEntry['name'],
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildInfoRow(Icons.bloodtype, 'Golongan Darah', historyEntry['bloodGroup']),
                    _buildInfoRow(Icons.home, 'Alamat', historyEntry['address']),
                    _buildInfoRow(Icons.location_on, 'Lokasi PMI', historyEntry['location']),
                    _buildInfoRow(Icons.credit_card, 'Nomor KTP', historyEntry['ktpNumber']),
                    _buildInfoRow(Icons.calendar_today, 'Tanggal Terakhir Donor', _formatDate(historyEntry['lastDonationDate'])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFFE53935), size: 28),
          SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label: ',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.3,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      fontSize: 18,
                      letterSpacing: 0.15,
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