import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Durasi animasi fade in
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    // Timer sebelum pindah ke Login (Total 3 detik)
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna Background Biru sesuai desain
    const Color primaryBlue = Color(0xFF3F51B5); 

    return Scaffold(
      backgroundColor: primaryBlue,
      body: Stack(
        children: [
          // 1. KONTEN TENGAH (Logo & Teks)
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Stetoskop (Dari Asset Frame 46.png)
                  Image.asset(
                    'assets/logo.png', // Pastikan nama file sudah diubah jadi logo.png
                    width: 100, // Ukuran disesuaikan agar proporsional
                    height: 100,
                    // color: Colors.white, // Aktifkan jika gambar aslinya hitam/berwarna lain
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Hallo',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. GARIS LOADING DI BAWAH
          Positioned(
            bottom: 120, // Jarak dari bawah layar
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 140, // Lebar garis
                height: 6,  // Ketebalan garis
                decoration: BoxDecoration(
                  // Warna track/background garis (biru gelap transparan)
                  color: Colors.black.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    // Warna garis jalan (Biru lebih terang dari background)
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF254EDB)), 
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}