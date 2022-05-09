import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person_rounded,
        size: 50.0,
        color: Colors.blue,
      ),
      radius: 50.0,
    );
  }
}
