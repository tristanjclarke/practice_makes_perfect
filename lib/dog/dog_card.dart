import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';

class DogCard extends StatelessWidget {
  const DogCard({this.dog});

  final DogModel dog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dog.name),
          Text(dog.breed),
          Text(dog.age),
        ],
      ),
    );
  }
}
