import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Chatscreen(),
    );
  }
}

class Chatscreen extends StatelessWidget {
  final List<ChatUser> users = [
    ChatUser('Yoo Jin', 'It’s a beautiful place', '10:30 AM', 2, 'assets/KimJun.png'),
    ChatUser('Tuan Tran', 'We can start at 8am', '10:30 AM', 0, 'assets/Tuan Tran 1aa.jpg'),
    ChatUser('Henry', 'See you tomorrow', '11:30 AM', 0, 'assets/Henry.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(user.avatar),
            ),
            title: Text(user.name),
            subtitle: Text(user.lastMessage),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.time),
                if (user.unreadMessages > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 21, 0),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      user.unreadMessages.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;

  ChatDetailScreen({required this.user});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Sử dụng map để lưu tin nhắn và loại người gửi

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text,
          'isSentByMe': true, // Đánh dấu tin nhắn là của người gửi
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.user.avatar),
            ),
            SizedBox(width: 10),
            Text(widget.user.name),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByMe = message['isSentByMe'];
                return Row(
                  mainAxisAlignment:
                      isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start, // Điều chỉnh vị trí của tin nhắn
                  children: [
                    if (!isSentByMe)
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.user.avatar),
                        radius: 16,
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSentByMe ? Colors.blue[100] : Colors.grey[300], // Màu nền của tin nhắn
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    if (isSentByMe)
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/xyz.png'), // Avatar của bạn
                        radius: 16,
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatUser {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadMessages;
  final String avatar;

  ChatUser(this.name, this.lastMessage, this.time, this.unreadMessages, this.avatar);
}
