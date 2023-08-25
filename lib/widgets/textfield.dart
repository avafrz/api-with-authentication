import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  
  String labelText;
  String hintText;
  String? Function(String?)? validation;

  TextFieldWidget(this.labelText, this.hintText,this.controller,this.validation,);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 12,),
      child: TextFormField(
        validator: validation,
        controller:controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              width: 3,
              color: Colors.blue,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              width: 3,
              color: Colors.blue,
            ),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
