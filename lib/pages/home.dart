import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_note_app/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Stream? EmployeeStream;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 22.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(13.5),
                      elevation: 5.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(13.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name : " + ds['Name'],
                                    style: const TextStyle(
                                      color: CupertinoColors.systemBlue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      nameController.text = ds["Name"];
                                      ageController.text = ds["Age"];
                                      locationController.text = ds["Location"];
                                      EditEmpolyeeDetails(ds["id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: CupertinoColors.systemGreen,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteEmployeeDetails(ds["id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: CupertinoColors.systemRed,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Age : " + ds['Age'],
                                style: const TextStyle(
                                  color: CupertinoColors.activeOrange,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Location : " + ds['Location'],
                                style: const TextStyle(
                                  color: CupertinoColors.systemBlue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Employee(),
              ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Firebase',
              style: TextStyle(
                color: CupertinoColors.activeOrange,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
            left: 20.0, top: 40.0, right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: allEmployeeDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Future EditEmpolyeeDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.cancel),
                          ),
                          const SizedBox(width: 55.0),
                          const Text(
                            'Edit',
                            style: TextStyle(
                              color: CupertinoColors.activeBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Details',
                            style: TextStyle(
                              color: CupertinoColors.activeOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.person),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      "Age",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemOrange,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.list_number),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.location),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Center(
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orangeAccent.shade100,
                              Colors.blueAccent.shade100
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .transparent, // Make the background transparent
                            elevation: 0, // Remove the shadow
                          ),
                          onPressed: () async {
                            Map<String, dynamic> updateInfo = {
                              "id": id,
                              "Name": nameController.text,
                              "Age": ageController.text,
                              "Location": locationController.text,
                            };
                            await DatabaseMethods()
                                .updateEmployeeDetails(id, updateInfo)
                                .then((value) => Navigator.pop(context));
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
