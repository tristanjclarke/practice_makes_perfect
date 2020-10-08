import 'package:flutter/material.dart';
import 'package:practice_makes_perfect/dog/dog_model.dart';
import 'package:practice_makes_perfect/dog/dog_provider.dart';
import 'package:provider/provider.dart';

class AddDog extends StatelessWidget {
  TextEditingController dogName = TextEditingController();
  TextEditingController dogBreed = TextEditingController();
  TextEditingController dogAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: dogName,
              ),
              TextFormField(
                controller: dogBreed,
              ),
              TextFormField(
                controller: dogAge,
              ),
              Expanded(child: SizedBox.shrink()),
              Center(
                child: FlatButton(
                  onPressed: () {
                    Provider.of<DogProvider>(context, listen: false).insertDog(
                        name: dogName.text,
                        breed: dogBreed.text,
                        age: dogAge.text);
                    FormState().save();
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  child: Text('CREATE DOG'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
