import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<MyApp> {
  Future<List> getData() async {
    var url = Uri.parse('http://localhost/dbpertemuan5/list.php'); //Api Link
    final response = await http.post(url);
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('MyAplication'),
        ),
        body: FutureBuilder<List>(
          future: getData(),
          builder: (ctx, ss) {
            if (ss.hasError) {
              print("error");
            }
            if (ss.hasData) {
              return Items(list: ss.data!);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {
  List list;
  Items({Key? key, required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 200,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30, top: 0, left: 0),
                      child: Text('${index + 1}'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama : ${list[index]['name']}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Alamat : ${list[index]['address']}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Penghasilan : ${list[index]['salary']}'),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[400]),
                  ),
                  child: Text(
                    'Detail',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    // return ListView.builder(
    //     // ignore: unnecessary_null_comparison
    //     itemCount: list == null ? 0 : list.length,
    //     itemBuilder: (ctx, i) {
    //       return ListTile(
    //         leading: const Icon(Icons.text_snippet_outlined),
    //         title: Text(list[i]['title']), //Key
    //         subtitle: Text(list[i]['content']), //Key
    //         // onTap: () => Navigator.of(context).push(
    //         //   MaterialPageRoute(
    //         //     builder: (BuildContext context) =>
    //         //         Details(list: list, index: i),
    //         //   ),
    //         // ),
    //       );
    //     });
  }
}
