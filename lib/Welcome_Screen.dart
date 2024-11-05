import 'package:flutter/material.dart';
import 'mytrips.dart'; // Import màn hình TripScreen
import 'Chatscreen.dart'; // Import màn hình Chatscreen
import 'ExploreScreen.dart'; // Import màn hình ExploreScreen mà bạn đã tạo
import 'NotificationScreen.dart'; // Import màn hình NotificationScreen
import 'ProfileScreen.dart';
class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  _TourScreenState createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình được hiển thị tương ứng với các mục trong BottomNavigationBar
  final List<Widget> _screens = [
    ExploreScreen(), // Liên kết với màn hình Explore
    TripScreen(), // Đảm bảo TripScreen được định nghĩa chính xác
    Chatscreen(), // Đảm bảo tên lớp đúng và import ChatScreen
    NotificationScreen(), // Thêm màn hình Notification
    ProfileScreen(), // Thêm màn hình Profile
  ];

  // Hàm xử lý khi người dùng chọn một mục trong BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Hàm gọi sự kiện khi bấm vào các mục
      ),
    );
  }
}



