import 'package:practice_makes_perfect/services/db/database_keys.dart';

const _columnId = 'id';
const _columnName = 'name';
const _columnBreed = 'breed';
const _columnAge = 'age';

class DogModel {
  DogModel({this.id, this.name, this.breed, this.age});

  int id;
  String name;
  String breed;
  String age;
  List<DogModel> dogs;

  DogModel.fromMap(Map<String, dynamic> map) {
    id = map[_columnId] as int;
    name = map[_columnName] as String;
    breed = map[_columnBreed] as String;
    age = map[_columnAge] as String;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnId: id,
      _columnName: name,
      _columnBreed: breed,
      _columnAge: age,
    };
    return map;
  }

  static const createDogTableString = '''
         CREATE TABLE ${DBKeys.tableDogs} (
            $_columnId INT PRIMARY KEY,
            $_columnName TEXT,
            $_columnBreed TEXT,
            $_columnAge TEXT
          )''';
}
