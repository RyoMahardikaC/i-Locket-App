import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import '../../routes/app_routes.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 1. MENANGKAP DATA DARI BOOKING ---
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // Menyiapkan variabel data (dengan nilai default aman)
    final String doctorName = args['doctorName'] ?? "Dr. Stone";
    final String poliName = args['poliName'] ?? "Spesialis THT";
    
    // Handle Tanggal (Pastikan tidak null)
    final DateTime date = args['date'] ?? DateTime.now();
    // Handle Waktu (Pastikan tidak null)
    final TimeOfDay time = args['time'] ?? const TimeOfDay(hour: 09, minute: 00);

    // Format Tanggal (Contoh: Tuesday, 12 Sep 2024)
    final String formattedDate = DateFormat('EEEE, d MMM yyyy').format(date);
    
    // Format Jam Manual (Contoh: 09:05) agar selalu 2 digit
    final String formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    // --- 2. DEFINISI WARNA ---
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color cardBg = Color(0xFFD6D7F6); 
    const Color textDark = Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              
              // --- KARTU TIKET BESAR ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // Judul Sukses
                    const Text(
                      "Anda Berhasil Mendaftar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Scan Kode QR untuk Check-in Antrian",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Foto Dokter
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"), 
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nama Dokter (Dinamis)
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Spesialis (Dinamis)
                    Text(
                      poliName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Info Jadwal (Dinamis)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 28, color: primaryBlue),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jadwal Layanan",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Tampilkan Hasil Format Tanggal & Jam
                            Text(
                              "$formattedDate, $formattedTime",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // --- TOMBOL KEMBALI ---
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Kembali ke halaman utama dan hapus history navigasi sebelumnya agar tidak numpuk
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
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // --- TOMBOL CHECK-IN ---
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke Scanner QR
                    // PENTING: Kita teruskan arguments (data dokter/jam) ke halaman scanner
                    // agar nanti bisa ditampilkan di halaman 'Status Antrian' setelah scan sukses.
                    Get.toNamed(
                      AppRoutes.scan_qr, 
                      arguments: args // Meneruskan data yang diterima halaman ini
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Check-in",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}