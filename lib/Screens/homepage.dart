import 'package:apitest/Model/usermodel.dart';
import 'package:apitest/Service/apiservice.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <UserModel> users = [];

  @override
  void initState(){
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Rest API Calls'),
      ),

      body: users.isEmpty
        ? const Center(
          child: CircularProgressIndicator()
        )
        : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          final user = users[index];
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
              ),
              title: Text(user.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Email: ${user.email}"),
                  Text("Phone: ${user.phone}"),
                  Text("Address: ${user.fullAddress}"),
                  Text("Age: ${user.dob.age}"),
                  Text("Date of Birth: ${user.fullDOB}"),


                ],
              )
            //tileColor: color,
                    ),
          );
      }),
    );
  }

  Future <void> fetchUsers() async {
    try{
      final response = await UserAPI.fetchUsers();
      setState(() {
        users = response;
      });
    } catch(e) {
      print('Error fetching users: $e');
    }
  }
}

