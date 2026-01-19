import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/app_routes.dart';

class StatusAntrianCheckInScreen extends StatelessWidget {
  const StatusAntrianCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // 1. LOGIC DATA (TETAP SAMA SEPERTI KODEMU)
    // =================================================================
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    
    final String doctorName = args['doctorName'] ?? 'Dokter Umum';
    final String poliName = args['poliName'] ?? 'Poli Umum';
    final String queueNumber = args['queueNumber'] ?? '-';
    final DateTime date = args['date'] ?? DateTime.now();
    final TimeOfDay time = args['time'] ?? const TimeOfDay(hour: 0, minute: 0);

    // Format Tanggal (Pastikan locale sesuai konfigurasi main.dart kamu)
    final String formattedDate = DateFormat('EEEE, d MMMM').format(date);
    
    // Format Jam
    final String startTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    final int endMinute = (time.minute + 15) % 60;
    final int addHour = (time.minute + 15) ~/ 60;
    final int endHour = (time.hour + addHour) % 24;
    final String endTime = "${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}";

    // =================================================================
    // 2. KONFIGURASI WARNA & UKURAN (SESUAI DESAIN)
    // =================================================================
    const Color headerBlue = Color(0xFF354498); // Biru Gelap (Header)
    const Color bgLavender = Color(0xFFE2E6FA); // Ungu Muda (Background Bawah)
    const Color primaryBlue = Color(0xFF354498); // Biru untuk Tombol & Progress
    
    // Ukuran area header biru di belakang
    final double headerHeight = 220.0; 
    // Jarak kartu putih dari atas layar
    final double cardTopMargin = 160.0;
    // Ukuran Kotak Icon
    final double iconSize = 80.0;

    return Scaffold(
      backgroundColor: bgLavender, // Warna background bawah (sesuai desain)
      extendBodyBehindAppBar: true, // Agar Appbar menyatu dengan header
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.offAllNamed(AppRoutes.home_screen),
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
          // LAYER 1: HEADER BIRU TUA (Background Atas)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(color: headerBlue),
          ),

          // LAYER 2: KARTU PUTIH UTAMA
          Container(
            margin: EdgeInsets.only(top: cardTopMargin),
            height: double.infinity, // Memenuhi sisa layar ke bawah
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24), // Padding atas 60 agar tidak nabrak icon
              child: Column(
                children: [
                  // --- KONTEN DALAM KARTU ---
                  
                  // Judul & Nama Faskes
                  const Text(
                    "Check-in Berhasil",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Puskesmas Pakis Kembar", // Bisa diganti dinamis jika ada datanya
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 31, 31, 31),
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Label Nomor Antrian
                  Text(
                    "Nomor Antrian",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 31, 31, 31),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // ANGKA NOMOR ANTRIAN (DINAMIS)
                  Text(
                    queueNumber,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Hitam pekat sesuai desain
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 30),

                  // LINGKARAN PROGRESS (Sesuai Desain)
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Lingkaran Abu (Background Full)
                        CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 12,
                          valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 155, 155, 155)),
                        ),
                        // Lingkaran Biru (Progress sebagian)
                        const CircularProgressIndicator(
                          value: 0.3, // Statis 30% sesuai gambar desain
                          strokeWidth: 12,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
                          strokeCap: StrokeCap.round,
                        ),
                        // Angka di Tengah (Sisa Antrian)
                        Center(
                          child: Text(
                            "5", // Bisa diganti logic sisa antrian jika ada
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(), // Dorong konten ke bawah

                  // ESTIMASI LAYANAN (DINAMIS)
                  Text(
                    "Estimasi layanan $startTime - $endTime",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 31, 31, 31),
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TOMBOL KEMBALI (Full Width, Biru)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.home_screen);
                      },
                      child: const Text(
                        'Kembali ke Beranda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // LAYER 3: ICON MENGAMBANG (FLOATING ICON)
          // Posisinya diatur agar berada di tengah-tengah perbatasan Header & Card
          Positioned(
            top: cardTopMargin - (iconSize / 2), // Setengah icon di atas garis
            child: Container(
              height: iconSize,
              width: iconSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.layers_outlined, // Icon tumpukan
                  size: 40,
                  color: primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}