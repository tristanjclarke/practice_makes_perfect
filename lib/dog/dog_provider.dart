import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';
import 'package:practice_makes_perfect/services/db/database_provider.dart';

class DogProvider extends ChangeNotifier {
  var _dogs = List<DogModel>();

  UnmodifiableListView<DogModel> get dogs => UnmodifiableListView(_dogs);

  void getDogs() {
    DatabaseProvider.db.getDogs().then((dogs) {
      this._dogs = dogs;
      notifyListeners();
    });
  }

  void insertDog({String name, String breed, String age}) async {
    await DatabaseProvider.db.insertDog(
      DogModel(
        name: name,
        breed: breed,
        age: age,
      ),
    );
    getDogs();
  }
}
