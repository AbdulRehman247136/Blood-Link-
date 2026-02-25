import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';

class RequestBloodScreen extends StatefulWidget {
  const RequestBloodScreen({super.key});
  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final String _selectedBloodType = 'O+';
  int _units = 1;
  final String _urgency = 'Urgent';
  final _hospitalCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  bool _submitted = false;

  final _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final _urgencyLevels = ['Normal', 'Urgent', 'Critical'];

  @override
  void dispose() {
    _hospitalCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Request Blood'),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: _submitted
          ? _SuccessView(
              bloodType: _selectedBloodType,
              units: _units,
              urgency: _urgency,
              hospital: _hospitalCtrl.text,
              onNewRequest: () {
                setState(() {
                  _submitted = false;
                  _hospitalCtrl.clear();
                  _notesCtrl.clear();
                });
              },
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Blood Request',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 24),
                  // Blood Type Selection
                  Text('Select Blood Type', style: AppTextStyles.subtitle1),
                  const SizedBox(height: 12),
                  // Placeholder for blood type selection
                  const SizedBox(height: 24),
                  // Units Selection
                  Text('Units Required', style: AppTextStyles.subtitle1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _CounterButton(
                        icon: Icons.remove_rounded,
                        onTap: _units > 1
                            ? () => setState(() => _units--)
                            : null,
                      ),
                      Expanded(
                        child: Text(
                          '$_units Unit${_units > 1 ? 's' : ''}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading3,
                        ),
                      ),
                      _CounterButton(
                        icon: Icons.add_rounded,
                        onTap: () => setState(() => _units++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Hospital location
                  Text('Hospital Location', style: AppTextStyles.subtitle1),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _hospitalCtrl,
                    decoration: InputDecoration(
                      hintText: 'Enter hospital name/location',
                      prefixIcon: const Icon(Icons.location_on_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Submit Button
                  GestureDetector(
                    onTap: () => setState(() => _submitted = true),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.circle,
                        ),
                        boxShadow: AppShadows.button,
                      ),
                      child: Text(
                        'Submit Request',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// ─── Counter Button ──────────────────────────────────
class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _CounterButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: onTap != null ? AppColors.primaryGradient : null,
          color: onTap != null ? null : const Color(0xFFEEEEEE),
          shape: BoxShape.circle,
          boxShadow: onTap != null ? AppShadows.button : null,
        ),
        child: Icon(
          icon,
          color: onTap != null ? Colors.white : AppColors.textMuted,
          size: 22,
        ),
      ),
    );
  }
}

// ─── Success View ─────────────────────────────────────
class _SuccessView extends StatelessWidget {
  final String bloodType;
  final int units;
  final String urgency;
  final String hospital;
  final VoidCallback onNewRequest;

  const _SuccessView({
    required this.bloodType,
    required this.units,
    required this.urgency,
    required this.hospital,
    required this.onNewRequest,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(milliseconds: 700),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: AppShadows.fab,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 52,
              ),
            ),
            const SizedBox(height: 24),
            Text('Request Sent! 🎉', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            Text(
              'Your request for $units unit(s) of $bloodType blood\nhas been sent to donors near $hospital.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            // Summary row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SummaryItem(label: 'Blood', value: bloodType),
                  _SummaryItem(label: 'Units', value: '$units'),
                  _SummaryItem(label: 'Priority', value: urgency),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: onNewRequest,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppBorderRadius.circle),
                  boxShadow: AppShadows.button,
                ),
                child: Text(
                  'New Request',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.subtitle1.copyWith(color: AppColors.primary),
        ),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
