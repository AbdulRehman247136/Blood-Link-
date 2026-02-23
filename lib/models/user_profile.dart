import '../core/enums.dart';

class UserProfile {
  final String id;
  final String name;
  final String bloodType;
  final String? email;
  final String? phone;
  final String? city;
  final UserType role;
  final int totalDonations;
  final int livesSaved;
  final DateTime? lastDonationDate;
  final bool isEligible;

  const UserProfile({
    required this.id,
    required this.name,
    required this.bloodType,
    this.email,
    this.phone,
    this.city,
    this.role = UserType.donor,
    required this.totalDonations,
    required this.livesSaved,
    this.lastDonationDate,
    required this.isEligible,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join().toUpperCase();

  bool get isGuest => role == UserType.guest;
  bool get isAdmin => role == UserType.admin;

  factory UserProfile.guest() {
    return const UserProfile(
      id: 'guest',
      name: 'Guest',
      bloodType: 'Unknown',
      role: UserType.guest,
      totalDonations: 0,
      livesSaved: 0,
      isEligible: false,
    );
  }
}
