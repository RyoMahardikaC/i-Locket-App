import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
// import '../../controllers/profile_controller.dart'; // Aktifkan jika mau simpan ke database nanti

// ==========================================
// 1. EDIT NAMA SCREEN
// ==========================================
class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data nama saat ini
    final HomeController homeController = Get.find<HomeController>();
    final TextEditingController nameC = TextEditingController(text: homeController.userName.value);

    return _buildEditScaffold(
      title: "Edit atau ganti nama", // Sesuai gambar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Edit Nama*"),
          _buildTextField(controller: nameC, hint: "Edit Nama"),
          const SizedBox(height: 24),
          _buildInfoBox("Ganti nama yang baru"),
        ],
      ),
      onSave: () {
        // Logic Simpan
        homeController.userName.value = nameC.text;
        Get.back();
        Get.snackbar("Sukses", "Nama berhasil diperbarui", 
          backgroundColor: Colors.green, colorText: Colors.white);
      },
    );
  }
}

// ==========================================
// 2. EDIT EMAIL SCREEN
// ==========================================
class EditEmailScreen extends StatelessWidget {
  const EditEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildEditScaffold(
      title: "Edit atau buat Email baru", // Sesuai gambar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Email*"),
          _buildTextField(hint: "Placeholder", icon: Icons.email_outlined),
          const SizedBox(height: 24),
          _buildInfoBox("Ganti email yang baru"),
        ],
      ),
      onSave: () {
        Get.back();
        Get.snackbar("Sukses", "Email berhasil disimpan");
      },
    );
  }
}

// ==========================================
// 3. EDIT PASSWORD SCREEN
// ==========================================
class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildEditScaffold(
      title: "Edit Password", // Sesuai gambar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Password*"),
          _buildTextField(hint: "Password", isPassword: true, icon: Icons.lock_outline),
          const SizedBox(height: 24),
          _buildLabel("Password*"),
          _buildTextField(hint: "New Password", isPassword: true, icon: Icons.lock_outline),
          const SizedBox(height: 24),
          _buildInfoBox("Ganti password yang baru"),
        ],
      ),
      onSave: () {
        Get.back();
        Get.snackbar("Sukses", "Password berhasil diubah");
      },
    );
  }
}

// ==========================================
// 4. EDIT NOTIFIKASI SCREEN
// ==========================================
class EditNotificationScreen extends StatelessWidget {
  const EditNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variabel state lokal untuk checkbox
    var notifEmail = true.obs;
    var antrianMendekati = false.obs;
    var checkInBerhasil = false.obs;

    return _buildEditScaffold(
      title: "Edit Notifikasi", // Sesuai gambar
      body: Obx(() => Column(
        children: [
          _buildCheckboxItem("Notifikasi Email", notifEmail),
          _buildCheckboxItem("Antrian mendekati", antrianMendekati),
          _buildCheckboxItem("Check-in berhasil", checkInBerhasil),
          const SizedBox(height: 24),
          _buildInfoBox("Setting notifikasi"),
        ],
      )),
      onSave: () {
        Get.back();
        Get.snackbar("Sukses", "Pengaturan notifikasi disimpan");
      },
    );
  }

  Widget _buildCheckboxItem(String title, RxBool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
          ),
          // Checkbox Custom agar kotak sesuai desain
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: value.value,
              activeColor: const Color(0xFF3F51B5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: Colors.grey, width: 1.5),
              onChanged: (val) => value.value = val!,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET HELPERS (Agar Desain Konsisten & Rapi)
// ==========================================

// 1. Scaffold Template (AppBar + Tombol Save di Bawah)
Widget _buildEditScaffold({
  required String title,
  required Widget body,
  required VoidCallback onSave,
}) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Poppins',
        ),
      ),
      centerTitle: false, // Judul rata kiri sesuai gambar android default/wireframe
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          // Konten Utama (Scrollable)
          Expanded(child: SingleChildScrollView(child: body)),
          
          // Tombol Save (Sticky di Bawah)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F51B5), // Warna Biru Utama
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              onPressed: onSave,
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10), // Margin bawah aman
        ],
      ),
    ),
  );
}

// 2. Label Text (Judul Input)
Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black87,
        fontFamily: 'Poppins',
      ),
    ),
  );
}

// 3. Text Field Custom
Widget _buildTextField({
  String? hint,
  IconData? icon,
  bool isPassword = false,
  TextEditingController? controller,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Poppins'),
      prefixIcon: icon != null 
          ? Icon(icon, color: const Color(0xFF3F51B5), size: 22) 
          : null,
      suffixIcon: isPassword 
          ? const Icon(Icons.visibility_off_outlined, color: Colors.black54) 
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      // Border Default
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      // Border saat diklik
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3F51B5)),
      ),
    ),
  );
}

// 4. Info Box (Kotak Ungu Muda)
Widget _buildInfoBox(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6), // Ungu muda pudar sesuai gambar
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF3F51B5).withOpacity(0.5)),
    ),
    child: Row(
      children: [
        const Icon(Icons.info_outline, color: Color(0xFF3F51B5), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    ),
  );
}