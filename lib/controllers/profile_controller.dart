import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_routes.dart';

class ProfileController extends GetxController {
  final supabase = Supabase.instance.client;
  
  // Variable Data User (Reaktif)
  var name = ''.obs;
  var email = ''.obs;
  var isLoading = false.obs;

  // Variable Setting Notifikasi
  var notifEmail = true.obs;
  var notifAntrian = false.obs;
  var notifCheckIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // 1. AMBIL DATA DARI DATABASE (SUPABASE AUTH)
  void fetchUserData() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      // Ambil nama dari Metadata
      name.value = user.userMetadata?['full_name'] ?? user.userMetadata?['nama'] ?? 'User';
    }
  }

  // 2. UPDATE NAMA
  Future<void> updateName(String newName) async {
    try {
      isLoading.value = true;
      // Update ke Supabase
      await supabase.auth.updateUser(
        UserAttributes(data: {'full_name': newName}),
      );
      // Update lokal biar UI langsung berubah
      name.value = newName;
      Get.back(); // Tutup halaman edit
      Get.snackbar("Sukses", "Nama berhasil diubah", backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal update nama: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // 3. UPDATE EMAIL
  Future<void> updateEmail(String newEmail) async {
    try {
      isLoading.value = true;
      await supabase.auth.updateUser(UserAttributes(email: newEmail));
      email.value = newEmail;
      Get.back();
      Get.snackbar("Cek Email", "Konfirmasi perubahan dikirim ke email baru Anda.", backgroundColor: Colors.blue, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal update email: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // 4. UPDATE PASSWORD
  Future<void> updatePassword(String newPassword) async {
    try {
      isLoading.value = true;
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      Get.back();
      Get.snackbar("Sukses", "Password berhasil diubah", backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal ganti password: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // 5. LOGOUT
  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.login); // Pastikan rute login benar
  }
}