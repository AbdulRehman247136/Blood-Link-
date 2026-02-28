import 'package:bloodbanks/widgets/blood_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';

import '../constants.dart';
import '../core/enums.dart';

class RequestBloodScreen extends StatefulWidget {
  final bool showAppBar;

  const RequestBloodScreen({super.key, this.showAppBar = true});

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Section 1: Patient & Blood Details
  final _patientNameController = TextEditingController();
  final _ageController = TextEditingController();
  BloodType? _selectedBloodType;
  int _units = 1;
  DateTime? _requiredDate;
  UrgencyLevel _urgency = UrgencyLevel.low;

  // Section 2: Contact Information
  final _requesterNameController = TextEditingController();
  String _relationship = 'Self';
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _emailController = TextEditingController();

  // Section 3: Hospital & Location
  final _hospitalNameController = TextEditingController();
  final _wardController = TextEditingController();
  final _addressController = TextEditingController();
  String _city = 'Karachi';
  double _radius = 20;

  // Section 4: Additional Details
  final _notesController = TextEditingController();
  bool _agreedToTerms = false;
  bool _isSubmitting = false;
  bool _showSuccess = false;

  late AnimationController _glowController;
  late ConfettiController _confettiController;

  final List<String> _relationships = [
    'Self',
    'Father',
    'Mother',
    'Friend',
    'Other',
  ];
  final List<String> _cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Quetta',
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _ageController.dispose();
    _requesterNameController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _emailController.dispose();
    _hospitalNameController.dispose();
    _wardController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _confettiController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _resetFormState() {
    _formKey.currentState?.reset();
    _patientNameController.clear();
    _ageController.clear();
    _requesterNameController.clear();
    _phoneController.clear();
    _altPhoneController.clear();
    _emailController.clear();
    _hospitalNameController.clear();
    _wardController.clear();
    _addressController.clear();
    _notesController.clear();

    _selectedBloodType = null;
    _units = 1;
    _requiredDate = null;
    _urgency = UrgencyLevel.low;
    _relationship = 'Self';
    _city = 'Karachi';
    _radius = 20;
    _agreedToTerms = false;
    _isSubmitting = false;
    _showSuccess = false;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedBloodType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select blood type')),
        );
        return;
      }

      if (_requiredDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select required date')),
        );
        return;
      }

      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept the terms')),
        );
        return;
      }

      setState(() => _isSubmitting = true);

      // Simulate submission
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
        _showSuccess = true;
      });

      _confettiController.play();

      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        if (widget.showAppBar) {
          Navigator.of(context).pop();
        } else {
          setState(_resetFormState);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) {
      return _buildSuccessView();
    }

    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text('Request Blood Donation'),
              centerTitle: true,
              backgroundColor: _urgency == UrgencyLevel.emergency
                  ? AppColors.error
                  : null,
            )
          : null,
      body: Stack(
        children: [
          // Emergency glow background
          if (_urgency == UrgencyLevel.emergency)
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.error.withValues(
                          alpha: 0.1 * _glowController.value,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                // Emergency badge
                if (_urgency == UrgencyLevel.emergency)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'EMERGENCY REQUEST',
                          style: AppTextStyles.subtitle1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection1PatientDetails(),
                        const SizedBox(height: 32),
                        _buildSection2ContactInfo(),
                        const SizedBox(height: 32),
                        _buildSection3HospitalLocation(),
                        const SizedBox(height: 32),
                        _buildSection4AdditionalDetails(),
                        const SizedBox(height: 100), // Space for button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky submit button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: _buildSubmitButton(),
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: (size) {
                final path = Path();
                path.addOval(
                  Rect.fromCircle(center: Offset.zero, radius: size.width / 2),
                );
                return path;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Section 1: Patient & Blood Details
  Widget _buildSection1PatientDetails() {
    return _SectionCard(
      title: 'Patient & Blood Details',
      icon: Icons.person_outline,
      child: Column(
        children: [
          TextFormField(
            controller: _patientNameController,
            decoration: const InputDecoration(
              labelText: 'Patient Full Name *',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Age *',
              prefixIcon: Icon(Icons.cake),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              final age = int.tryParse(value!);
              if (age == null || age < 1 || age > 120) return 'Invalid age';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Blood Type *'),
          const SizedBox(height: 8),
          BloodTypeFilter(
            selectedType: _selectedBloodType,
            onChanged: (type) => setState(() => _selectedBloodType = type),
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Units Required (1-6)'),
          _buildUnitsStepper(),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(
              _requiredDate == null
                  ? 'Select Required Date *'
                  : 'Required: ${_requiredDate!.toLocal().toString().split(' ')[0]}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) setState(() => _requiredDate = date);
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Urgency Level *'),
          const SizedBox(height: 8),
          _buildUrgencySelector(),
        ],
      ),
    );
  }

  // Section 2: Contact Information
  Widget _buildSection2ContactInfo() {
    return _SectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      child: Column(
        children: [
          TextFormField(
            controller: _requesterNameController,
            decoration: const InputDecoration(
              labelText: 'Requester Name *',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _relationship,
            decoration: const InputDecoration(
              labelText: 'Relationship to Patient *',
              prefixIcon: Icon(Icons.people),
              border: OutlineInputBorder(),
            ),
            items: _relationships.map((rel) {
              return DropdownMenuItem(value: rel, child: Text(rel));
            }).toList(),
            onChanged: (value) => setState(() => _relationship = value!),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Phone Number *',
              prefixIcon: Icon(Icons.phone),
              prefixText: '+92 ',
              border: OutlineInputBorder(),
              helperText: 'Enter 10 digit number',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (value!.length < 10) return 'Invalid phone number';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _altPhoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Alternate Phone (Optional)',
              prefixIcon: Icon(Icons.phone_android),
              prefixText: '+92 ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email (Optional)',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty && !value.contains('@')) {
                return 'Invalid email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Section 3: Hospital & Location
  Widget _buildSection3HospitalLocation() {
    return _SectionCard(
      title: 'Hospital & Location Details',
      icon: Icons.local_hospital,
      child: Column(
        children: [
          TextFormField(
            controller: _hospitalNameController,
            decoration: const InputDecoration(
              labelText: 'Hospital Name *',
              prefixIcon: Icon(Icons.local_hospital_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _wardController,
            decoration: const InputDecoration(
              labelText: 'Ward / Department (Optional)',
              prefixIcon: Icon(Icons.door_front_door),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Hospital Address *',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _city,
            decoration: const InputDecoration(
              labelText: 'City *',
              prefixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(),
            ),
            items: _cities.map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (value) => setState(() => _city = value!),
          ),
          const SizedBox(height: 16),
          _MapPlaceholderCard(),
          const SizedBox(height: 16),
          _buildFieldLabel('Search Radius: ${_radius.toInt()} km'),
          Slider(
            value: _radius,
            min: 5,
            max: 50,
            divisions: 9,
            label: '${_radius.toInt()} km',
            onChanged: (value) => setState(() => _radius = value),
          ),
        ],
      ),
    );
  }

  // Section 4: Additional Details
  Widget _buildSection4AdditionalDetails() {
    return _SectionCard(
      title: 'Additional Details & Confirmation',
      icon: Icons.note_add,
      child: Column(
        children: [
          TextFormField(
            controller: _notesController,
            maxLength: 200,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Additional Notes (Optional)',
              hintText: 'Any specific requirements or information...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Upload feature coming soon')),
              );
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Medical Proof (Optional)'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _agreedToTerms,
            onChanged: (value) => setState(() => _agreedToTerms = value!),
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(
              'I confirm that the information provided is accurate and this is a genuine blood request.',
              style: TextStyle(fontSize: 13),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 8,
        ),
        child: _isSubmitting
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                'Submit Blood Request',
                style: AppTextStyles.button.copyWith(fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildUnitsStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filled(
          onPressed: _units > 1 ? () => setState(() => _units--) : null,
          icon: const Icon(Icons.remove),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          '$_units ${_units == 1 ? "Unit" : "Units"}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(width: 24),
        IconButton.filled(
          onPressed: _units < 6 ? () => setState(() => _units++) : null,
          icon: const Icon(Icons.add),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildUrgencySelector() {
    return SegmentedButton<UrgencyLevel>(
      segments: [
        ButtonSegment(
          value: UrgencyLevel.low,
          label: const Text('Low'),
          icon: const Icon(Icons.info_outline, size: 18),
        ),
        ButtonSegment(
          value: UrgencyLevel.medium,
          label: const Text('Medium'),
          icon: const Icon(Icons.warning_amber_outlined, size: 18),
        ),
        ButtonSegment(
          value: UrgencyLevel.emergency,
          label: AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                decoration: _urgency == UrgencyLevel.emergency
                    ? BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(
                              alpha: 0.3 + _glowController.value * 0.2,
                            ),
                            blurRadius: 8,
                          ),
                        ],
                      )
                    : null,
                child: child,
              );
            },
            child: const Text('Emergency'),
          ),
          icon: const Icon(Icons.emergency, size: 18, color: Colors.red),
        ),
      ],
      selected: {_urgency},
      onSelectionChanged: (selection) {
        setState(() => _urgency = selection.first);
        if (selection.first == UrgencyLevel.emergency) {
          HapticFeedback.heavyImpact();
        }
      },
    );
  }

  Widget _buildSuccessView() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 80,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Request Submitted!',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'We have notified nearby donors.\nYou will receive updates soon.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.showAppBar) {
                    Navigator.of(context).pop();
                  } else {
                    setState(_resetFormState);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  widget.showAppBar ? 'Back to Home' : 'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widgets

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _MapPlaceholderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 48,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              // GPS location feature placeholder
            },
            icon: const Icon(Icons.my_location),
            label: const Text('Get Current Location'),
          ),
        ],
      ),
    );
  }
}
