import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color textDark = Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER (Background Biru Lengkung)
            Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.grey, size: 40),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Teks Sapaan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi Johan!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Semoga sehat selalu",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. MENU UTAMA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildMenuCard(
                    title: "Daftar Antrian Baru",
                    subtitle: "Buat antrian klinik",
                    iconData: Icons.calendar_today,
                    onTap: () => Get.toNamed(AppRoutes.daftar_antrian),
                  ),
                  _buildMenuCard(
                    title: "Cek Status Antrian",
                    subtitle: "Lihat nomor & estimasi waktu",
                    iconData: Icons.layers,
                    onTap: () => Get.toNamed(AppRoutes.status_antrian),
                  ),
                  _buildMenuCard(
                    title: "Riwayat Kunjungan",
                    subtitle: "Lihat riwayat antrian",
                    iconData: Icons.history_edu, 
                    onTap: () => Get.snackbar("Info", "Fitur Riwayat belum tersedia"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. SECTION BERITA (Updated: Menggunakan Gambar Asset)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Berita",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // --- GAMBAR BANNER ---
                  Container(
                    width: double.infinity,
                    // Tidak perlu set height fix, biar menyesuaikan aspek rasio gambar
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/banner_news.png', // Pastikan file "Promotion Card.png" di-rename jadi ini
                        fit: BoxFit.cover, 
                        // width: double.infinity, // Opsional: paksa lebar penuh
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // 4. BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
          onTap: (index) {},
        ),
      ),
    );
  }

  // Widget Helper Menu Card
  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    const Color primaryBlue = Color(0xFF3F51B5);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}