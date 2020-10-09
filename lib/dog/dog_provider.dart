import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';
import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/services/db/database_provider.dart';

class DogProvider extends ChangeNotifier {
  var _dogs = List<DogModel>();

  final TextEditingController _dogName = TextEditingController();
  TextEditingController get dogName => _dogName;

  UnmodifiableListView<DogModel> get dogs => UnmodifiableListView(_dogs);

  void getDogs() {
    DatabaseProvider.db.getDogs().then((dogs) {
      this._dogs = dogs;
      notifyListeners();
    });
  }

  void insertDog({String name, String breed}) async {
    await DatabaseProvider.db.insertDog(
      DogModel(
        name: _dogName.text,
      ),
    );
    getDogs();
  }

  DogModel dogModel;

  DogBreeds get breed => dogModel.breed;
  set breed(DogBreeds value) {
    dogModel.breed = value;
    notifyListeners();
  }
}
