import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class SkillsetSection extends StatefulWidget {
  final double scrollOffset;
  const SkillsetSection({super.key, required this.scrollOffset});

  @override
  State<SkillsetSection> createState() => _SkillsetSectionState();
}

class _SkillsetSectionState extends State<SkillsetSection> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/skill_section_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Key Strengths & Abilities',
            style: TextStyle(
              color: AppColors.darkBrownColor,
              fontSize: 50,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              fontFamily: 'Borsok',
            ),
          ),
          const Divider(
            color: AppColors.darkBrownColor,
            thickness: 4,
            indent: 600,
            endIndent: 600,
          ),
          const SizedBox(height: 40),
          // Segmented Buttons
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.whiteColor.withOpacity(0.4),
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(8),
                  thumbColor: AppColors.midBrownColor,
                  groupValue: _selectedSegment,
                  onValueChanged: (value) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  },
                  children: <dynamic, Widget>{
                    0: _buildCustomText('Languages', 0),
                    1: _buildCustomText('Professional Skills', 1),
                    2: _buildCustomText('Soft Skills', 2),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomText(String text, int index) {
    final isSelected = _selectedSegment == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Text(
        text,
        style: TextStyle(
          color:
              isSelected ? AppColors.lightBrownColor : AppColors.darkBrownColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
