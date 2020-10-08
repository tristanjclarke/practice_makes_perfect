import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/db/database_provider.dart';
import 'package:practice_makes_perfect/models/dog.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Dog> dogs = <Dog>[];

  Future<void> initDb() async {
    await DatabaseProvider.db.openDB();
  }

  Future<void> loadData() async {
    DatabaseProvider.db.getDogs().then((dogs) {
      setState(() {
        this.dogs = dogs;
      });
    });
  }

  @override
  void initState() {
    initDb();
    loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dogs SQFlite Practice',
      home: DogsPage(items: dogs),
    );
  }
}

class DogsPage extends StatelessWidget {
  const DogsPage({this.items});

  final List<Dog> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dogs SQFlite Practice')),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            items.isEmpty
                ? Expanded(child: SizedBox.shrink())
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => DogItem(
                        item: items[index],
                      ),
                      itemCount: items.length,
                    ),
                  ),
            Center(
              child: FlatButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDogPage()),
                ),
                color: Colors.blue,
                child: Text('ADD DOG'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DogItem extends StatelessWidget {
  const DogItem({this.item});

  final Dog item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name),
          Text(item.breed),
          Text(item.age.toString()),
        ],
      ),
    );
  }
}

class AddDogPage extends StatelessWidget {
  TextEditingController dogName = TextEditingController();
  TextEditingController dogBreed = TextEditingController();
  TextEditingController dogAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: dogName,
              ),
              TextFormField(
                controller: dogBreed,
              ),
              TextFormField(
                controller: dogAge,
              ),
              Expanded(child: SizedBox.shrink()),
              Center(
                child: FlatButton(
                  onPressed: () async {
                    await DatabaseProvider.db.insertDog(Dog(
                      name: dogName.text,
                      breed: dogBreed.text,
                      age: dogAge.text,
                    ));
                    FormState().save();
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  child: Text('CREATE DOG'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
