import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_provider.dart';
import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/dog/widgets/toggle_button.dart';
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
              SizedBox(height: 20),
              _WeekDays(),
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
                (dogBreeds) => ToggleButton(
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
    }
    throw StateError('Invalid value: $value');
  }
}

class _WeekDays extends StatelessWidget {
  _WeekDays();

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(
      builder: (ctx, dogProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When will you need a doggy sitter?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            children: [
              ...WeekDays.values.map(
                (weekDays) => ToggleButton(
                  active: dogProvider.weekDays.contains(weekDays),
                  onPressed: () => dogProvider.toggleWeekDays(weekDays),
                  child: Text(
                    _resolveButtonLabel(weekDays),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _resolveButtonLabel(WeekDays value) {
    switch (value) {
      case WeekDays.sun:
        return 'Sunday';
      case WeekDays.mon:
        return 'Monday';
      case WeekDays.tue:
        return 'Tuesday';
      case WeekDays.wed:
        return 'Wednesday';
      case WeekDays.thu:
        return 'Thursday';
      case WeekDays.fri:
        return 'Friday';
      case WeekDays.sat:
        return 'Saturday';
    }
    throw StateError('Invalid value: $value');
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
