import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yati_portfolio/utils/app_color.dart';
import 'package:yati_portfolio/widgets/presentation/glass_container.dart';
import 'package:yati_portfolio/widgets/animations/staggered_animation_column.dart';

class AboutDesktop extends StatefulWidget {
  final double scrollOffset;
  const AboutDesktop({super.key, required this.scrollOffset});

  @override
  State<AboutDesktop> createState() => _AboutDesktopState();
}

class _AboutDesktopState extends State<AboutDesktop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  // Trigger offset for animation
  final double triggerOffset = 550;
  bool _isAnimated = false;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -800, end: -30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AboutDesktop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isAnimated && widget.scrollOffset > triggerOffset) {
      _controller.forward();
      _isAnimated = true;
    } else if (_isAnimated && widget.scrollOffset < triggerOffset) {
      _controller.reverse();
      _isAnimated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
          // Quote Text 1
          Positioned(
            top: 17.h,
            right: 27.5.w,
            child: _buildQuoteText(text: 'Open to New Ideas'),
          ),
          // Quote Text 2
          Positioned(
            top: 30.h,
            right: 4.w,
            child: _buildQuoteText(text: 'Adapt to Changes'),
          ),
          // Quote Text 3
          Positioned(
            top: 65.h,
            right: 32.w,
            child: _buildQuoteText(text: 'Embrace Challenges'),
          ),
          // Quote Text 4
          Positioned(
            top: 70.h,
            right: 8.w,
            child: _buildQuoteText(text: 'Grow Beyond Limits'),
          ),
          // Slide Container
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                top: 33.h,
                left: _slideAnimation.value,
                child: child!,
              );
            },
            child: Container(
              height: 14.h,
              width: 49.w,
              decoration: BoxDecoration(
                color: AppColors.midBrownColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // About Content
          Container(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 6.w,
            ),
            height: screenHeight,
            width: screenWidth / 1.6,
            child: StaggeredAnimationColumn(
              controller: _controller,
              children: [
                Text(
                  'Hello, It\'s Me',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.primaryColor,
                    fontSize: 17.sp, //40
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Horizon',
                  ),
                ),
                Text(
                  'Khin Yati Lin Lai',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.whiteColor,
                    fontSize: 19.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Horizon',
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTextStyle(
                  style: GoogleFonts.lora(
                    color: AppColors.midBrownColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "I'm International Business (First Honor) Student!",
                        speed: const Duration(milliseconds: 60),
                        cursor: '|',
                      ),
                      TypewriterAnimatedText(
                        "I'm English Teacher!",
                        speed: const Duration(milliseconds: 60),
                        cursor: '|',
                      ),
                      TypewriterAnimatedText(
                        "I'm Event Organizer!",
                        speed: const Duration(milliseconds: 60),
                        cursor: '|',
                      ),
                      TypewriterAnimatedText(
                        "I'm Sales And Customer Service Specialist!",
                        speed: const Duration(milliseconds: 60),
                        cursor: '|',
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.midBrownColor,
                  thickness: 4,
                  endIndent: 49.5.w,
                ),
                const SizedBox(height: 20),
                Text(
                  'I enjoy working with people, connecting across cultures, and creating positive experiences in every environment I’m part of. I value communication, patience, teamwork, and understanding others these guide the way I collaborate and build relationships.',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.textColor,
                    fontSize: 12.sp,
                    letterSpacing: 1,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteText({required String text}) {
    return GlassContainer(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.lightBrownColor.withOpacity(0.6),
          AppColors.lightBrownColor.withOpacity(0.4),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Agrandir',
        ),
      ),
    );
  }
}
