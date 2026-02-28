import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class ContactDonorScreen extends StatefulWidget {
  final Map<String, dynamic> donor;

  const ContactDonorScreen({super.key, required this.donor});

  @override
  State<ContactDonorScreen> createState() => _ContactDonorScreenState();
}

class _ContactDonorScreenState extends State<ContactDonorScreen> {
  final _messageController = TextEditingController();
  int _selectedContactMethod = 0; // 0 = Call, 1 = Message, 2 = Email

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _callDonor() async {
    final phoneNumber = widget.donor['phone'] ?? '03001234567';
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendMessage() async {
    final phoneNumber = widget.donor['phone'] ?? '03001234567';
    final message = _messageController.text.isEmpty
        ? 'Hi ${widget.donor['name']}, I need your blood type ${widget.donor['type']}. Please contact me ASAP.'
        : _messageController.text;
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _showSuccessDialog('Message sent to ${widget.donor['name']}');
    }
  }

  Future<void> _sendEmail() async {
    final email = widget.donor['email'] ?? 'donor@bloodlink.com';
    final subject = 'Blood Donation Request - ${widget.donor['type']}';
    final body =
        'Dear ${widget.donor['name']},\n\nI am reaching out to request your assistance with blood donation. Your blood type ${widget.donor['type']} is needed urgently.\n\nPlease contact me at your earliest convenience.\n\nThank you,\nBloodLink+ Community';
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject, 'body': body},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _showSuccessDialog('Email sent to ${widget.donor['name']}');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Success', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final donorName = widget.donor['name'] as String;
    final bloodType = widget.donor['type'] as String;
    final distance = widget.donor['distance'] as String;
    final lastDonated = widget.donor['last'] as String;
    final available = widget.donor['available'] as bool;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Donor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Donor Card
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  donorName
                                      .split(' ')
                                      .map((e) => e[0])
                                      .take(2)
                                      .join()
                                      .toUpperCase(),
                                  style: AppTextStyles.heading2.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: available
                                      ? AppColors.success
                                      : AppColors.textMuted,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                donorName,
                                style: AppTextStyles.subtitle1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                available
                                    ? 'Available to donate'
                                    : 'Not available',
                                style: AppTextStyles.caption.copyWith(
                                  color: available
                                      ? Colors.white70
                                      : Colors.white38,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                    AppBorderRadius.circle,
                                  ),
                                ),
                                child: Text(
                                  bloodType,
                                  style: AppTextStyles.badge.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.white.withValues(alpha: 0.1)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _InfoItem(
                          icon: Icons.location_on_rounded,
                          label: 'Distance',
                          value: distance,
                        ),
                        _InfoItem(
                          icon: Icons.event_available_rounded,
                          label: 'Last Donated',
                          value: lastDonated,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Contact Method Selection
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Method', style: AppTextStyles.subtitle2),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _ContactMethodButton(
                        icon: Icons.call_rounded,
                        label: 'Call',
                        isSelected: _selectedContactMethod == 0,
                        onTap: () => setState(() => _selectedContactMethod = 0),
                      ),
                      const SizedBox(width: 12),
                      _ContactMethodButton(
                        icon: Icons.message_rounded,
                        label: 'Message',
                        isSelected: _selectedContactMethod == 1,
                        onTap: () => setState(() => _selectedContactMethod = 1),
                      ),
                      const SizedBox(width: 12),
                      _ContactMethodButton(
                        icon: Icons.email_rounded,
                        label: 'Email',
                        isSelected: _selectedContactMethod == 2,
                        onTap: () => setState(() => _selectedContactMethod = 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Details
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              child: _buildContactContentSection(),
            ),

            const SizedBox(height: 32),

            // Send Button
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.circle,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_selectedContactMethod == 0) {
                      _callDonor();
                    } else if (_selectedContactMethod == 1) {
                      _sendMessage();
                    } else {
                      _sendEmail();
                    }
                  },
                  child: Text(
                    _selectedContactMethod == 0
                        ? 'Call ${donorName.split(' ')[0]}'
                        : _selectedContactMethod == 1
                        ? 'Send Message'
                        : 'Send Email',
                    style: AppTextStyles.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Additional Contact Options
            FadeInUp(
              delay: const Duration(milliseconds: 250),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Additional Options', style: AppTextStyles.subtitle2),
                    const SizedBox(height: 12),
                    _AdditionalOption(
                      icon: Icons.share_rounded,
                      label: 'Share Contact',
                      onTap: () => _showShareDialog(),
                    ),
                    const SizedBox(height: 8),
                    _AdditionalOption(
                      icon: Icons.bookmark_rounded,
                      label: 'Save Donor',
                      onTap: () => _showSaveDonorDialog(),
                    ),
                    const SizedBox(height: 8),
                    _AdditionalOption(
                      icon: Icons.flag_rounded,
                      label: 'Report',
                      onTap: () => _showReportDialog(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactContentSection() {
    if (_selectedContactMethod == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Call Details', style: AppTextStyles.subtitle2),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.phone_in_talk_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white38,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.donor['phone'] ?? '0300-1234567',
                            style: AppTextStyles.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_selectedContactMethod == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Message', style: AppTextStyles.subtitle2),
          const SizedBox(height: 12),
          TextField(
            controller: _messageController,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  'Hi ${widget.donor['name']}, I need your blood type ${widget.donor['type']}. Please contact me ASAP.',
              hintStyle: AppTextStyles.body2.copyWith(color: Colors.white38),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_messageController.text.length}/160 characters',
            style: AppTextStyles.caption.copyWith(color: Colors.white38),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email Details', style: AppTextStyles.subtitle2),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.email_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white38,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.donor['email'] ?? 'donor@bloodlink.com',
                            style: AppTextStyles.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Share Donor', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Share this donor contact with others',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white38),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog('Contact shared successfully');
            },
            child: const Text(
              'Share',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveDonorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Save Donor', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Donor saved to your contacts',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Report Donor',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Thank you for reporting. We will review this shortly.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _ContactMethodButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ContactMethodButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white70,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white38),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.subtitle2.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

class _AdditionalOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AdditionalOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.body2)),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white38,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

