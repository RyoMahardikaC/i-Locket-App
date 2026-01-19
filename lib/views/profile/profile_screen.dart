import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import 'edit_profile_pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ProfileController
    final ProfileController controller = Get.put(ProfileController());
    
    // Warna UI sesuai wireframe
    const Color primaryBlue = Color(0xFF3F51B5); 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
          controller.name.value, // Nama Dinamis dari Database
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        )),
        actions: [
          // Tombol Edit di pojok kanan atas (Pencil Icon)
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () => Get.to(() => const EditNameScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // FOTO PROFIL (Static Asset sesuai gambar)
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_pic.png'), // Ganti dengan aset lokalmu
              // Jika belum ada gambar, bisa pakai ini sementara:
              // backgroundColor: Colors.grey.shade200,
              // child: Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // --- MENU LIST ---
            
            // 1. Email
            _buildProfileItem(
              icon: Icons.email_outlined,
              title: "Email",
              subtitle: "Update dan ubah Email",
              onTap: () => Get.to(() => const EditEmailScreen()),
            ),

            // 2. Password
            _buildProfileItem(
              icon: Icons.lock_outline,
              title: "Password",
              subtitle: "Update dan ubah Password",
              onTap: () => Get.to(() => const EditPasswordScreen()),
            ),

            // 3. Keamanan (Placeholder - karena Supabase Auth standar pakai Password)
            _buildProfileItem(
              icon: Icons.shield_outlined,
              title: "Keamanan",
              subtitle: "Update dan Ubah PIN",
              onTap: () => Get.snackbar("Info", "Fitur PIN akan segera hadir"),
            ),

            // 4. Notifikasi
            _buildProfileItem(
              icon: Icons.notifications_none,
              title: "Notifikasi",
              subtitle: "Update dan Ubah Notifikasi",
              onTap: () => Get.to(() => const EditNotificationScreen()),
            ),
            
            const SizedBox(height: 20),
            
            // 5. Logout
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.logout, color: primaryBlue),
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Panggil fungsi logout dari controller
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Item Menu agar rapi
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    const Color primaryBlue = Color(0xFF3F51B5);

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            // Jika ingin background icon abu-abu seperti desain lain, uncomment ini:
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
            child: Icon(icon, color: primaryBlue),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Poppins'),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Poppins'),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}