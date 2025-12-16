import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:i_locket/views/queue/booking.dart';

class DaftarAntrian extends StatefulWidget {
  const DaftarAntrian({super.key});

  @override
  State<StatefulWidget> createState() => _DaftarAntrian();
}

class _DaftarAntrian extends State<DaftarAntrian> {
  final TextEditingController _searchController = TextEditingController();

  // Data poli list
  final List<Map<String, dynamic>> _poliList = [
    {
      'id': 1,
      'name': 'Poli THT',
      'description': 'Layanan spesialis telinga, hidung, dan tenggorokan',
      'emoji': '👃',
      'color': const Color(0xfff9f5ff),
    },
    {
      'id': 2,
      'name': 'Poli Jiwa',
      'description': 'Layanan kesehatan mental dan konsultasi psikologis',
      'emoji': '🧠',
      'color': const Color(0xfff9f5ff),
    },
    {
      'id': 3,
      'name': 'Poli Gigi',
      'description': 'Layanan gigi dan mulut',
      'emoji': '🦷',
      'color': const Color(0xfff9f5ff),
    },
    {
      'id': 4,
      'name': 'Poli Kulit',
      'description': 'Layanan pemeriksaan dan perawatan masalah kulit',
      'emoji': '🤌',
      'color': const Color(0xfff9f5ff),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ✅ FIXED: Navigate using Get.to and passing arguments
  void _navigateToBooking(Map<String, dynamic> poli) {
    Get.to(
      () => const QueueBookingScreen(), // No parameters here
      arguments: {
        'poliName': poli['name'],
        'poliDescription': poli['description'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff3d4eb0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(), // Use Get.back()
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Daftar Antrian Baru',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32), // Spacer for centering
                  ],
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pilih Poli',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 24,
                              color: Color(0xff18181b),
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Buat antrian poli baru',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: Color(0xff3f3f46),
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Search Bar
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffcdd1f5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Poli mata....',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff71717a),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff71717a),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Poli List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _poliList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final poli = _poliList[index];
                        return _buildPoliCard(poli);
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Indicator (optional)
            Container(
              height: 21,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk card poli dengan navigasi
  Widget _buildPoliCard(Map<String, dynamic> poli) {
    return InkWell(
      onTap: () => _navigateToBooking(poli), // Navigate ke booking
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffe5e7eb), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Emoji Icon
              Container(
                decoration: BoxDecoration(
                  color: poli['color'],
                  border:
                      Border.all(color: const Color(0xffc6d4f1), width: 1),
                  borderRadius: BorderRadius.circular(99),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  poli['emoji'],
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 12),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      poli['name'],
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        color: Color(0xff18181b),
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      poli['description'],
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 12,
                        color: Color(0xff71717a),
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Arrow Icon
              const Icon(
                Icons.chevron_right,
                color: Color(0xff71717a),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}