// File: lib/views/booking/registration_success.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarUrl; // bisa asset path atau network url
  final String doctorName;
  final String doctorSpecialty;
  final String scheduleText;

  const RegistrationSuccessScreen({
    Key? key,
    this.title = 'Anda Berhasil Mendaftar',
    this.subtitle = 'Scan Kode QR untuk Check-in Antrian',
    this.avatarUrl = '', // jika kosong akan pakai placeholder
    this.doctorName = 'Dr. Stone',
    this.doctorSpecialty = 'Spesialis Telinga, Hidung, Tenggorokan',
    this.scheduleText = 'Tuesday, 12 Sep 2024, 11:00',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // warna tema yang konsisten dengan project
    const Color primary = Color(0xFF4F46E5);
    const Color cardBg = Color(0xFFEDEBFF); // warna card lembut
    const double radius = 18.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // spacer top
              const SizedBox(height: 24),

              // Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Avatar
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage:
                              avatarUrl.isNotEmpty ? _imageProvider(avatarUrl) : null,
                          child: avatarUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 36,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Doctor name & specialty
                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        doctorSpecialty,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),

                      const Spacer(),

                      // Jadwal row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Jadwal Layanan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  scheduleText,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Kembali ke beranda: ganti route sesuai AppRoutes di projectmu
                    if (Get.isRegistered<AppRoutes>()) {
                      // fallback: just try named route
                    }
                    Get.offAllNamed(AppRoutes.home_screen); // pastikan AppRoutes.home ada
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Check-in: pindah ke halaman check-in (pastikan route ada)
                    Get.toNamed(AppRoutes.checkin, arguments: {
                      'doctor': doctorName,
                      'schedule': scheduleText,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Check-in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // helper sederhana memilih provider image (network atau asset)
  static ImageProvider _imageProvider(String urlOrPath) {
    if (urlOrPath.startsWith('http') || urlOrPath.startsWith('https')) {
      return NetworkImage(urlOrPath);
    }
    return AssetImage(urlOrPath);
  }
}
