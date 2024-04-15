import 'dart:convert'; // Import for JSON decoding

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: MyApp(),
    ),
  );
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemePreference(_isDarkMode);
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
    theme._loadThemePreference(); // Load theme preference

    return MaterialApp(
      title: 'Project 6',
      theme: theme.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(),
    );
  }

  // Function to parse JSON data
  void parseJson(String jsonData) {
    Map<String, dynamic> data = json.decode(jsonData);
    print(data); // Print parsed JSON data
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);

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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                theme.toggleTheme().then((_) { });
              },
              child: Text('Toggle Theme'),
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(20),
      color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
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
<<<<<<< Updated upstream
    final counter = Provider.of<CounterModel>(context);    
=======
    final counter = Provider.of<CounterModel>(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

>>>>>>> Stashed changes
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: isDarkTheme ? Colors.grey[800] : Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Counter: ${counter.getCounter(name) ?? 0}',
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () => counter.incrementCounter(name),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(isDarkTheme ? Colors.white : Colors.grey[800]),
                ),
                child: Text(
                  'Increment',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class CounterModel extends ChangeNotifier {
  Map<String, int> _counters = {};

  int? getCounter(String product) => _counters[product];

  void incrementCounter(String product) {
    _counters.update(product, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }
}
