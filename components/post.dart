import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: {
        'title': _titleController.text,
        'body': _bodyController.text,
        'userId': '1',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post submitted successfully ✅')),
      );
      print(response.statusCode);
      print(response.body);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit post ❌')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('POST Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Body',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendData,
              child: Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}

