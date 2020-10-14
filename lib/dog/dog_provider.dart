import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/model/dog_model.dart';
import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/services/db/database_provider.dart';

class DogProvider extends ChangeNotifier {
  DogProvider();

  final DogModel dogModel = DogModel();

  final TextEditingController _dogName = TextEditingController();
  TextEditingController get dogName => _dogName;

  var _dogs = List<DogModel>();
  UnmodifiableListView<DogModel> get dogs => UnmodifiableListView(_dogs);

  DogBreeds get breed => dogModel.breed;
  set breed(DogBreeds value) {
    dogModel.breed = value;
    notifyListeners();
  }

  final _weekDays = List<WeekDays>();
  List<WeekDays> get weekDays => _weekDays;

  void toggleWeekDays(final WeekDays weekDays) {
    if (_weekDays.contains(weekDays)) {
      _weekDays.remove(weekDays);
    } else {
      _weekDays.add(weekDays);
    }
    notifyListeners();
  }

  void getDogs() {
    DatabaseProvider.db.getDogs().then((dogs) {
      this._dogs = dogs;
      notifyListeners();
    });
  }

  void insertDog() async {
    await DatabaseProvider.db.insertDog(
      DogModel(
        name: _dogName.text,
        breed: breed,
      ),
    );
    getDogs();
  }
}
