import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  // --- FUNGSI REGISTER ---
  Future<void> register(String email, String password, String name, String phone) async {
    try {
      isLoading.value = true;

      // 1. Kirim data ke Supabase Auth
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        // Kita simpan Nama & No HP di metadata user agar mudah diambil nanti
        data: {
          'full_name': name,
          'phone': phone,
        },
      );

      // 2. Cek apakah berhasil
      if (res.user != null) {
        Get.snackbar("Berhasil", "Akun berhasil dibuat! Silakan Login.", backgroundColor: Colors.green, colorText: Colors.white);
        
        // Redirect ke halaman login (atau langsung home jika auto confirm on)
        Get.offAllNamed(AppRoutes.login);
      }
    } on AuthException catch (e) {
      Get.snackbar("Gagal Register", e.message, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan sistem.", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // --- FUNGSI LOGIN ---
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // 1. Login dengan Password
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // 2. Jika sukses, arahkan ke Home
      if (res.session != null) {
        Get.snackbar("Berhasil", "Selamat datang kembali!", backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(AppRoutes.home_screen);
      }
    } on AuthException catch (e) {
      Get.snackbar("Gagal Login", e.message, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan sistem.", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // --- FUNGSI LOGOUT ---
  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}