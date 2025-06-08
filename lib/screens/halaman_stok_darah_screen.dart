import 'package:flutter/material.dart';

class FindDonorsScreen extends StatefulWidget {
  const FindDonorsScreen({super.key});

  @override
  State<FindDonorsScreen> createState() => _FindDonorsScreenState();
}

class _FindDonorsScreenState extends State<FindDonorsScreen> {
  String? selectedBloodGroup;
  String? selectedLocation;

  final List<Map<String, dynamic>> donors = [
    {
      'name': 'Stok Darah',
      'bloodGroup': 'A',
      'location': 'PMI Kota Jakarta Barat',
      'availability': true,
      'lastDonated': '15 kantong darah',
      'contact': '123-456-789',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'B',
      'location': 'PMI Kota Jakarta Pusat',
      'availability': false,
      'lastDonated': 'Stok kosong',
      'contact': '987-654-321',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'A',
      'location': 'PMI Kota Jakarta Timur',
      'availability': true,
      'lastDonated': '3 kantong darah',
      'contact': '987-654-321',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'AB+',
      'location': 'PMI Kota Jakarta Selatan',
      'availability': true,
      'lastDonated': '1 kantong darah',
      'contact': '123-456-789',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'A-',
      'location': 'PMI Kota Jakarta Utara',
      'availability': false,
      'lastDonated': 'Stok kosong',
      'contact': '987-654-321',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'B-',
      'location': 'PMI Kota Jakarta Utara',
      'availability': true,
      'lastDonated': '7 kantong darah',
      'contact': '123-456-789',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'O',
      'location': 'PMI Kota Jakarta Pusat',
      'availability': true,
      'lastDonated': '5 kantong darah',
      'contact': '987-654-321',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'AB-',
      'location': 'PMI Kota Jakarta Barat',
      'availability': false,
      'lastDonated': 'Stok kosong',
      'contact': '123-456-789',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'A+',
      'location': 'PMI Kota Jakarta Utara',
      'availability': true,
      'lastDonated': '2 kantong darah',
      'contact': '987-654-321',
    },
    {
      'name': 'Stok Darah',
      'bloodGroup': 'B+',
      'location': 'PMI Kota Jakarta Timur',
      'availability': true,
      'lastDonated': '1 kantong drah',
      'contact': '123-456-789',
    },
  ];

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

  final List<String> locations = [
    'PMI Kota Jakarta Pusat',
    'PMI Kota Jakarta Barat',
    'PMI Kota Jakarta Timur',
    'PMI Kota Jakarta Selatan',
    'PMI Kota Jakarta Utara',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDonors = donors.where((donor) {
      final matchesBloodGroup =
          selectedBloodGroup == null || donor['bloodGroup'] == selectedBloodGroup;
      final matchesLocation =
          selectedLocation == null || donor['location'] == selectedLocation;
      return matchesBloodGroup && matchesLocation;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
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
                    colors: [Color(0xFFE53935), Color(0xFFFF8A80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Stok Darah',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Temukan Tempat Stok Darah di PMI Terdekat',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Golongan Darah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: bloodTypes.map((bloodType) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              checkmarkColor: selectedBloodGroup == bloodType
                                  ? Colors.white
                                  : Colors.black,
                              label: Text(bloodType),
                              selected: selectedBloodGroup == bloodType,
                              onSelected: (selected) {
                                setState(() {
                                  selectedBloodGroup = selected ? bloodType : null;
                                });
                              },
                              selectedColor: Color(0xFFE53935),
                              labelStyle: TextStyle(
                                color: selectedBloodGroup == bloodType
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16),
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
                      items: locations.map((location) {
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
                    filteredDonors.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Stok Darah Habis',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Coba sesuaikan filter Anda',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredDonors.length,
                            itemBuilder: (context, index) {
                              final donor = filteredDonors[index];
                              return _buildDonorCard(donor);
                            },
                          ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorCard(Map<String, dynamic> donor) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  donor['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: donor['availability'] ? Color(0xFFE53935) : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    donor['availability'] ? 'Tersedia' : 'Stok Habis',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.bloodtype,
                  text: donor['bloodGroup'],
                ),
                SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.location_on,
                  text: donor['location'],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Tersedia: ${donor['lastDonated']}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: donor['availability']
                        ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Contact PMI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contact Number : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        donor['contact'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFE53935),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Apakah Anda Ingin Menghubungi PMI?',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Tekan Panggil untuk melanjutkan',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE53935),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Panggil',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    child: Text('Contact PMI'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE53935),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFE53935)),
          SizedBox(width: 4),
          Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}