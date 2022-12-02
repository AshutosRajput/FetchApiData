import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

String stringResponse = stringResponse;
Map mapResponse = mapResponse;
Map dataResponse = dataResponse;
List listResponse = listResponse;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: listResponse == null ? 0 : listResponse.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listResponse[index]['id'].toString()),
                  Text(listResponse[index]['first_name'].toString()),
                ],
              ),
              leading: CircleAvatar(
                child: Image.network(listResponse[index]['avatar']),
              ),
              subtitle: Text(listResponse[index]['last_name'].toString()),
              trailing: Text(listResponse[index]['email'].toString()),
            ));
          }),
    );
  }
}
