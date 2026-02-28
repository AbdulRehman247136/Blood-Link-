enum UserType { guest, donor, admin }

enum NotificationType { urgent, confirmed, nearby, eligible, appreciation }

enum BloodRequestStatus { pending, fulfilled, cancelled }

enum BloodType {
  oPositive,
  oNegative,
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative;

  String get displayName {
    switch (this) {
      case BloodType.oPositive:
        return 'O+';
      case BloodType.oNegative:
        return 'O-';
      case BloodType.aPositive:
        return 'A+';
      case BloodType.aNegative:
        return 'A-';
      case BloodType.bPositive:
        return 'B+';
      case BloodType.bNegative:
        return 'B-';
      case BloodType.abPositive:
        return 'AB+';
      case BloodType.abNegative:
        return 'AB-';
    }
  }
}

enum UrgencyLevel {
  low,
  medium,
  emergency;

  String get displayName {
    switch (this) {
      case UrgencyLevel.low:
        return 'Low';
      case UrgencyLevel.medium:
        return 'Medium';
      case UrgencyLevel.emergency:
        return 'Emergency';
    }
  }
}
