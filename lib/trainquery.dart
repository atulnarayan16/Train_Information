import 'package:flutter/material.dart';
import 'traininfo.dart';

void main() {
  runApp(const TrainStatus());
}

class TrainStatus extends StatefulWidget {
  const TrainStatus({Key? key}) : super(key: key);

  @override
  State<TrainStatus> createState() => _TrainStatusState();
}

class _TrainStatusState extends State<TrainStatus> {
  final TextEditingController _textEditingController = TextEditingController();
  String enteredValue = '';
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
          const SizedBox(
            width: double.infinity,
            height: 0,
          ),
          Image.asset(
            'assets/train.jpg',
            height: 250,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Train Name or Train Number',
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    enteredValue = _textEditingController.text;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TrainDataScreen(enteredValue: enteredValue),
                    ),
                  );
                },
                child: const Text('Get Train Information'),
              ),
            ),
          )
        ])),
      ),
    );
  }
}
