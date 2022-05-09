import 'package:flutter/material.dart';
import 'init.dart';

// flutter run -d edge --web-renderer html

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final departureController = TextEditingController();
  final arrivalController = TextEditingController();
  bool view = false;

  @override
  Widget build(BuildContext context) {
    getDistanceGraph(departureCode: 'KNAP', arrivalCode: 'KMUK');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 16),
            child: TextField(
              controller: departureController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Departure',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: arrivalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Arrival',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    view = true;
                  });
                },
                child: const Text('Get Route')),
          ),
          if (view)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineNumberWidget(
                departureCode: departureController.text,
                arrivalCode: arrivalController.text,
              ),
            ),
        ],
      ),
    );
  }
}

class LineNumberWidget extends StatelessWidget {
  const LineNumberWidget({
    Key? key,
    required this.departureCode,
    required this.arrivalCode,
  }) : super(key: key);

  final String departureCode;
  final String arrivalCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getDistanceGraph(
          departureCode: departureCode,
          arrivalCode: arrivalCode,
        ),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index) {
                  if (!snapshot.hasData) return const Text('Error: No Data');
                  return Text(
                    'Station: ${snapshot.data?[index]}',
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            );
          } else {
            return const Text('Loading...');
          }
        }));
  }
}
