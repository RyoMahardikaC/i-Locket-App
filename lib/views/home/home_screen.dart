import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import '../schedule/jadwal_dokter.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Inisialisasi Controller UTAMA (HomeController tempat data nama berada)
    final HomeController homeController = Get.put(HomeController());

    // HAPUS Baris di bawah ini karena UserController menyebabkan error "Type not found"
    // Get.put(UserController());

    const Color primaryBlue = Color(0xFF3F51B5);

    return Scaffold(
      backgroundColor: Colors.white,

      // --- LOGIKA GANTI HALAMAN (BODY) ---
      body: Obx(() {
        switch (homeController.tabIndex.value) {
          case 0:
            // Kita kirim 'homeController' ke fungsi konten
            return _buildHomeContent(homeController);
          case 1:
            return const JadwalDokterScreen();
          case 2:
            return const Center(child: Text("Halaman Notifikasi"));
          case 3:
            return const ProfileScreen();
          default:
            return _buildHomeContent(homeController);
        }
      }),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            showUnselectedLabels: true,
            currentIndex: homeController.tabIndex.value,
            onTap: homeController.changeTabIndex,
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
          ),
        ),
      ),
    );
  }

  // --- KONTEN BERANDA ---
  // PERBAIKAN PENTING DI SINI:
  // Ubah parameter dari 'UserController' menjadi 'HomeController'
  Widget _buildHomeContent(HomeController controller) {
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color textDark = Color(0xFF1F2937);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HEADER
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 40,
            ),
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
                ),
              ],
            ),
            child: Row(
              children: [
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BAGIAN INI AKAN OTOMATIS BERUBAH SESUAI DATA DI CONTROLLER
                    Obx(
                      () => Text(
                        "Hi ${controller.userName.value}!",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Semoga sehat selalu",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
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
                  onTap: () {
                    Get.toNamed(AppRoutes.daftar_antrian);
                  },
                ),
                _buildMenuCard(
                  title: "Cek Status Antrian",
                  subtitle: "Lihat nomor & estimasi waktu",
                  iconData: Icons.layers,
                  onTap: () {
                    Get.toNamed(AppRoutes.status_antrian);
                  },
                ),
                _buildMenuCard(
                  title: "Riwayat Kunjungan",
                  subtitle: "Lihat riwayat antrian",
                  iconData: Icons.history_edu,
                  onTap: () {
                    Get.toNamed(AppRoutes.riwayat);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 3. SECTION BERITA
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
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
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
                      'assets/banner_news.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            "Gambar tidak ditemukan",
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // WIDGET HELPER MENU CARD
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
