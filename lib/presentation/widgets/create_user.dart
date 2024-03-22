import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzapppfe/constants.dart';

class CreateUser extends StatelessWidget {
  final TextEditingController userNameController;

  const CreateUser(
      {super.key,
      required this.userNameController,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                decoration: BoxDecoration(
                  color: lightBlue,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'Entre un pseudo',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                    hintStyle: TextGlobalStyle.buttonStyleWhite,
                  ),
                  style: TextGlobalStyle.buttonStyleWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
