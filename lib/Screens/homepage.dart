import 'package:apitest/Model/usermodel.dart';
import 'package:apitest/Screens/userdetails.dart';
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
        title: const Text('Random People'),
      ),

      body: users.isEmpty
        ? const Center(
          child: CircularProgressIndicator()
        )
        : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          final user = users[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetails(user: user),
                  ),
              );
            },
            child: Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    user.pic.thumbnail,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(user.fullName),
                subtitle: Text(user.email)
              //tileColor: color,
                      ),
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

