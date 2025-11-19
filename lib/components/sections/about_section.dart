import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yati_portfolio/utils/app_color.dart';
import 'package:yati_portfolio/widgets/glass_container.dart';
import 'package:yati_portfolio/widgets/staggered_animation_column.dart';

class AboutSection extends StatefulWidget {
  final double scrollOffset;
  const AboutSection({super.key, required this.scrollOffset});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
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
  void didUpdateWidget(covariant AboutSection oldWidget) {
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
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Stack(
        children: [
          // Quote Text 1
          Positioned(
            top: 160,
            right: 440,
            child: _buildQuoteText(text: 'Open to New Ideas'),
          ),
          // Quote Text 2
          Positioned(
            top: 250,
            right: 60,
            child: _buildQuoteText(text: 'Adapt to Changes'),
          ),
          // Quote Text 4
          Positioned(
            top: 550,
            right: 120,
            child: _buildQuoteText(text: 'Grow Beyond Limits'),
          ),
          // Slide Container
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                top: 246,
                left: _slideAnimation.value,
                child: child!,
              );
            },
            child: Container(
              height: 120,
              width: 760,
              decoration: BoxDecoration(
                color: AppColors.midBrownColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // About Content
          Container(
            padding: const EdgeInsets.only(left: 100, right: 150),
            height: screenSize.height,
            width: screenSize.width / 1.6,
            child: StaggeredAnimationColumn(
              controller: _controller,
              children: [
                const Text(
                  'Hello, It\'s Me',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.primaryColor,
                    fontSize: 40,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Horizon',
                  ),
                ),
                const Text(
                  'Khin Yati Lin Lai',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.whiteColor,
                    fontSize: 45,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Horizon',
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTextStyle(
                  style: GoogleFonts.lora(
                    color: AppColors.midBrownColor,
                    fontSize: 30,
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
                const Divider(
                  color: AppColors.midBrownColor,
                  thickness: 4,
                  endIndent: 666,
                ),
                const SizedBox(height: 20),
                const Text(
                  'I enjoy working with people, connecting across cultures, and creating positive experiences in every environment I’m part of. I value communication, patience, teamwork, and understanding others these guide the way I collaborate and build relationships.',
                  style: TextStyle(
                    height: 1,
                    color: AppColors.textColor,
                    fontSize: 16,
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
