import 'package:flutter/material.dart';
import '../constants.dart';

class UrgentRequests extends StatefulWidget {
  const UrgentRequests({super.key});
  @override
  State<UrgentRequests> createState() => _UrgentRequestsState();
}

class _UrgentRequestsState extends State<UrgentRequests> {
  final requests = [
    {
      'type': 'O+',
      'name': 'Ahmed Raza',
      'hospital': 'Jinnah Hospital, Lahore',
      'time': '2h ago',
      'units': '2',
    },
    {
      'type': 'B-',
      'name': 'Fatima Zahra',
      'hospital': 'Agha Khan, Karachi',
      'time': '4h ago',
      'units': '1',
    },
    {
      'type': 'A+',
      'name': 'Usman Ali',
      'hospital': 'CMH Rawalpindi',
      'time': '6h ago',
      'units': '3',
    },
  ];

  late List<bool> visible;

  @override
  void initState() {
    super.initState();
    visible = List.filled(requests.length, false);
    for (var i = 0; i < requests.length; i++) {
      Future.delayed(Duration(milliseconds: 120 * i + 600), () {
        if (mounted) setState(() => visible[i] = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: requests.asMap().entries.map((entry) {
          final i = entry.key;
          final r = entry.value;
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 450),
            opacity: visible[i] ? 1 : 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 450),
              offset: visible[i] ? Offset.zero : const Offset(0, 0.08),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _RequestCard(
                  bloodType: r['type']!,
                  requester: r['name']!,
                  hospital: r['hospital']!,
                  timeAgo: r['time']!,
                  units: r['units']!,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _RequestCard extends StatefulWidget {
  final String bloodType, requester, hospital, timeAgo, units;
  const _RequestCard({
    required this.bloodType,
    required this.requester,
    required this.hospital,
    required this.timeAgo,
    required this.units,
  });

  @override
  State<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<_RequestCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        _showDetails(context);
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _pressed ? -2.0 : 0.0, 0.0, 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          boxShadow: _pressed ? AppShadows.cardHeavy : AppShadows.card,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Blood type circle
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.card,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.bloodType,
                  style: AppTextStyles.subtitle2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.requester,
                      style: AppTextStyles.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.hospital,
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.errorLight,
                                borderRadius: BorderRadius.circular(
                                  AppBorderRadius.circle,
                                ),
                              ),
                              child: Text(
                                '⚡ ${widget.units} units',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              widget.timeAgo,
                              style: AppTextStyles.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Respond button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppBorderRadius.circle),
                  boxShadow: AppShadows.button,
                ),
                child: Text(
                  'Help',
                  style: AppTextStyles.badge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBorderRadius.xl),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(widget.requester, style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text(
              widget.hospital,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InfoChip(
                  label: widget.bloodType,
                  icon: Icons.water_drop_rounded,
                ),
                const SizedBox(width: 10),
                _InfoChip(
                  label: '${widget.units} units',
                  icon: Icons.science_rounded,
                ),
                const SizedBox(width: 10),
                _InfoChip(
                  label: widget.timeAgo,
                  icon: Icons.access_time_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call_rounded),
                    label: Text(
                      'Call',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.circle,
                      ),
                      boxShadow: AppShadows.button,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: Text('Respond', style: AppTextStyles.button),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppBorderRadius.circle),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
