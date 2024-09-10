import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> empolyeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(id)
        .set(empolyeeInfoMap);
  }
}
