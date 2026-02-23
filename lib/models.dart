import 'package:flutter/material.dart';

// ============ BLOOD DONOR MODEL ============
class BloodDonor {
  final String id;
  final String name;
  final String bloodType;
  final String lastDonated;
  final String distance;

  const BloodDonor({
    required this.id,
    required this.name,
    required this.bloodType,
    required this.lastDonated,
    required this.distance,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join();
}

// ============ BLOOD CENTER MODEL ============
class BloodCenter {
  final String id;
  final String name;
  final String bloodType;
  final double stockPercent;
  final String? address;
  final String? phone;

  const BloodCenter({
    required this.id,
    required this.name,
    required this.bloodType,
    required this.stockPercent,
    this.address,
    this.phone,
  });
}

// ============ URGENT REQUEST MODEL ============
class UrgentRequest {
  final String id;
  final String requesterName;
  final String hospital;
  final String bloodType;
  final String timeAgo;
  final int units;

  const UrgentRequest({
    required this.id,
    required this.requesterName,
    required this.hospital,
    required this.bloodType,
    required this.timeAgo,
    required this.units,
  });
}

// ============ NOTIFICATION MODEL ============
enum NotificationType { urgent, confirmed, nearby, eligible, appreciation }

class BloodNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String timeAgo;
  final bool isUnread;
  final DateTime timestamp;

  const BloodNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timeAgo,
    this.isUnread = true,
    required this.timestamp,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.urgent:
        return Icons.warning;
      case NotificationType.confirmed:
        return Icons.check_circle;
      case NotificationType.nearby:
        return Icons.location_on;
      case NotificationType.eligible:
        return Icons.favorite;
      case NotificationType.appreciation:
        return Icons.celebration;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.urgent:
        return const Color(0xFFFF5252);
      case NotificationType.confirmed:
        return const Color(0xFF4CAF50);
      case NotificationType.nearby:
        return const Color(0xFF2196F3);
      case NotificationType.eligible:
        return const Color(0xFFFF9800);
      case NotificationType.appreciation:
        return const Color(0xFF9C27B0);
    }
  }
}

// ============ DONATION APPOINTMENT MODEL ============
class DonationAppointment {
  final String id;
  final DateTime date;
  final String hospital;
  final String? notes;
  final bool isConfirmed;

  const DonationAppointment({
    required this.id,
    required this.date,
    required this.hospital,
    this.notes,
    this.isConfirmed = true,
  });
}

// ============ USER PROFILE MODEL ============
class UserProfile {
  final String id;
  final String name;
  final String bloodType;
  final String? email;
  final String? phone;
  final String? city;
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
    required this.totalDonations,
    required this.livesSaved,
    this.lastDonationDate,
    required this.isEligible,
  });

  String get initials =>
      name.split(' ').map((e) => e[0]).take(2).join().toUpperCase();

  String? get daysUntilNextDonation {
    if (lastDonationDate == null) return null;
    final nextEligible = lastDonationDate!.add(const Duration(days: 56));
    final daysLeft = nextEligible.difference(DateTime.now()).inDays;
    return daysLeft > 0 ? '$daysLeft days' : 'Now';
  }
}
