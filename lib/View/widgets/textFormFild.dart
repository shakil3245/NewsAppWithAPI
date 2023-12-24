import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFilds extends StatelessWidget {
  const TextFormFilds({
    super.key,
    required TextEditingController nameController, required this.validateString, required this.hinTextString, required this.lebelTextString,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final String validateString;
  final String hinTextString;
  final String lebelTextString;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      validator: (value){
        if(value!.isEmpty){
          return validateString;
        }
      },
      decoration:  InputDecoration(
        hintText: hinTextString,
        labelText: lebelTextString,
        border: const OutlineInputBorder(),
      ),
    );
  }
}