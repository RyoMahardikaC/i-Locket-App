import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/riwayat_controller.dart'; // Import controller yang baru dibuat
import '../../routes/app_routes.dart';

class RiwayatKunjunganScreen extends StatelessWidget {
  const RiwayatKunjunganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil Controller
    final RiwayatController controller = Get.put(RiwayatController());

    // --- CONFIG WARNA (SESUAI GAMBAR) ---
    const Color headerBlue = Color(0xFF3F51B5); // Biru Header
    const Color bgLavender = Color(0xFFE5E9F8); // Background Lavender
    const Color iconYellow = Color(0xFFF2C94C); // Kuning Icon
    const Color textDark = Color(0xFF2D3436); // Hitam Teks

    return Scaffold(
      backgroundColor: bgLavender, // Background seluruh layar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(), // Kembali ke halaman sebelumnya
        ),
        title: const Text(
          "Riwayat Kunjungan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. HEADER BIRU (Background Atas)
          Container(
            height: 180, // Tinggi header biru
            width: double.infinity,
            decoration: const BoxDecoration(
              color: headerBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // 2. LIST KARTU RIWAYAT
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 0), // Jarak dari atas
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                final item = controller.historyList[index];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // BAGIAN ATAS KARTU (Icon & Judul)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // Icon Bulat Kuning
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: iconYellow, // Kuning
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.medical_services_outlined, // Icon tas obat
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Teks Judul & Waktu
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['poli']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: textDark,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['time']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // BAGIAN BAWAH KARTU (Nama Dokter - Background Abu)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5), // Abu-abu muda sekali
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['doctor']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['specialist']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}