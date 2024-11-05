import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExploreScreen(),
    );
  }
}

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  // Danh sách các hướng dẫn viên
  final List<Map<String, String>> guides = [
    {
      'name': 'Tuan Tran',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/Tuan Tran 1aa.jpg',
    },
    {
      'name': 'Linh Hana',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/Linh.jpg',
    },
    {
      'name': 'Tuan Tran',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/Rectangle 325.png',
    },
    {
      'name': 'Linh Hana',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/Henry.png',
    },
    {
      'name': 'Tuan Tran',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/Matt.png',
    },
    {
      'name': 'Linh Hana',
      'location': 'Danang, Vietnam',
      'reviews': '127 Reviews',
      'image': 'assets/KimJun.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          // Hình ảnh Cầu Rồng
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/cc.png',
                  width: double.infinity,
                  height: 130.0,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          // Thanh tìm kiếm
          Positioned(
            top: 120, // Định vị thanh tìm kiếm cách đỉnh hình ảnh 1/4 chiều cao
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (text) {
                        setState(() {
                          _showClearButton = text.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search guides...',
                      ),
                    ),
                  ),
                  if (_showClearButton)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _showClearButton = false;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  VerticalDivider(
                    width: 10,
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          // Nội dung chính bên dưới thanh tìm kiếm
          Positioned(
            top: 200, // Bắt đầu hiển thị nội dung chính dưới thanh tìm kiếm
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Guides in Danang',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('SEE MORE'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: guides.length,
                      itemBuilder: (context, index) {
                        final guide = guides[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                guide['image']!,
                                width: double.infinity,
                                height: 180.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 238, 105, 3),
                                      size: 20.0,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  guide['reviews']!,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              guide['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              guide['location']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
