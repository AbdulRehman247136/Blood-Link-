import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';
import '../widgets/blood_filters.dart';
import 'blood_center_detail_screen.dart';

class FindScreen extends StatefulWidget {
  const FindScreen({super.key});

  @override
  State<FindScreen> createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  late TextEditingController _searchController;
  String _searchQuery = '';
  String? _selectedBloodGroup;

  final centers = [
    {
      'name': 'City Hospital',
      'type': 'O+',
      'distance': '0.8 km',
      'status': 'Stable',
    },
    {
      'name': 'Red Cross Center',
      'type': 'B-',
      'distance': '1.2 km',
      'status': 'Critical',
    },
    {
      'name': 'St. John\'s Med',
      'type': 'A+',
      'distance': '2.4 km',
      'status': 'Low',
    },
    {
      'name': 'Metropolitan Clinic',
      'type': 'O-',
      'distance': '3.1 km',
      'status': 'Stable',
    },
    {
      'name': 'General Hospital',
      'type': 'AB+',
      'distance': '4.5 km',
      'status': 'Safe',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply both search and blood group filters
    final filteredCenters = centers.where((center) {
      // Check search query match
      final matchesSearch =
          (center['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (center['type'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      // Check blood group filter
      final matchesBloodGroup =
          _selectedBloodGroup == null ||
          (center['type'] as String) == _selectedBloodGroup;

      // Return true only if both conditions are met
      return matchesSearch && matchesBloodGroup;
    }).toList();

    return Scaffold(
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
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: const Icon(
                      Icons.map_outlined,
                      color: Colors.white70,
                      size: 20,
                    ),
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
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search hospital, city or donor...',
                    hintStyle: AppTextStyles.body2.copyWith(
                      color: Colors.white38,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white38,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: _searchQuery.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white38,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            BloodFilters(
              onSelectionChanged: (selectedGroup) {
                setState(() {
                  _selectedBloodGroup = selectedGroup;
                });
              },
            ),
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
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      filteredCenters.isEmpty
                          ? 'No results found'
                          : '${filteredCenters.length} ${filteredCenters.length == 1 ? 'hospital' : 'hospitals'} found${_selectedBloodGroup != null ? ' for $_selectedBloodGroup' : ''}',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Donors List
            Expanded(
              child: filteredCenters.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            color: Colors.white38,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No donors found',
                            style: AppTextStyles.subtitle1.copyWith(
                              color: Colors.white38,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedBloodGroup != null &&
                                    _searchQuery.isNotEmpty
                                ? 'No results for "$_searchQuery" with blood type $_selectedBloodGroup'
                                : _selectedBloodGroup != null
                                ? 'No donors found for blood type $_selectedBloodGroup'
                                : 'Try a different search term',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white38,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          if (_selectedBloodGroup != null ||
                              _searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _selectedBloodGroup = null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Clear Filters',
                                  style: AppTextStyles.body2.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: filteredCenters.length,
                      itemBuilder: (context, i) {
                        final c = filteredCenters[i];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * i),
                          child: _DonorCard(
                            name: c['name'] as String,
                            type: c['type'] as String,
                            distance: c['distance'] as String,
                            status: c['status'] as String,
                            center: c,
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
  final Map<String, dynamic> center;
  const _DonorCard({
    required this.name,
    required this.type,
    required this.distance,
    required this.status,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Critical') {
      statusColor = AppColors.primary;
    } else if (status == 'Low') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.green;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BloodCenterDetailScreen(center: center),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                  ),
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
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.white38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$distance away',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white38,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: AppTextStyles.caption.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BloodCenterDetailScreen(center: center),
                ),
              ),
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white24,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
