import '../core/enums.dart';

class BloodRequest {
  final String id;
  final String requesterId;
  final String requesterName;
  final String bloodType;
  final String hospital;
  final String city;
  final String urgency; // e.g., "Urgent", "Critical", "Normal"
  final int units;
  final DateTime timestamp;
  final BloodRequestStatus status;
  final String? note;

  const BloodRequest({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.bloodType,
    required this.hospital,
    required this.city,
    required this.urgency,
    required this.units,
    required this.timestamp,
    this.status = BloodRequestStatus.pending,
    this.note,
  });
}
