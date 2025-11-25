// File: lib/views/queue/queue_booking_screen.dart

import 'package:flutter/material.dart';

class QueueBookingScreen extends StatefulWidget {
  const QueueBookingScreen({Key? key}) : super(key: key);

  @override
  State<QueueBookingScreen> createState() => _QueueBookingScreenState();
}

class _QueueBookingScreenState extends State<QueueBookingScreen> {
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _complainController = TextEditingController();
  
  String _selectedMonth = 'Sep';
  int _selectedDay = 12;
  
  final List<String> _months = ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'];
  final List<Map<String, dynamic>> _days = [
    {'day': 'Tue', 'date': 12},
    {'day': 'Wed', 'date': 13},
    {'day': 'Thu', 'date': 14},
    {'day': 'Fri', 'date': 15},
    {'day': 'Sat', 'date': 11},
  ];

  @override
  void dispose() {
    _timeController.dispose();
    _complainController.dispose();
    super.dispose();
  }

  void _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  void _submitBooking() {
    if (_timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // TODO: Implement booking logic
    print('Month: $_selectedMonth');
    print('Day: $_selectedDay');
    print('Time: ${_timeController.text}');
    print('Complaint: ${_complainController.text}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking submitted successfully!'),
        backgroundColor: Color(0xFF4F46E5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Antrian Baru',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Doctor Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Doctor Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://via.placeholder.com/50',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xFF4F46E5),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Doctor Info
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Stone',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Spesialis Telinga, Hidung, Tenggorokan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Calendar Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF08A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Month Row & Calendar Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '- -',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Month Selector
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _months.length,
                      itemBuilder: (context, index) {
                        final month = _months[index];
                        final isSelected = month == _selectedMonth;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMonth = month;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Text(
                              month,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
                                decoration: isSelected ? TextDecoration.underline : null,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Days Selector
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      itemBuilder: (context, index) {
                        final day = _days[index];
                        final isSelected = day['date'] == _selectedDay;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDay = day['date'];
                            });
                          },
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  day['day'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF111827),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${day['date']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Time Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Time*',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: _selectTime,
                    decoration: InputDecoration(
                      hintText: '- -',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      suffixIcon: const Icon(
                        Icons.access_time,
                        color: Color(0xFF6B7280),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Complaint Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What do you feel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _complainController,
                    maxLines: 5,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Text Here',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}