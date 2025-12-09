import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/app_routes.dart';

class StatusAntrianCheckInScreen extends StatelessWidget {
  const StatusAntrianCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. AMBIL DATA DARI ESTAFET ARGUMENTS
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    
    // Data Dinamis
    final DateTime date = args['date'] ?? DateTime.now();
    final TimeOfDay time = args['time'] ?? const TimeOfDay(hour: 0, minute: 0);

    // Format Tampilan
    final String formattedDate = DateFormat('EEEE, d MMMM').format(date); // Contoh: Tuesday, 12 September
    // Estimasi layanan: Waktu booking + 15 menit
    final String startTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    final int endMinute = (time.minute + 15) % 60;
    final int endHour = time.hour + ((time.minute + 15) ~/ 60);
    final String endTime = "${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}";

    // Warna Desain
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color bgPage = Color(0xFFE0E3F3); // Ungu muda background

    return Scaffold(
      backgroundColor: bgPage,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.offAllNamed(AppRoutes.home_screen), // Back langsung ke Home
        ),
        title: const Text(
          "Status Antrian",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Biru setengah (untuk menutupi gap header)
          Container(
            height: 100,
            color: primaryBlue,
          ),

          // CARD UTAMA
          Container(
            margin: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24), // Padding atas besar untuk icon
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Agar card menyesuaikan isi
              children: [
                const Text(
                  "Check-in Berhasil",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Puskesmas Pakis Kembar",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 30),

                // NOMOR ANTRIAN
                const Text(
                  "Nomor Antrian",
                  style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 4),
                const Text(
                  "A-12", // Bisa dibuat random/dinamis jika mau
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 30),

                // LINGKARAN PROGRESS (Sisa Antrian)
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: 0.7, // 70% Progress dummy
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
                      ),
                      const Center(
                        child: Text(
                          "5", // Dummy sisa antrian
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),

                // ESTIMASI WAKTU (Dinamis)
                Text(
                  "Estimasi layanan $startTime - $endTime",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate, // Tanggal dinamis
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 40),

                // TOMBOL KEMBALI
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.home_screen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Kembali ke Beranda",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ICON STACK DI ATAS (Floating)
          Positioned(
            top: 0,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: const Center(
                // Menggunakan Icon tumpuk (Layers) sesuai gambar
                child: Icon(Icons.layers, size: 40, color: Color(0xFF0D1C52)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}