import 'dart:async';
import 'package:flutter/material.dart';
import 'package:listview_api_app/api.dart' as api;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget raíz
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: 'Bens ativos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<api.Bem> data = [];

  final apiUri = Uri.parse('http://api.kleiloes.com.br/tipo-bem/ativos');

  Future<void> _getData() async {
    final response = await api.getData(apiUri);

    this.setState(() => data = response);
  }

  @override
  void initState(){
    this._getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title),
      ),
      body: ResourceList(data: data),
    );
  }
}

class ResourceList extends StatelessWidget {
  const ResourceList({
    super.key,
    required this.data,
  });

  final List<api.Bem> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("Nome:", style: TextStyle(fontWeight: FontWeight.bold,),),
                      Text(data[index].nome),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("Lotes:", style: TextStyle(fontWeight: FontWeight.bold,),),
                      Text(data[index].lotes.toString()),
                    ],
                  ),
                ],
            ),
          ),
        );
      },
    );
  }
}
