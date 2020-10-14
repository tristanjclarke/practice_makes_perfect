import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/dog/widgets//add_dog.dart';
import 'package:practice_makes_perfect/dog/widgets/dog_card.dart';
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
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(10),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        children: List.generate(
                          dogProvider.dogs.length,
                          (index) {
                            return DogCard(
                              dog: dogProvider.dogs[index],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDog()),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
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
