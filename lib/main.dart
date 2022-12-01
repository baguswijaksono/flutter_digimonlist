import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digimon List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: digicard(),
    );
  }
}

class digicard extends StatelessWidget {
    final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

   digicard({super.key});
    Future<List<dynamic>> _fecthListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title:  Text('List Digimon'),
      ),
     body: FutureBuilder<List<dynamic>>(
        future: _fecthListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding:  EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children:  [
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius: 35,
                            backgroundImage: NetworkImage(snapshot.data[index]['img'].toString(),),
                            ),
                            title: Text(snapshot.data[index]['name'].toString(),),
                            subtitle: Text(snapshot.data[index]['level'].toString(),),
                            )
                            ],
                            ),
                            );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

    );
  }
}
