import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/services/db/database_keys.dart';

const _columnId = 'id';
const _columnName = 'name';
const _columnBreed = 'breed';

class DogModel {
  DogModel({this.id, this.name, this.breed});

  int id;
  String name;
  DogBreeds breed = DogBreeds.goldie;
  List<DogModel> dogs;

  DogModel.fromMap(Map<String, dynamic> map) {
    id = map[_columnId] as int;
    name = map[_columnName] as String;
    breed = map[_columnBreed] as DogBreeds;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnId: id,
      _columnName: name,
      _columnBreed: breed,
    };
    return map;
  }

  static const createDogTableString = '''
         CREATE TABLE ${DBKeys.tableDogs} (
            $_columnId INT PRIMARY KEY,
            $_columnName TEXT,
            $_columnBreed TEXT
          )''';
}
