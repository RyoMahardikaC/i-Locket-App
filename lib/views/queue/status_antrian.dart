import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/status_antrian_controller.dart';
import '../../routes/app_routes.dart';

class StatusAntrianScreen extends StatelessWidget {
  const StatusAntrianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatusAntrianController());
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color bgPage = Color(0xFFF8F9FE);

    return Scaffold(
      backgroundColor: bgPage,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text("Status Antrian", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.activeQueue.isEmpty && controller.historyQueue.isEmpty) {
             // Tampilan Kosong
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: Get.height * 0.3),
                const Center(child: Text("Belum ada riwayat antrian", style: TextStyle(color: Colors.grey))),
                const Center(child: Text("(Tarik ke bawah untuk refresh)", style: TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            );
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            children: [
              // --- LIST AKTIF ---
              if (controller.activeQueue.isNotEmpty) ...[
                const Text("Antrian Aktif", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ...controller.activeQueue.map((item) => _buildCardFromData(item)),
                const SizedBox(height: 30),
              ],

              // --- LIST RIWAYAT ---
              if (controller.historyQueue.isNotEmpty) ...[
                const Text("Riwayat Terakhir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ...controller.historyQueue.map((item) => _buildCardFromData(item, isHistory: true)),
              ],
            ],
          );
        }),
      ),
    );
  }

  // Helper Mapper Data
  Widget _buildCardFromData(Map<String, dynamic> item, {bool isHistory = false}) {
    // 1. DATA DOKTER
    final docData = item['doctors'] ?? {};
    final String docName = docData['name'] ?? 'Dokter';
    final String specialist = docData['specialist'] ?? 'Umum';
    final String imgUrl = docData['image_url'] ?? "https://ui-avatars.com/api/?name=$docName";

    // 2. DATA BOOKING (PERHATIKAN HURUF BESAR KECIL!)
    final String date = item['Booking_date'] ?? item['booking_date'] ?? '-';
    final String time = item['Booking_time'] ?? item['booking_time'] ?? '-';
    final String queueNo = item['queue_number'] ?? '-';
    final String status = item['status'] ?? 'Menunggu';
    final bool isCheckedIn = item['is_check_in'] ?? false;
    final String bookingId = item['id'].toString();

    // Warna Status
    Color statusColor = Colors.orange;
    if (status.toLowerCase() == 'selesai') statusColor = Colors.green;
    if (status.toLowerCase() == 'batal') statusColor = Colors.red;

    return _buildQueueCard(
      bookingId: bookingId,
      doctorName: docName,
      specialist: specialist,
      queueNumber: queueNo,
      date: date,
      time: time,
      status: status,
      statusColor: statusColor,
      imageUrl: imgUrl,
      isHistory: isHistory,
      isCheckedIn: isCheckedIn,
    );
  }

  // WIDGET KARTU 
  Widget _buildQueueCard({
    required String bookingId,
    required String doctorName,
    required String specialist,
    required String queueNumber,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
    required String imageUrl,
    bool isHistory = false,
    bool isCheckedIn = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(specialist, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 Row(children: [const Icon(Icons.calendar_month, size: 16, color: Colors.grey), const SizedBox(width:4), Text(date, style: const TextStyle(fontWeight: FontWeight.bold))]),
                 const SizedBox(height:4),
                 Row(children: [const Icon(Icons.access_time, size: 16, color: Colors.grey), const SizedBox(width:4), Text(time)]),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text("No. Antrian", style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(queueNumber, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5))),
              ])
            ],
          ),
          if (!isHistory) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
               onPressed: () {
                if (!isCheckedIn) {
                  Get.toNamed(AppRoutes.scan_qr, arguments: {'bookingId': bookingId});
                } else {
                  // --- UBAH BAGIAN INI ---
                  Get.snackbar(
                    "Info",
                    "Sudah Check-in",
                    backgroundColor: Colors.green,       // Mengubah warna latar jadi Hijau
                    colorText: Colors.white,             // Mengubah warna teks jadi Putih
                    icon: const Icon(Icons.check_circle, color: Colors.white), // Opsional: Tambah icon centang
                    snackPosition: SnackPosition.TOP,    // Opsional: Posisi (TOP atau BOTTOM)
                    margin: const EdgeInsets.all(10),    // Opsional: Jarak dari tepi layar
                    borderRadius: 10,                    // Opsional: Kelengkungan sudut
                  );
                }
              },
                style: ElevatedButton.styleFrom(backgroundColor: !isCheckedIn ? const Color(0xFFE91E63) : const Color(0xFF3F51B5)),
                icon: Icon(!isCheckedIn ? Icons.qr_code : Icons.check, color: Colors.white),
                label: Text(!isCheckedIn ? "Scan Barcode" : "Check-in Berhasil", style: const TextStyle(color: Colors.white)),
              ),
            )
          ]
        ],
      ),
    );
  }
}