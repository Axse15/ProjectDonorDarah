import 'package:flutter/material.dart';

// Expose PMI location list publicly to be used by other screens
class PmiLocationData {
  static final List<Map<String, String>> lokasiPmi = [
    {
      'nama': 'PMI Klender Jakarta Timur',
      'alamat': 'Jl. Klender No.123, Jakarta Timur',
      'assetGambar': 'assets/images/pmi-jakarta-timur.jpg',
    },
    {
      'nama': 'PMI Tarakan Jakarta Pusat',
      'alamat': 'Jl. Tarakan No.45, Jakarta Pusat',
      'assetGambar': 'assets/images/pmi-jakarta-pusat.jpg',
    },
    {
      'nama': 'PMI Plumpang Jakarta Utara',
      'alamat': 'Jl. Plumpang No.67, Jakarta Utara',
      'assetGambar': 'assets/images/pmi-jakarta-utara.jpg',
    },
    {
      'nama': 'PMI Grogol Jakarta Barat',
      'alamat': 'Jl. Grogol No.12, Jakarta Barat',
      'assetGambar': 'assets/images/pmi-jakarta-barat.jpeg',
    },
    {
      'nama': 'PMI Condet Jakarta Selatan',
      'alamat': 'Jl. Condet No.88, Jakarta Selatan',
      'assetGambar': 'assets/images/pmi-jakarta-selatan.jpg',
    },
  ];
}

class LokasiPmiScreen extends StatelessWidget {
  LokasiPmiScreen({Key? key}) : super(key: key);

  // Helper method to get image from lokasiPmi list by name
  String getImagePathByName(String name) {
    final location = PmiLocationData.lokasiPmi.firstWhere(
      (loc) => loc['nama'] == name,
      orElse: () => {},
    );
    if (location.isNotEmpty && location['assetGambar'] != null) {
      return location['assetGambar']!;
    }
    return 'assets/images/pmi_default.jpg'; // fallback default image
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi PMI di Jakarta'),
        backgroundColor: const Color(0xFFE53935),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: PmiLocationData.lokasiPmi.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final lokasi = PmiLocationData.lokasiPmi[index];
            return GestureDetector(
              onTap: () {
                _showDetailLokasi(context, lokasi);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.redAccent.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        lokasi['assetGambar']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            color: Colors.grey[300],
                            child: const Center(
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
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        lokasi['nama']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE53935),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDetailLokasi(BuildContext context, Map<String, String> lokasi) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            lokasi['nama']!,
            style: const TextStyle(
              color: Color(0xFFE53935),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                lokasi['assetGambar']!,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(lokasi['alamat']!, style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Tutup',
                style: TextStyle(color: Color(0xFFE53935)),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
