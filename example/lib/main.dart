import 'package:api_handler/features/api_handler/data/enums/header_enum.dart';
import 'package:api_handler/features/api_handler/data/enums/response_enum.dart';
import 'package:api_handler/features/api_handler/data/models/query_model.dart';
import 'package:api_handler/features/api_handler/data/models/response_model.dart';
import 'package:api_handler/features/api_handler/usecases/api_handler.dart';
import 'package:flutter/material.dart';

void main() {
  // APIHandler apiHandler = APIHandler();
  // apiHandler.setToken('tokene alaki');
  // apiHandler.get(
  //   'urle alaki',
  //   headerEnum: HeaderEnum.BearerHeaderEnum,
  //   responseEnum: ResponseEnum.ResponseModelEnum,
  // );
  // apiHandler.post(
  //   'urle alakie 2',
  //   body: '{}',
  //   headerEnum: HeaderEnum.BearerHeaderEnum,
  //   responseEnum: ResponseEnum.ResponseModelEnum,
  // );
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                MaterialButton(
                  onPressed: () async {
                    APIHandler api = APIHandler();
                    ResponseModel res = await api.get(
                      "https://appgaraj.dinavision.org/api/v1/Users/GetValidationCode",
                      queries: [
                        QueryModel(name: "mobile", value: "09199118259")
                      ],
                      headerEnum: HeaderEnum.BasicHeaderEnum,
                      responseEnum: ResponseEnum.ResponseModelEnum,
                    );

                    if (res.isSuccess) {
                      print(res);
                    }
                  },
                  color: Colors.red,
                  child: Text("Get"),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: Text("Post"),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  child: Text("Put"),
                ),
              ],
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
