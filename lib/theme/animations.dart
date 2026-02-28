import 'package:flutter/material.dart';

/// Production-ready animation duration and curve system for Blood Bank App
/// Ensures consistent, performant animations across the app
/// Follows Material Design motion guidelines

class AppAnimations {
  // Animation durations (in milliseconds)

  // Quick animations (feedback)
  static const Duration quickest = Duration(milliseconds: 50);
  static const Duration quick = Duration(milliseconds: 100);

  // Standard animations (UI transitions)
  static const Duration short = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 400);

  // Extended animations (complex sequences)
  static const Duration lengthyShort = Duration(milliseconds: 500);
  static const Duration lengthy = Duration(milliseconds: 600);
  static const Duration lengthy2x = Duration(milliseconds: 800);

  // Background animations (long-running, subtle)
  static const Duration backgroundSlow = Duration(milliseconds: 1000);
  static const Duration backgroundVSlow = Duration(milliseconds: 2000);
  static const Duration backgroundExtended = Duration(milliseconds: 3000);

  // Specific feature animations
  static const Duration emergencyPulse = Duration(milliseconds: 600); // 0.6s
  static const Duration bloodParticle = Duration(
    milliseconds: 400,
  ); // 0.4s for particle drift
  static const Duration heartbeat = Duration(
    milliseconds: 800,
  ); // 0.8s for heartbeat
  static const Duration pageTransition = Duration(
    milliseconds: 300,
  ); // 0.3s page slide
  static const Duration buttonRipple = Duration(
    milliseconds: 200,
  ); // Material ripple
  static const Duration cardFlip = Duration(
    milliseconds: 500,
  ); // Card flip animation
  static const Duration shimmer = Duration(
    milliseconds: 1500,
  ); // Loading shimmer
  static const Duration fadeInOut = Duration(
    milliseconds: 250,
  ); // Fade transitions
  static const Duration slideIn = Duration(
    milliseconds: 300,
  ); // Slide animations
  static const Duration scaleIn = Duration(
    milliseconds: 200,
  ); // Scale animations
  static const Duration rotateIn = Duration(
    milliseconds: 300,
  ); // Rotation animations

  // Delay timings
  static const Duration delayNone = Duration.zero;
  static const Duration delaySmall = Duration(milliseconds: 50);
  static const Duration delayMedium = Duration(milliseconds: 100);
  static const Duration delayLarge = Duration(milliseconds: 200);
  static const Duration delayExtraLarge = Duration(milliseconds: 400);

  // Stagger delays (for sequential animations)
  static const Duration staggerSmall = Duration(milliseconds: 50);
  static const Duration staggerMedium = Duration(milliseconds: 100);
  static const Duration staggerLarge = Duration(milliseconds: 150);

  // Easing curves (Material Design 3)

  /// Standard curve: ease-out
  /// Used for: Entrances, content changes
  /// Formula: cubic-bezier(0.2, 0, 0, 1)
  static const Curve easeOutCurve = Cubic(0.2, 0, 0, 1);

  /// Emphasized curve: emphasized easing
  /// Used for: Important transitions, focus changes
  /// Formula: cubic-bezier(0.2, 0, 0, 1) (entrance)
  static const Curve emphasizedCurve = Cubic(0.2, 0, 0, 1);

  /// Standard curve slow: ease-out slower
  /// Used for: Large elements, complex transitions
  static const Curve easeOutSlowCurve = Cubic(0.33, 0.66, 0.66, 1);

  /// Decelerate curve (ease-out)
  static const Curve decelerateCurve = Cubic(0.0, 0.0, 0.2, 1.0);

  /// Accelerate curve (ease-in)
  static const Curve accelerateCurve = Cubic(0.8, 0.0, 1.0, 1.0);

  /// Linear curve (no easing)
  static const Curve linearCurve = Curves.linear;

  /// Elastic ease-out
  static const Curve elasticOutCurve = Curves.elasticOut;

  /// Bounce ease-out
  static const Curve bounceOutCurve = Curves.bounceOut;

  /// Custom curves for specific animations

  // Blood particle drift curve
  static const Curve bloodParticleCurve = Cubic(0.34, 1.56, 0.64, 1);

  // Emergency pulse ease curve
  static const Curve emergencyEaseCurve = Cubic(0.4, 0.0, 0.2, 1.0);

  // Heartbeat curve
  static const Curve heartbeatCurve = Curves.easeInOut;

  // Page transition curve
  static const Curve pageTransitionCurve = Cubic(0.25, 0.46, 0.45, 0.94);

  // Button press curve
  static const Curve buttonPressCurve = Cubic(0.4, 0.0, 0.2, 1.0);

  // Card hover curve
  static const Curve cardHoverCurve = Cubic(0.25, 0.46, 0.45, 0.94);

  // Shimmer loading curve
  static const Curve shimmerCurve = Curves.linear;

  // Fade curve
  static const Curve fadeCurve = Cubic(0.4, 0.0, 0.2, 1.0);

  // Scale curves
  static const Curve scaleInCurve = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Curve scaleOutCurve = Cubic(0.4, 0.0, 0.2, 1.0);

  // Rotation curves
  static const Curve rotateInCurve = Cubic(0.2, 0.0, 0.0, 1.0);

  /// Get animation duration based on context
  static Duration getDuration({
    required AnimationType type,
    bool isReduced = false, // For accessibility (prefers-reduced-motion)
  }) {
    if (isReduced) {
      return const Duration(milliseconds: 50); // Minimal animation
    }

    switch (type) {
      case AnimationType.feedback:
        return quick;
      case AnimationType.standard:
        return standard;
      case AnimationType.complex:
        return medium;
      case AnimationType.longRunning:
        return lengthy;
      case AnimationType.emergency:
        return emergencyPulse;
      case AnimationType.pageTransition:
        return pageTransition;
      default:
        return standard;
    }
  }

  /// Get curve based on animation type
  static Curve getCurve(AnimationType type) {
    switch (type) {
      case AnimationType.entrance:
        return easeOutCurve;
      case AnimationType.exit:
        return accelerateCurve;
      case AnimationType.emphasis:
        return emphasizedCurve;
      case AnimationType.emergency:
        return emergencyEaseCurve;
      case AnimationType.elastic:
        return elasticOutCurve;
      case AnimationType.pageTransition:
        return pageTransitionCurve;
      default:
        return linearCurve;
    }
  }

  /// Stagger delay for sequential animations
  static Duration getStaggerDelay(
    int index, {
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return Duration(milliseconds: delay.inMilliseconds * index);
  }
}

/// Animation type enumeration
enum AnimationType {
  feedback, // Quick user feedback
  standard, // Standard UI transitions
  complex, // Complex multi-step animations
  longRunning, // Background animations
  entrance, // Elements appearing
  exit, // Elements disappearing
  emphasis, // Emphasized transitions
  emergency, // Emergency state changes
  elastic, // Elastic/bouncy effects
  pageTransition, // Page route transitions
}

/// Animation timing configuration
class AnimationTiming {
  final Duration duration;
  final Curve curve;
  final Duration delay;

  const AnimationTiming({
    required this.duration,
    this.curve = Curves.easeInOut,
    this.delay = Duration.zero,
  });

  /// Standard entrance animation
  static const AnimationTiming entrance = AnimationTiming(
    duration: AppAnimations.standard,
    curve: AppAnimations.easeOutCurve,
  );

  /// Standard exit animation
  static const AnimationTiming exit = AnimationTiming(
    duration: AppAnimations.short,
    curve: AppAnimations.accelerateCurve,
  );

  /// Emphasis/focus change
  static const AnimationTiming emphasis = AnimationTiming(
    duration: AppAnimations.medium,
    curve: AppAnimations.emphasizedCurve,
  );

  /// Emergency alert animation
  static const AnimationTiming emergency = AnimationTiming(
    duration: AppAnimations.emergencyPulse,
    curve: AppAnimations.emergencyEaseCurve,
  );

  /// Page transition
  static const AnimationTiming pageTransition = AnimationTiming(
    duration: AppAnimations.pageTransition,
    curve: AppAnimations.pageTransitionCurve,
  );

  /// Card flip
  static const AnimationTiming cardFlip = AnimationTiming(
    duration: AppAnimations.cardFlip,
    curve: Curves.easeInOut,
  );

  /// Button press
  static const AnimationTiming buttonPress = AnimationTiming(
    duration: AppAnimations.quick,
    curve: AppAnimations.buttonPressCurve,
  );

  /// Heartbeat pulse
  static const AnimationTiming heartbeat = AnimationTiming(
    duration: AppAnimations.heartbeat,
    curve: AppAnimations.heartbeatCurve,
  );

  /// Create custom animation timing
  static AnimationTiming custom({
    required Duration duration,
    Curve curve = Curves.easeInOut,
    Duration delay = Duration.zero,
  }) {
    return AnimationTiming(duration: duration, curve: curve, delay: delay);
  }

  /// Accessibility-reduced variant
  AnimationTiming withAccessibilityReduction() {
    return AnimationTiming(
      duration: const Duration(milliseconds: 50),
      curve: Curves.linear,
      delay: Duration.zero,
    );
  }
}
