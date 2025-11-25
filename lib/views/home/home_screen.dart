// File: lib/views/home/home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // TODO: Navigate to different screens based on index
    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        // Navigate to Jadwal
        print('Navigate to Jadwal');
        break;
      case 2:
        // Navigate to Notifikasi
        print('Navigate to Notifikasi');
        break;
      case 3:
        // Navigate to Profil
        print('Navigate to Profil');
        break;
    }
  }

  void _navigateToDaftarAntrian() {
    // TODO: Navigate to Daftar Antrian Baru
    print('Navigate to Daftar Antrian Baru');
  }

  void _navigateToCekStatus() {
    // TODO: Navigate to Cek Status Antrian
    print('Navigate to Cek Status Antrian');
  }

  void _navigateToRiwayat() {
    // TODO: Navigate to Riwayat Kunjungan
    print('Navigate to Riwayat Kunjungan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF4F46E5),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Greeting Text
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Johan!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Semoga sehat selalu',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Menu Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Daftar Antrian Baru
                    _buildMenuCard(
                      icon: Icons.calendar_today,
                      title: 'Daftar Antrian Baru',
                      subtitle: 'Buat antrian klinik',
                      onTap: _navigateToDaftarAntrian,
                    ),
                    const SizedBox(height: 12),
                    
                    // Cek Status Antrian
                    _buildMenuCard(
                      icon: Icons.layers,
                      title: 'Cek Status Antrian',
                      subtitle: 'Lihat nomor & estimasi waktu',
                      onTap: _navigateToCekStatus,
                    ),
                    const SizedBox(height: 12),
                    
                    // Riwayat Kunjungan
                    _buildMenuCard(
                      icon: Icons.description,
                      title: 'Riwayat Kunjungan',
                      subtitle: 'Lihat riwayat antrian',
                      onTap: _navigateToRiwayat,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Berita Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Berita',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // News Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tanda tubuhmu terpapar Virus',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'Baca selengkapnya',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Virus Icon Illustration
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.coronavirus,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF4F46E5),
          unselectedItemColor: const Color(0xFF9CA3AF),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}