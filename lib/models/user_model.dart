import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.userName,
      this.email,
      this.address,
      this.gender,
      this.mobileNumber,
      this.userReference,
      this.userType,
      this.image});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) => UserModel(
      userName: doc['userName'],
      email: doc['email'],
      mobileNumber: doc['mobileNumber'],
      address: doc['address'],
      userReference: doc.reference,
      gender: doc['gender'],
      userType: doc['userType']);

  Map<String, dynamic> toMap() => {
        'image': image,
        'userName': userName,
        'email': email,
        'gender': gender,
        'mobileNumber': mobileNumber,
        'address': address,
        'userType': userType
      };
  String? image;
  String? userType;
  String? userName;

  String? gender;
  String? mobileNumber;
  String? email;
  String? address;
  DocumentReference? userReference;
}
