import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});
  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  DateTime? selectedDate;
  String? selectedHospital;
  bool _donated = false;

  final hospitals = [
    'Jinnah Hospital, Lahore',
    'Agha Khan, Karachi',
    'CMH Rawalpindi',
    'Liaquat Memorial',
    'Holy Family Hospital',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppBorderRadius.xl),
                bottomRight: Radius.circular(AppBorderRadius.xl),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schedule Donation',
                  style: AppTextStyles.heading2.copyWith(color: Colors.white),
                ),
                Text(
                  'Book your appointment today',
                  style: AppTextStyles.body2.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (_donated)
            _DonationSuccess()
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blood Group Card
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    child: _BloodGroupCard(),
                  ),

                  const SizedBox(height: 20),

                  // Date Selection
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 400),
                    child: Text('Select Date', style: AppTextStyles.subtitle1),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    delay: const Duration(milliseconds: 150),
                    duration: const Duration(milliseconds: 400),
                    child: _PickerTile(
                      icon: Icons.calendar_today_rounded,
                      label: selectedDate == null
                          ? 'Choose a date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.primary,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) setState(() => selectedDate = date);
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Hospital Selection
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 400),
                    child: Text('Select Hospital', style: AppTextStyles.subtitle1),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    delay: const Duration(milliseconds: 250),
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppBorderRadius.md),
                        border: Border.all(color: AppColors.borderColor),
                        boxShadow: AppShadows.card,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedHospital,
                          hint: Text(
                            'Choose a hospital',
                            style: AppTextStyles.body1.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.primary,
                          ),
                          items: hospitals
                              .map((h) => DropdownMenuItem(
                                    value: h,
                                    child: Text(h, style: AppTextStyles.body1),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => selectedHospital = v),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Confirm Button
                  FadeInUp(
                    delay: const Duration(milliseconds: 350),
                    duration: const Duration(milliseconds: 400),
                    child: _GradientButton(
                      label: 'Confirm Appointment',
                      icon: Icons.check_circle_rounded,
                      enabled: selectedDate != null && selectedHospital != null,
                      onTap: () => setState(() => _donated = true),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _BloodGroupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFEBEE), Color(0xFFFFF0F0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: AppShadows.button,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.water_drop_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Blood Group', style: AppTextStyles.body2),
                Text(
                  'O+',
                  style: AppTextStyles.heading2.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(AppBorderRadius.circle),
            ),
            child: Text(
              '✅ Eligible',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PickerTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body1.copyWith(
                  color: label.contains('Choose') ? AppColors.textMuted : AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const _GradientButton({required this.label, required this.icon, required this.enabled, required this.onTap});

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.enabled ? (_) { setState(() => _pressed = false); widget.onTap(); } : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.enabled
                ? AppColors.primaryGradient
                : const LinearGradient(colors: [Color(0xFFBDBDBD), Color(0xFFBDBDBD)]),
            borderRadius: BorderRadius.circular(AppBorderRadius.circle),
            boxShadow: widget.enabled ? AppShadows.button : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(widget.label, style: AppTextStyles.button),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonationSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(milliseconds: 700),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: AppShadows.fab,
              ),
              child: const Icon(Icons.water_drop_rounded, color: Colors.white, size: 52),
            ),
            const SizedBox(height: 24),
            Text('Appointment Booked!', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            Text(
              '🎉 Thank you for saving a life!\nEvery drop counts ❤️',
              textAlign: TextAlign.center,
              style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🏆', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 8),
                Text('🎊', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 8),
                Text('💪', style: TextStyle(fontSize: 28)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
