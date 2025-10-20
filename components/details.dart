import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map post;

  const Details({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(post['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(post['body'], style: TextStyle(fontSize: 16)),
            ElevatedButton(onPressed:() {
              Navigator.pop(context);
            }, 
            child: Text('Go Back'))
          ],
        ),
      ),
    );
  }
}
