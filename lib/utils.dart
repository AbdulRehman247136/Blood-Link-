// Utility functions and extensions for the BloodBanks app

extension StringExtensions on String {
  /// Capitalize the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Check if blood type is valid
  static bool isValidBloodType(String type) {
    const validTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    return validTypes.contains(type);
  }
}

extension IntExtensions on int {
  /// Format large numbers with K, M, B
  String toCompactString() {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    }
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    }
    if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }
}

extension DateTimeExtensions on DateTime {
  /// Get days since this date
  int daysSince() {
    return DateTime.now().difference(this).inDays;
  }

  /// Get human-readable time ago string
  String timeAgoString() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
  }

  /// Format as DD/MM/YYYY
  String toFormattedString() {
    return '$day/$month/$year';
  }

  /// Check if donation is eligible (56 days since last donation)
  bool isDonationEligible() {
    return daysSince() >= 56;
  }
}

/// Blood type compatibility helper
class BloodTypeHelper {
  /// Check if a donor can give to a recipient
  static bool canDonateTo(String donorType, String recipientType) {
    const compatibility = {
      'O-': ['O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+'],
      'O+': ['O+', 'A+', 'B+', 'AB+'],
      'A-': ['A-', 'A+', 'AB-', 'AB+'],
      'A+': ['A+', 'AB+'],
      'B-': ['B-', 'B+', 'AB-', 'AB+'],
      'B+': ['B+', 'AB+'],
      'AB-': ['AB-', 'AB+'],
      'AB+': ['AB+'],
    };

    return compatibility[donorType]?.contains(recipientType) ?? false;
  }

  /// Get safe blood recipients for donor type
  static List<String> getSafeRecipients(String donorType) {
    const compatibility = {
      'O-': ['O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+'],
      'O+': ['O+', 'A+', 'B+', 'AB+'],
      'A-': ['A-', 'A+', 'AB-', 'AB+'],
      'A+': ['A+', 'AB+'],
      'B-': ['B-', 'B+', 'AB-', 'AB+'],
      'B+': ['B+', 'AB+'],
      'AB-': ['AB-', 'AB+'],
      'AB+': ['AB+'],
    };

    return compatibility[donorType] ?? [];
  }
}

/// Validation utilities
class Validators {
  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number (basic Pakistan format)
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+92\d{10}$|^00923\d{9}$|^03\d{9}$');
    return phoneRegex.hasMatch(phone.replaceAll('-', '').replaceAll(' ', ''));
  }

  /// Validate name (minimum 2 characters, only letters and spaces)
  static bool isValidName(String name) {
    return name.trim().length >= 2 && RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);
  }
}

/// Analytics and logging utility for development
///
/// Note: Uses print() intentionally for development logging.
/// In production, consider replacing with a proper logging service
/// like Sentry, Firebase Crashlytics, or FirebaseAnalytics.
class AppLogger {
  // ignore: avoid_print
  static void debug(String message) {
    // ignore: avoid_print
    print('[DEBUG] $message');
  }

  // ignore: avoid_print
  static void info(String message) {
    // ignore: avoid_print
    print('[INFO] $message');
  }

  // ignore: avoid_print
  static void warning(String message) {
    // ignore: avoid_print
    print('[WARNING] $message');
  }

  // ignore: avoid_print
  static void error(String message, [Exception? exception]) {
    // ignore: avoid_print
    print('[ERROR] $message');
    if (exception != null) {
      // ignore: avoid_print
      print('[ERROR] Exception: $exception');
    }
  }
}
