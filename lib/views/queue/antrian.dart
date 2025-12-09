import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Wajib import ini untuk format tanggal
import '../../routes/app_routes.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 1. LOGIKA MENANGKAP DATA (Baru) ---
    // Mengambil paket data yang dikirim dari BookingController
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // Menyiapkan variabel data (dengan nilai default jika error/kosong)
    final String doctorName = args['doctorName'] ?? "Dr. Stone";
    // Jika poli tidak dikirim, kita pakai default atau string kosong
    final String poliName = args['poliName'] ?? "Spesialis Telinga, Hidung, Tenggorokan"; 
    
    final DateTime date = args['date'] ?? DateTime.now();
    final TimeOfDay time = args['time'] ?? const TimeOfDay(hour: 0, minute: 0);

    // Format Tanggal & Jam 
    final String formattedDate = DateFormat('EEEE, d MMM yyyy').format(date);
    
    // Format jam manual agar 2 digit (misal 09:05) atau pakai time.format(context)
    final String formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";


    // --- 2. DEFINISI WARNA (Tetap) ---
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
              
              // KARTU TIKET BESAR
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
                        // Gambar dummy, nanti bisa diganti sesuai data dokter jika ada URL-nya
                        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"), 
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // --- NAMA DOKTER (Dinamis) ---
                    Text(
                      doctorName, // Menggunakan variabel dari arguments
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // --- SPESIALIS (Dinamis/Static) ---
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

                    // --- JADWAL LAYANAN (Dinamis) ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center, // Tambahkan ini agar di tengah
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
                            // TAMPILKAN TANGGAL & JAM HASIL INPUT
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
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // TOMBOL CHECK-IN
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar("Check-in", "Fitur Check-in akan membuka kamera Scanner");
                    Get.toNamed(AppRoutes.scan_qr, arguments: Get.arguments);
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