import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
class Coupinos_Model   {
  final List<ContactPerson>? contactPerson;
  final List<Address>? address;
  final List<TariffDetails> tariffDetails;
  final String? status;
  final String? id;
  final String? creationDate;

  Coupinos_Model({required this.contactPerson,
    required this.address,
    required this.tariffDetails,
    required this.status,
    required this.id,
    required this.creationDate
  });


  factory Coupinos_Model.fromJson(Map<String, dynamic> json) =>
      Coupinos_Model(
          contactPerson: json['contactPerson'] == null
              ? []
              : (json['contactPerson'] as List<dynamic>)
              .map((e) => ContactPerson.fromJson(e))
              .toList(),
          address: json['address'] == null
              ? []
              : (json['address'] as List<dynamic>)
              .map((e) => Address.fromJson(e))
              .toList(),
          tariffDetails: json['tariffDetails'] == null
              ? []
              : (json['tariffDetails'] as List<dynamic>)
              .map((e) => TariffDetails.fromJson(e))
              .toList(),
          status: json['status'] as String? ?? '',
          id: json['_id'] as String? ?? '',
          creationDate: json['creationDate'] as String? ?? '');

}

class ContactPerson {
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dob;
  final String? gender;
  final String? profilePic;

  ContactPerson({required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.profilePic
  });

  factory ContactPerson.fromJson(Map<String, dynamic> json) =>
      ContactPerson(firstName: json['firstName'] as String? ?? '',
          lastName: json['lastName'] as String? ?? '',
          email: json['email'] as String? ?? '',
          dob: DateTime.parse(json['dob']),
          gender: json['gender'] as String? ?? '',
          profilePic: json['profilePic'] as String? ?? '');
}

class Address {
  final String? street;
  final String? postalCode;
  final String? city;
  final String? country;
  final String? addressValidationCode;

  Address({required this.street,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.addressValidationCode});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(street: json['street'] as String? ?? '',
          postalCode: json['postalCode'] as String? ?? '',
          city: json['city'] as String? ?? '',
          country: json['country'] as String? ?? '',
          addressValidationCode: json['addressValidationCode'] as String? ?? '');
}

class TariffDetails {
  final String? startDate;
  final int? duration;
  final int? maxCoupinoCount;
  final int? maxLocationCount;

  TariffDetails({required this.startDate,
    required this.duration,
    required this.maxCoupinoCount,
    required this.maxLocationCount});

  factory TariffDetails.fromJson(Map<String, dynamic> json) =>
      TariffDetails(startDate: json['startDate'] as String? ?? '',
          duration: json['duration'] as int? ?? 0,
          maxCoupinoCount: json['maxCoupinoCount'] as int? ?? 0,
          maxLocationCount: json['maxLocationCount'] as int? ?? 0);
}

