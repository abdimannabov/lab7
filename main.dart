import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:message_app/components/post.dart';

import 'components/details.dart';

Future<List> fetchData() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

void main() async {
  runApp(MyApp());
  var data = await fetchData();
  print(data[0]['title']);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        children: [
          Text("POST request:"),
          ElevatedButton(onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
          }, child: Text("Go to POST request (Part D task)")),
          SizedBox(height: 20),
          Text("Get request:"),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${snapshot.error}'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Retry fetching data
                          (context as Element).reassemble();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  );
                } else {
                  final data = snapshot.data as List;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(post: data[index]),
                          ),
                        ),
                        child: ListTile(
                          title: Text(data[index]['title']),
                          subtitle: Text(data[index]['body']),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
