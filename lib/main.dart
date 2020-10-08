import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/add_dog.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';
import 'package:practice_makes_perfect/dog/dog_provider.dart';
import 'package:practice_makes_perfect/home/home.dart';
import 'package:practice_makes_perfect/services/db/database_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initDB() async {
    await DatabaseProvider.db.openDB();
  }

  @override
  void initState() {
    initDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DogProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dogs SQFlite Practice',
        home: Home(),
      ),
    );
  }
}
