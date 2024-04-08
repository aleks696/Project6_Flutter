import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}

class CounterModel extends ChangeNotifier {
  Map<String, int> _counters = {};

  int? getCounter(String product) => _counters[product];

  void incrementCounter(String product) {
    _counters.update(product, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 6',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project 6:'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counters:',
              style: TextStyle(fontSize: 20),
            ),
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Column(
                  children: counter._counters.entries.map((entry) {
                    return Text(
                      '${entry.key}: ${entry.value}',
                      style: TextStyle(fontSize: 18),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            WidgetTree(),
          ],
        ),
      ),
    );
  }
}

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Products counter:', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          ProductWidget(name: 'Product 1'),
          SizedBox(height: 10),
          ProductWidget(name: 'Product 2'),
          SizedBox(height: 10),
          ProductWidget(name: 'Product 3'),
          SizedBox(height: 10),
          ProductWidget(name: 'Product 4'),
        ],
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String name;

  const ProductWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Counter: ${counter.getCounter(name) ?? 0}'),
              ElevatedButton(
                onPressed: () => counter.incrementCounter(name),
                child: Text('Increment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
