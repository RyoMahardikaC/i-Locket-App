import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/app_routes.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. MENANGKAP DATA
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    final String doctorName = args['doctorName'] ?? "Dokter";
    final String poliName = args['poliName'] ?? "Spesialis";
    // Ambil URL gambar, jika null pakai string kosong
    final String doctorImage = args['doctorImage'] ?? ""; 
    
    final DateTime date = args['date'] ?? DateTime.now();
    final TimeOfDay time = args['time'] ?? const TimeOfDay(hour: 09, minute: 00);

    // Format Tanggal
    final String datePart = DateFormat('EEEE, d MMM yyyy').format(date);
    final String timePart = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    final String fullSchedule = "$datePart, $timePart";

    // Warna
    const Color primaryBlue = Color(0xFF254EDB);
    const Color cardBg = Color(0xFFDCE2F9);
    const Color textDark = Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Anda Berhasil Mendaftar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Scan Kode QR untuk Check-in Antrian",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 24, 24, 24), fontFamily: 'Poppins'),
                      ),

                      const Spacer(),

                      // --- FOTO DOKTER DENGAN ERROR HANDLING ---
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white, // Background putih jika transparan
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                          ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            doctorImage,
                            fit: BoxFit.cover,
                            // Jika URL Error atau Kosong, tampilkan Icon/Inisial
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    doctorName.isNotEmpty ? doctorName[0] : "D", // Inisial Nama
                                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: primaryBlue),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: textDark, fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        poliName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 23, 23, 23), fontFamily: 'Poppins'),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.calendar_today_outlined, size: 28, color: Color(0xFF1F2937)),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Jadwal Layanan", style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 23, 23, 23), fontFamily: 'Poppins')),
                                const SizedBox(height: 4),
                                Text(fullSchedule, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textDark, fontFamily: 'Poppins')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              
              // TOMBOL KEMBALI
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.home_screen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text("Kembali ke Beranda", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Poppins')),
                ),
              ),
              const SizedBox(height: 16),
              
              // TOMBOL CHECK-IN
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.scan_qr, arguments: args),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text("Check-in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}