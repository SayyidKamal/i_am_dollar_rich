import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Converter> fetchConverter() async {
  final response = await http.get(Uri.parse(
      'https://query1.finance.yahoo.com/v7/finance/options/?symbol=NGN=X'));
  if (response.statusCode == 200) {
    return Converter.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load converter');
  }
}

class Converter {
  String shortName;
  double regularMarketDayHigh;
  String exchangeTimezoneShortName;

  Converter({
    required this.shortName,
    required this.regularMarketDayHigh,
    required this.exchangeTimezoneShortName,
  });

  factory Converter.fromJson(Map<String, dynamic> json) {
    return Converter(
      shortName: json['optionChain']['result'][0]['quote']['shortName'],
      regularMarketDayHigh: json['optionChain']['result'][0]['quote']
          ['regularMarketDayHigh'],
      exchangeTimezoneShortName: json['optionChain']['result'][0]['quote']
          ['exchangeTimezoneShortName'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nigerian Rich App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dollar Rich'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Converter> futureConverter;

  @override
  void initState() {
    super.initState();
    futureConverter = fetchConverter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD700),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.attach_money,
                color: Color(0xFFFFD700),
                size: 250,
              ),
              onPressed: () {
                final snackBar = SnackBar(
                  backgroundColor: const Color(0xFFFFD700),
                  content: FutureBuilder<Converter>(
                    future: futureConverter,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            style: const TextStyle(
                                color: Color(0xFF001F3F), fontSize: 18),
                            '1 USD = ${snapshot.data!.regularMarketDayHigh} NGN');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  action: SnackBarAction(
                    backgroundColor: const Color(0xFF001F3F),
                    textColor: const Color(0xFFFFD700),
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
