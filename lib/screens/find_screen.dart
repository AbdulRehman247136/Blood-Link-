import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';
import '../widgets/blood_filters.dart';

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final centers = [
      {'name': 'City Hospital', 'type': 'O+', 'distance': '0.8 km', 'status': 'Stable'},
      {'name': 'Red Cross Center', 'type': 'B-', 'distance': '1.2 km', 'status': 'Critical'},
      {'name': 'St. John\'s Med', 'type': 'A+', 'distance': '2.4 km', 'status': 'Low'},
      {'name': 'Metropolitan Clinic', 'type': 'O-', 'distance': '3.1 km', 'status': 'Stable'},
      {'name': 'General Hospital', 'type': 'AB+', 'distance': '4.5 km', 'status': 'Safe'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Find Donors', style: AppTextStyles.heading2),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: const Icon(Icons.map_outlined, color: Colors.white70, size: 20),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search hospital, city or donor...',
                    hintStyle: AppTextStyles.body2.copyWith(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            const BloodFilters(),
            const SizedBox(height: 24),
            
            // Results Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text('Nearby Results', style: AppTextStyles.subtitle2),
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text('24 hospitals found', style: AppTextStyles.caption.copyWith(color: Colors.white38)),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Donors List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: centers.length,
                itemBuilder: (context, i) {
                  final c = centers[i];
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * i),
                    child: _DonorCard(
                      name: c['name'] as String,
                      type: c['type'] as String,
                      distance: c['distance'] as String,
                      status: c['status'] as String,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  final String name, type, distance, status;
  const _DonorCard({required this.name, required this.type, required this.distance, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Critical') {
      statusColor = AppColors.primary;
    } else if (status == 'Low') statusColor = Colors.orange;
    else statusColor = Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                type,
                style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.subtitle1),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text('$distance away', style: AppTextStyles.caption.copyWith(color: Colors.white38)),
                    const SizedBox(width: 12),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text(status, style: AppTextStyles.caption.copyWith(color: statusColor)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to request details
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
          ),
        ],
      ),
    );
  }
}
