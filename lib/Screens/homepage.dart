import 'package:apitest/Controller/patientcontroller.dart';
import 'package:apitest/Model/patientmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String clinicId;
  final String userId;
  final String patientId;

  const HomePage({
    super.key,
    required this.userId,
    required this.clinicId,
    required this.patientId,
  });

  @override
  State<HomePage> createState() {
    return _HomePageState(
      userId: userId,
      clinicId: clinicId,
      patientId: patientId,
    );
  }
}

class _HomePageState extends State<HomePage> {
  String userId, clinicId,patientId;
  String searchQuery = '';
  bool isSearching = false;
  bool showDialogFlag = false;

  List<ListPatientModel> filteredPatients = [];

  _HomePageState({
    required this.clinicId,
    required this.userId,
    required this.patientId,
  });

  final PatientController = Get.put(patientController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("API Test"),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          FutureBuilder<Map<String, dynamic>?>(
            future: PatientController.listpatient(userId, clinicId),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Oops, no internet'),
                    ),
                  );
                }
                if (snapshot.data == null) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Data is null'),
                    ),
                  );
                }
                final Map<String, dynamic> data = snapshot.data!;
                ListPatientModel user = data['user'];
                return ListView.builder(
                  itemCount: isSearching
                      ? filteredPatients.length
                      : user.result!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(user.result!.length);
                    final patient = isSearching
                        ? filteredPatients[index]
                        : user.result![index];
                    return Container(
                      child: InkWell(
                        onLongPress: (){

                        },
                        onTap: () {

                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      child: Container(
                                        color: Colors.blue,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            user.result![index]
                                                .patientName![0]
                                                .toUpperCase(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.result![index].patientName
                                          .toString()),
                                      Text(user.result![index].mobileNo
                                          .toString()),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  child: const LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(0, 191, 225, 1),
                    valueColor: AlwaysStoppedAnimation(
                      Color.fromRGBO(135, 206, 235, 1),
                    ),
                    minHeight: 5,
                  ),
                );
              }
            },
          ),


        ],
      ),
    );
  }
}
