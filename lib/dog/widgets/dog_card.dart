import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/model/dog_model.dart';

class DogCard extends StatelessWidget {
  const DogCard({this.dog});

  final DogModel dog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.blue,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dog.name == '' ? 'Oopsie I forgot my name...' : '${dog.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Breed: ${dog.breed}'.replaceAll('DogBreeds.', ''),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
