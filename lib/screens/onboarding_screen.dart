import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int _currentPage = 0;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  final _slides = const [
    _Slide(
      emoji: '🩸',
      title: 'Every Drop\nMatters',
      subtitle:
          'Become a hero. Your blood can save three lives in a single donation.',
    ),
    _Slide(
      emoji: '🏥',
      title: 'Find Blood\nInstantly',
      subtitle:
          'Real-time access to donors and blood banks near you — when seconds matter.',
    ),
    _Slide(
      emoji: '❤️',
      title: 'Welcome\nLifesaver',
      subtitle:
          'Your profile is ready. You are now part of a network that saves lives in real-time. Let\'s set up your first donation availability.',
      isLast: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 1,
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _next() async {
    try {
      if (_currentPage < _slides.length - 1) {
        // Move to next slide
        await _fadeController.reverse();
        if (mounted) {
          setState(() => _currentPage++);
        }
        _fadeController.forward();
      } else {
        // Last slide - navigate to login
        if (mounted) {
          _goToLogin();
        }
      }
    } catch (e) {
      debugPrint('Error in _next: $e');
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, a, b) => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, anim, second, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentPage];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.darkBgGradient),
        child: SafeArea(
          child: Stack(
            children: [
              // Subtle radial glow behind icon
              Positioned(
                top: MediaQuery.of(context).size.height * 0.18,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withAlpha(35),
                          Colors.transparent,
                        ],
                        radius: 0.7,
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                children: [
                  // Skip or Back
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage > 0)
                          IconButton(
                            onPressed: () async {
                              await _fadeController.reverse();
                              if (mounted) {
                                setState(() => _currentPage--);
                              }
                              _fadeController.forward();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white54,
                              size: 20,
                            ),
                          )
                        else
                          const SizedBox(width: 48),
                        TextButton(
                          onPressed: _currentPage < _slides.length - 1
                              ? _goToLogin
                              : null,
                          child: Text(
                            _currentPage < _slides.length - 1 ? 'Skip' : '',
                            style: GoogleFonts.poppins(
                              color: Colors.white38,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Blood Drop Icon — pulsing
                  ScaleTransition(
                    scale: _pulseAnim,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFE53E3E)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(100),
                            blurRadius: 50,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.water_drop_rounded,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),

                  // Decorative dots around icon
                  SizedBox(
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 100,
                          top: 5,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withAlpha(150),
                            ),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width / 2 - 90,
                          top: 3,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withAlpha(100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Text content
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        children: [
                          if (slide.isLast) ...[
                            Text(
                              'Welcome',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Lifesaver ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    height: 1.1,
                                  ),
                                ),
                                const Text(
                                  '🧡',
                                  style: TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                          ] else
                            Text(
                              slide.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          const SizedBox(height: 16),
                          Text(
                            slide.subtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Dots + Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: Column(
                      children: [
                        // Page dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_slides.length, (i) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: i == _currentPage ? 28 : 8,
                              height: 4,
                              decoration: BoxDecoration(
                                color: i == _currentPage
                                    ? AppColors.primary
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 28),

                        // Get Started / Next Button
                        GestureDetector(
                          onTap: _next,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE53E3E), Color(0xFFC0392B)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.circle,
                              ),
                              boxShadow: AppShadows.button,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  slide.isLast ? 'Get Started' : 'Continue',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide {
  final String emoji;
  final String title;
  final String subtitle;
  final bool isLast;
  const _Slide({
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });
}
