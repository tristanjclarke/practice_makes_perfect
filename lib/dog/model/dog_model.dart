import 'package:practice_makes_perfect/dog/enums.dart';
import 'package:practice_makes_perfect/services/db/database_keys.dart';

const _columnId = 'id';
const _columnName = 'name';
const _columnBreed = 'breed';

class DogModel {
  DogModel({this.id, this.name, this.breed});

  int id;
  String name;
  DogBreeds breed;
  List<WeekDays> weekDays;

  DogModel.fromMap(Map<String, dynamic> map) {
    id = map[_columnId] as int;
    name = map[_columnName] as String;
    breed = DogBreeds.values.firstWhere(
        (type) => type.toString() == map[_columnBreed],
        orElse: () => null);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnId: id,
      _columnName: name,
      _columnBreed: breed.toString(),
    };
    print(map);
    return map;
  }

  static const createDogTableString = '''
         CREATE TABLE ${DBKeys.tableDogs} (
            $_columnId INT PRIMARY KEY,
            $_columnName TEXT,
            $_columnBreed TEXT
          )''';
}
