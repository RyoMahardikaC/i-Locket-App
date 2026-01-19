import 'package:get/get.dart';

class RiwayatController extends GetxController {
  // Data Dummy Riwayat (Sesuai gambar referensi)
  final List<Map<String, String>> historyList = [
    {
      'poli': 'Poli THT',
      'time': '12 September, 10:00 AM',
      'doctor': 'Dr. Haydee, Ph.D.',
      'specialist': 'Spesialis Telinga Hidung Tenggorokan',
    },
    {
      'poli': 'Poli Mata',
      'time': '10 Agustus, 09:30 AM',
      'doctor': 'Dr. Angela, Sp.M.',
      'specialist': 'Ophthalmologist',
    },
    {
      'poli': 'Poli Umum',
      'time': '5 Juli, 08:00 AM',
      'doctor': 'Dr. Strange',
      'specialist': 'Dokter Umum',
    },
    {
      'poli': 'Poli Gigi',
      'time': '20 Juni, 14:00 PM',
      'doctor': 'Dr. Ratna, Sp.KG.',
      'specialist': 'Dentist',
    },
  ];
}