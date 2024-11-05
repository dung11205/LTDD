import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final List<Map<String, String>> trips = [
    {
      'location': 'Hanoi, Vietnam',
      'title': 'Quoc Tu Giam Temple',
      'date': 'Feb 2, 2020',
      'time': '8:00 - 10:00',
      'guide': 'Stephne',
      'image': 'assets/quoctugiam.png',
      'guide_image': 'assets/Tuan tran 1aa.jpg',
    },
    {
      'location': 'Ho Chi Minh, Vietnam',
      'title': 'Dinh Doc Lap',
      'date': 'Feb 2, 2020',
      'time': '8:00 - 10:00',
      'guide': 'Myung Dae',
      'image': 'assets/dinhdoclap.png',
      'guide_image': 'assets/KimJun.png',
    },
        {
      'location': 'Ho Chi Minh, Vietnam',
      'title': 'Dinh Doc Lap',
      'date': 'Feb 2, 2020',
      'time': '8:00 - 10:00',
      'guide': 'Myung Dae',
      'image': 'assets/dinhdoclap.png',
      'guide_image': 'assets/KimJun.png',
    },
        {
      'location': 'Ho Chi Minh, Vietnam',
      'title': 'Dinh Doc Lap',
      'date': 'Feb 2, 2020',
      'time': '8:00 - 10:00',
      'guide': 'Myung Dae',
      'image': 'assets/dinhdoclap.png',
      'guide_image': 'assets/KimJun.png',
    },
  ];

  // Xây dựng danh sách các chuyến đi
  Widget _buildTripList(List<Map<String, String>> trips, BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return Card(
          margin: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(trip['image']!, height: 150, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            trip['location']!,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trip['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(trip['date']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(trip['time']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(trip['guide']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(trip['guide_image']!),
                      radius: 25,
                      backgroundColor: Colors.teal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _buildTripList(trips, context),  // Nội dung chính là danh sách các chuyến đi
    );
  }
}
