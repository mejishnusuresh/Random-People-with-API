import 'package:apitest/Model/usermodel.dart';
import 'package:flutter/material.dart';
class UserPicView extends StatelessWidget {
  final UserModel user;

  const UserPicView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Pic'),
        ),
        body:Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: Image.network(
                user.pic.large,
                width: 400,
                height: 380,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )

    );
  }
}
