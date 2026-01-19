import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Wajib import ini

class HomeController extends GetxController {
  // --- VARIABLE TAB (LAMA) ---
  var tabIndex = 0.obs;

  // --- VARIABLE DATA USER (BARU) ---
  var userName = 'Guest'.obs; 
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi ambil nama saat aplikasi baru dibuka
    fetchUserProfile();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // --- FUNGSI AMBIL NAMA DARI SUPABASE ---
  void fetchUserProfile() {
    try {
      // 1. Ambil user yang sedang login
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        // 2. Ambil data 'nama' atau 'full_name' dari Metadata
        // PASTIKAN key ini ('nama') sama dengan saat kamu Register! 
        // Bisa jadi 'full_name', 'name', atau 'nama_lengkap'.
        String? namaDiDatabase = user.userMetadata?['nama'] ?? user.userMetadata?['full_name'];

        if (namaDiDatabase != null && namaDiDatabase.isNotEmpty) {
          userName.value = namaDiDatabase;
        } else {
          // Jika login tapi tidak ada namanya
          userName.value = "Pelanggan Setia"; 
        }
      }
    } catch (e) {
      print("Gagal ambil nama: $e");
    } finally {
      isLoading.value = false;
    }
  }
}