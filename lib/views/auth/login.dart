import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // State
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- LOGIKA LOGIN ---
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // 1. Tampilkan Snackbar Sukses
      Get.snackbar(
        "Berhasil",
        "Login Berhasil! Masuk ke Dashboard...",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );

      // 2. Navigasi ke Home
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAllNamed(AppRoutes.home_screen);
      });
    } else {
      Get.snackbar(
        "Gagal",
        "Mohon periksa kembali email dan password",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  // --- NAVIGASI KE REGISTER ---
  void _handleRegister() {
    Get.toNamed(AppRoutes.register);
  }

  // --- FORGOT PASSWORD ---
  void _handleForgotPassword() {
    Get.snackbar("Info", "Fitur Lupa Password belum tersedia");
  }

  @override
  Widget build(BuildContext context) {
    // Warna Biru Utama (Sesuai Splash Screen & Desain)
    const Color primaryBlue = Color(0xFF3F51B5); 
    const Color textDark = Color(0xFF1F2937);
    const Color textGrey = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: primaryBlue, 
      body: Stack(
        children: [
          // 1. LOGO DI TENGAH ATAS (Sesuai Desain)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35, // 35% layar untuk area biru
            child: Center(
              child: Image.asset(
                'assets/logo.png', // Pastikan file Frame 46.png sudah direname jadi logo.png
                width: 80, 
                height: 80,
                // color: Colors.white, // Hapus komentar ini jika gambar aslinya hitam
              ),
            ),
          ),

          // 2. FORM CONTAINER (PUTIH DI BAWAH)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70, // 70% layar untuk form
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28, // Ukuran disesuaikan
                          fontWeight: FontWeight.bold,
                          color: textDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Please Login to Online Consultant',
                        style: TextStyle(
                          fontSize: 14,
                          color: textGrey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ==============================
                      // EMAIL INPUT
                      // ==============================
                      const Text(
                        'Email*',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Placeholder',
                          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                          prefixIcon: const Icon(Icons.email_outlined, color: primaryBlue),
                          filled: true,
                          fillColor: Colors.white, // Background putih sesuai gambar
                          // Border default (abu-abu tipis)
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          // Border saat diklik (biru)
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter your email';
                          if (!value.contains('@')) return 'Please enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // ==============================
                      // PASSWORD INPUT
                      // ==============================
                      const Text(
                        'Password*',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                          prefixIcon: const Icon(Icons.lock_outline, color: primaryBlue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter your password';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // ==============================
                      // REMEMBER ME & FORGOT PASSWORD
                      // ==============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: primaryBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textGrey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: _handleForgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryBlue,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // ==============================
                      // LOGIN BUTTON
                      // ==============================
                      SizedBox(
                        width: double.infinity,
                        height: 52, // Tinggi tombol disesuaikan
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0, // Flat style sesuai desain modern
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ==============================
                      // REGISTER LINK
                      // ==============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: textDark,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          GestureDetector(
                            onTap: _handleRegister,
                            child: const Text(
                              'Register Here',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryBlue,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Spasi bawah tambahan
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}