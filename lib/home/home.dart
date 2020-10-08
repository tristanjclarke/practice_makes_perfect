import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/add_dog.dart';
import 'package:practice_makes_perfect/dog/dog_card.dart';
import 'package:practice_makes_perfect/dog/dog_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DogProvider _dogProvider;

  @override
  void initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);
    _dogProvider.getDogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dogs SQFlite Practice')),
      body: SafeArea(
        child: Consumer<DogProvider>(
          builder: (_, dogProvider, child) => Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => DogCard(
                    dog: dogProvider.dogs[index],
                  ),
                  itemCount: dogProvider.dogs.length,
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDog()),
                  ),
                  color: Colors.blue,
                  child: Text('ADD DOG'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
