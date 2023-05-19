import 'package:flutter/material.dart';
import 'trainquery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secret.dart';
import 'main.dart';

class TrainDataScreen extends StatefulWidget {
  final String enteredValue;

  TrainDataScreen({required this.enteredValue});
  @override
  _TrainDataScreenState createState() => _TrainDataScreenState();
}

class _TrainDataScreenState extends State<TrainDataScreen> {
  String getData = "wait..";
  String name = "";
  String trainfrom = "";
  String trainto = "";
  String daysrun = "";
  String classes_avail = "";
  String arrtime = '';
  String deptime = '';
  int train_no = 0;
  Future fetchdata() async {
    http.Response response;
    response = await http.post(Uri.parse("https://trains.p.rapidapi.com/"),
        headers: {
          'X-RapidAPI-Key': secret,
          'X-RapidAPI-Host': 'trains.p.rapidapi.com'
        },
        body: jsonEncode({
          "search": '${widget.enteredValue}',
        }));

    getData = response.body;
    List<dynamic> dynamicValuesList = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        getData = response.body;
        for (var item in dynamicValuesList) {
          name = item['name'];

          trainfrom = item['train_from'];

          trainto = item['train_to'];

          train_no = item['train_num'];

          Map<String, dynamic> trainData = item['data'];

          trainData['days'].forEach((key, value) {
            if (value == 1) {
              if (daysrun.contains('$key')) {
                daysrun += "";
              } else {
                daysrun += '$key';
                daysrun += ' ';
              }
            }
          });

          List<dynamic> myList = trainData['classes'];
          for (var elem in myList) {
            if (classes_avail.contains(elem)) {
              classes_avail += "";
            } else {
              classes_avail += elem;
              classes_avail += ' ';
            }
          }

          arrtime = trainData['arriveTime'];

          deptime = trainData['departTime'];
        }
      });
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Train Information'),
              centerTitle: true,
              backgroundColor: Colors.amber[800],
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Image.asset(
                  'assets/train.jpg',
                  height: 300,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: Column(
                    children: [
                      Row(children: [
                        Flexible(
                            child: Text(
                          'Train Name : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        )),
                        Text(
                          '$name',
                          style:
                              TextStyle(fontSize: 15, color: Colors.blue[500]),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ]),
                      Row(children: [
                        Flexible(
                            child: Text(
                          'Train Number : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        )),
                        Text(
                          '$train_no',
                          style:
                              TextStyle(fontSize: 15, color: Colors.blue[500]),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Train Starts : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$trainfrom',
                          style:
                              TextStyle(fontSize: 15, color: Colors.green[500]),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Train Ends : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$trainto',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Days on which the train runs : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$daysrun',
                          style: TextStyle(fontSize: 15, color: Colors.amber),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Classes available on train : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$classes_avail',
                          style: TextStyle(fontSize: 15, color: Colors.teal),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Arrival Time : ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$arrtime',
                          style: TextStyle(fontSize: 15, color: Colors.indigo),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          'Departure Time: ',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$deptime',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 224, 13, 182)),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainStatus(),
                        ),
                      );
                    },
                    child: const Text('Back'),
                  ),
                )
              ]),
            )));
  }
}
