import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16.0);
    
    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: radius,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.0,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: content,
        ),
      ),
    );
  }
}

class GoldGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GoldGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.0);
    
    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: radius,
        border: Border.all(
          color: AppColors.islamicGold.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.islamicGold.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: content,
        ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const GlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.width,
    this.height = 50.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0);
    final buttonColor = color ?? AppColors.primaryTeal.withOpacity(0.8);
    
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: onPressed == null ? Colors.grey.withOpacity(0.3) : buttonColor,
            borderRadius: radius,
            border: Border.all(
              color: AppColors.glassBorder,
              width: 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: radius,
              onTap: onPressed,
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}