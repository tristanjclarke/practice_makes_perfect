import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';
import 'package:practice_makes_perfect/dog/dog_provider.dart';
import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:provider/provider.dart';

class AddDog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              _Name(),
              SizedBox(height: 20),
              _Breed(),
              Expanded(child: SizedBox.shrink()),
              _AddDogButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dog Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: Provider.of<DogProvider>(context, listen: false).dogName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class _Breed extends StatelessWidget {
  _Breed();

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(
      builder: (ctx, dogProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dog Breed',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            children: [
              ...DogBreeds.values.map(
                (dogBreeds) => _toggleButton(
                  active: dogProvider.breed == dogBreeds,
                  onPressed: () => dogProvider.breed = dogBreeds,
                  child: Text(
                    _resolveButtonLabel(dogBreeds),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _resolveButtonLabel(DogBreeds value) {
    switch (value) {
      case DogBreeds.beagle:
        return 'Beagle';
      case DogBreeds.bulldog:
        return 'Bull Dog';
      case DogBreeds.goldie:
        return 'Golden Retriever';
        throw StateError('Invalid value: $value');
    }
  }

  Widget _toggleButton({bool active, VoidCallback onPressed, Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: Colors.white,
        color: active ? Colors.blue : Colors.grey,
        child: child,
      ),
    );
  }
}

class _AddDogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          Provider.of<DogProvider>(context, listen: false).insertDog();
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('CREATE DOG'),
      ),
    );
  }
}
