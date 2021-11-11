import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.userName,
      this.email,
      this.shop,
      this.address,
      this.gender,
      this.mobileNumber,
      this.userReference,
      this.userType,
      this.image});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      UserModel(userName: doc['userName'],
      email: doc['email'],
      mobileNumber: doc['mobileNumber'],
      shop: doc['shop'],
      address: doc['address'],
      gender: doc['gender']
      
      );

  Map<String, dynamic> toMap() => {
        'image': image,
        'userName': userName,
        'email': email,
        'shop': shop,
        'gender': gender,
        'mobileNumber': mobileNumber,
        'address': address,
        'userType': userType
      };
  String? image;
  String? userType;
  String? userName;
  DocumentReference? shop;
  String? gender;
  String? mobileNumber;
  String? email;
  String? address;
  DocumentReference? userReference;
}
