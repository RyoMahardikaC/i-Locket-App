import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusAntrianScreen extends StatelessWidget {
  const StatusAntrianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color bgPage = Color(0xFFF8F9FE); // Background agak abu terang

    return Scaffold(
      backgroundColor: bgPage,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
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
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Judul Section
          const Text(
            "Antrian Aktif",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),

          // CARD 1: Antrian yang sedang berjalan (Menunggu)
          _buildQueueCard(
            doctorName: "Dr. Stone",
            specialist: "Spesialis THT",
            queueNumber: "A-012",
            date: "Selasa, 12 Sep 2024",
            time: "11:00 - 11:30",
            status: "Menunggu",
            statusColor: Colors.orange,
            imageUrl: "https://i.pravatar.cc/150?img=11",
          ),

          const SizedBox(height: 30),

          // Judul Section Riwayat
          const Text(
            "Riwayat Terakhir",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),

          // CARD 2: Antrian yang sudah selesai
          _buildQueueCard(
            doctorName: "Dr. Chopper",
            specialist: "Spesialis Anak",
            queueNumber: "B-005",
            date: "Senin, 05 Sep 2024",
            time: "09:00 - 09:30",
            status: "Selesai",
            statusColor: Colors.green,
            imageUrl: "https://i.pravatar.cc/150?img=12",
            isHistory: true, // Tampilan agak beda (lebih pudar)
          ),
        ],
      ),
    );
  }

  // WIDGET KARTU ANTRIAN
  Widget _buildQueueCard({
    required String doctorName,
    required String specialist,
    required String queueNumber,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
    required String imageUrl,
    bool isHistory = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Bagian Atas: Info Dokter & Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto Dokter
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Nama & Spesialis
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialist,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),

              // Badge Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          const Divider(color: Colors.black12),
          const SizedBox(height: 10),

          // Bagian Bawah: Detail Waktu & Nomor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Waktu
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Nomor Antrian (Besar)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "No. Antrian",
                    style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: 'Poppins'),
                  ),
                  Text(
                    queueNumber,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F51B5), // Biru Primary
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              )
            ],
          ),

          // Tombol Aksi (Hanya muncul jika antrian aktif/bukan history)
          if (!isHistory) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi Lihat Tiket Detail (QR Code)
                  // Get.toNamed(AppRoutes.antrian); // Bisa diarahkan ke tiket yang tadi
                  Get.snackbar("Info", "Menampilkan QR Code tiket...");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Lihat QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}