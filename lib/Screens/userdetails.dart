import 'package:apitest/Model/usermodel.dart';
import 'package:apitest/Screens/userpicview.dart';
import 'package:flutter/material.dart';
class UserDetails extends StatelessWidget {
  final UserModel user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People Details'),
      ),

      body:Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPicView(user: user),
                          ),
                        );
                      },
                      child: ClipRRect(
                        child: Image.network(
                          user.pic.medium,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox( width: 8,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(user.fullName,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Text("Email: ${user.email}"),
                          Text("Phone: ${user.phone}"),
                          Text("Cell: ${user.cell}"),
                          Text("Gender: ${user.gender}"),
                          Text("Address: ${user.loc.street.number}, ${user.loc.street.name}, "),
                          Text("                ${user.loc.city}, ${user.loc.state}"),
                          Text("                ${user.loc.country}, ${user.loc.postcode}"),
                          Text("Nationality: ${user.nat}"),
                          Text("Age: ${user.dob.age}"),
                          Text("Date of Birth: ${user.fullDOB}"),

                        ],
                      ),
                    ),

                  ]
                ),
              ),
      )
    );
  }
}

