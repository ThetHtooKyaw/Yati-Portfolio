import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yati_portfolio/utils/app_color.dart';
import 'package:yati_portfolio/widgets/presentation/glass_container.dart';
import '../../models/personal_skills_model.dart';

// To Do
// 1. add above and below different screen transitions
// 2. Text Widget animation on onTap
// 3. text for initial state
class SkillsetSection extends StatefulWidget {
  final double scrollOffset;
  const SkillsetSection({super.key, required this.scrollOffset});

  @override
  State<SkillsetSection> createState() => _SkillsetSectionState();
}

class _SkillsetSectionState extends State<SkillsetSection> {
  final Random _random = Random();
  List<PersonalSkillsModel> _selectedSkills = [];
  int? _selectedSegment;
  String? _selectedSkill;

  final List<String> languages = [
    'Myanmar - Native',
    'English - Advanced',
    'Thai - Basic',
  ];

  final List<String> hardSkills = [
    'Customer Service',
    'Sales & Marketing Support',
    'Event Coordination',
    'Content Creation',
    'Graphic Design',
  ];

  final List<String> softSkills = [
    'Communication Skills',
    'Interpersonal Skills',
    'Team Collaboration',
    'Problem-Solving Skills',
    'Cross-Cultural Understanding',
    'Leadership Skills',
  ];

  void _showSelectedSkills(Size screenSize) {
    // Select the appropriate skills list
    final List<String> skillsList = _selectedSegment == 0
        ? languages
        : _selectedSegment == 1
            ? hardSkills
            : softSkills;

    final usedPositions = <Rect>[];
    const textWidth = 366.0;
    const textHeight = 60.0;
    const minMargin = 30.0;

    setState(() {
      _selectedSkills.clear();

      _selectedSkills = skillsList.map((skill) {
        double top = 0;
        double left = 0;
        bool overlaps;
        int attempts = 0;

        do {
          // Randomly positioning widgets
          top = (screenSize.height * 0.4) +
              _random.nextDouble() * (screenSize.height * 0.4);
          left = (screenSize.width * 0.1) +
              _random.nextDouble() * (screenSize.width * 0.86 - textWidth);

          final newRect = Rect.fromLTWH(left, top, textWidth, textHeight);

          // Check for overlapped widgets
          overlaps = usedPositions.any((r) {
            final verticalDistance = newRect.top > r.bottom
                ? newRect.top - r.bottom // newRect is below r
                : r.top > newRect.bottom
                    ? r.top - newRect.bottom // newRect is above r
                    : 0; // overlapping vertically

            final horizontalDistance = newRect.left > r.right
                ? newRect.left - r.right // newRect is to the right of r
                : r.left > newRect.right
                    ? r.left - newRect.right // newRect is to the left of r
                    : 0; // overlapping horizontally

            return verticalDistance < minMargin &&
                horizontalDistance < minMargin;
          });
          attempts++;
        } while (overlaps && attempts < 1000);

        usedPositions.add(Rect.fromLTWH(left, top, textWidth, textHeight));

        return PersonalSkillsModel(
          name: skill,
          top: top,
          left: left,
        );
      }).toList();
    });
  }

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
      child: Stack(
        children: [
          // Click Animation
          Positioned(
            top: 160,
            left: 620,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _selectedSegment == null ? 1 : 0,
              child: Lottie.asset(
                'assets/animations/swipe.json',
                repeat: true,
                animate: true,
                height: 100,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Display selected skills
          ..._selectedSkills.map((skill) {
            final key = ValueKey(
                '${skill.name}_${skill.left.toStringAsFixed(1)}_${skill.top.toStringAsFixed(1)}');

            final isSelected = _selectedSkill == skill.name;

            return Positioned(
              top: skill.top,
              left: skill.left,
              child: TweenAnimationBuilder<double>(
                key: key,
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: isSelected ? 1.3 : value,
                      curve: Curves.easeOut,
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSkill =
                          (_selectedSkill == skill.name) ? null : skill.name;
                    });
                  },
                  child: GlassContainer(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.lightBrownColor.withOpacity(0.6),
                        AppColors.lightBrownColor.withOpacity(0.4),
                      ],
                    ),
                    child: Text(
                      skill.name,
                      style: const TextStyle(
                        color: AppColors.darkBrownColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Agrandir',
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          // Skillset Content & Segmented Control
          Column(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: AppColors.whiteColor.withOpacity(0.4)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: CupertinoSlidingSegmentedControl<int>(
                      padding: const EdgeInsets.all(8),
                      thumbColor: AppColors.midBrownColor,
                      backgroundColor:
                          AppColors.lightBrownColor.withOpacity(0.2),
                      groupValue: _selectedSegment,
                      onValueChanged: (value) {
                        setState(() {
                          _selectedSegment = value;
                          _selectedSkill = null;
                          _showSelectedSkills(screenSize);
                        });
                      },
                      children: <int, Widget>{
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Agrandir',
        ),
      ),
    );
  }
}
