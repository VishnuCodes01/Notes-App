import 'package:crud_note_app/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Employee',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Form',
                style: TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 26.0,
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
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 20.0),
                  const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 26.0,
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
                  const SizedBox(height: 60.0),
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
                          String Id = randomAlphaNumeric(10);
                          Map<String, dynamic> empolyeeInfoMap = {
                            "id": Id,
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Location": locationController.text,
                          };
                          await DatabaseMethods()
                              .addEmployeeDetails(empolyeeInfoMap, Id)
                              .then(
                            (value) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Empolyee Details has been Added Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          );
                        },
                        child: const Text(
                          'ADD',
                          style: TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
