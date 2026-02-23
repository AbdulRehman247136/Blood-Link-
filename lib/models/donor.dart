import '../core/enums.dart';

class Donor {
  final String id;
  final String name;
  final String bloodType;
  final String city;
  final String hospital;
  final bool isVerified;
  final String lastDonated;
  final String distance;
  final String phone;
  final bool isEmergency;

  const Donor({
    required this.id,
    required this.name,
    required this.bloodType,
    required this.city,
    required this.hospital,
    this.isVerified = false,
    required this.lastDonated,
    required this.distance,
    required this.phone,
    this.isEmergency = false,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join().toUpperCase();

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      name: json['name'],
      bloodType: json['bloodType'],
      city: json['city'],
      hospital: json['hospital'],
      isVerified: json['isVerified'] ?? false,
      lastDonated: json['lastDonated'],
      distance: json['distance'],
      phone: json['phone'],
      isEmergency: json['isEmergency'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bloodType': bloodType,
      'city': city,
      'hospital': hospital,
      'isVerified': isVerified,
      'lastDonated': lastDonated,
      'distance': distance,
      'phone': phone,
      'isEmergency': isEmergency,
    };
  }
}
