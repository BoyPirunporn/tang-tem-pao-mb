import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final String buttonText;
  final String toggleText;
  final String textSpan;
  final VoidCallback onToggle;
  final List<TextEditingController> controllers;

  const AuthForm({
    super.key,
    required this.title,
    required this.buttonText,
    required this.toggleText,
    required this.textSpan,
    required this.onToggle,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 26),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Fields (map controllers to CustomField)
              ...controllers.asMap().entries.map((entry) {
                final idx = entry.key;
                final controller = entry.value;
                final hints = ["Name", "Email", "Password"];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: CustomField(
                    hintText: hints[idx % hints.length], // choose hint
                    controller: controller,
                  ),
                );
              }),

              const SizedBox(height: 20),
              Button(buttonText: buttonText, onTap: () {}),
              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  text: toggleText,
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: textSpan,
                      style: const TextStyle(
                        color: AppPallete.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onToggle
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
