import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';
import 'main_screen.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Pulse Icon
              Pulse(
                infinite: true,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: FadeInDown(
                      duration: const Duration(seconds: 1),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primary,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Success Message
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Text(
                  'Registration Successful!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading2,
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Welcome to the community of lifesavers. You can now start donating and requesting blood.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Action Button
              FadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text('Go to Home'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sharing Impact
              FadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 600),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded, size: 18),
                  label: const Text('Share your impact'),
                  style: TextButton.styleFrom(foregroundColor: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

