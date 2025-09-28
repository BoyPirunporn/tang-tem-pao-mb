import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/feature/auth/viewmodel/auth_viewmodel.dart';

class SigninForm extends ConsumerStatefulWidget {
  final VoidCallback handleToggle;
  const SigninForm({super.key, required this.handleToggle});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninFormState();
}

class _SigninFormState extends ConsumerState<SigninForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(authViewModelProvider, (_, next) {
    //   next?.maybeWhen(
    //     data: (data) {
    //       navigatorKey.currentState?.pushAndRemoveUntil(
    //         FadeRoute(page: const MyHomePage()),
    //         (_) => false,
    //       );
    //     },
    //     orElse: () {},
    //   );
    // });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      fontSize: DimensionConstant.responsiveFont(context, 26),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: DimensionConstant.verticalPadding(context, 5),
                      horizontal: DimensionConstant.verticalPadding(context, 2),
                    ),
                    hintText: 'ชื่อผู้ใช้',
                    controller: usernameController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "กรุณากรอกชื่อผู้ใช้";
                      }
                      if (val.length < 3) {
                        return "ชื่อผู้ใช้ควรมีอย่างน้อย 3 ตัวอักษร";
                      }
                      final usernameRegex = RegExp(
                        r'^[a-zA-Z0-9!@#\$%^&*(),.?":{}|<>]+$',
                      );
                      if (!usernameRegex.hasMatch(val.trim())) {
                        return "ชื่อผู้ใช้ไม่ถูกต้อง";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomField(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: DimensionConstant.verticalPadding(context, 5),
                      horizontal: DimensionConstant.verticalPadding(context, 2),
                    ),
                    hintText: 'รหัสผ่าน',
                    isObscureText: true,
                    controller: passwordController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "กรุณากรอกรหัสผ่าน";
                      }
                      if (val.length < 8) {
                        return "รหัสผ่านควรมีอย่างน้อย 8 ตัวอักษร";
                      }
                      final RegExp upper = RegExp(r"[A-Z]");
                      final RegExp lower = RegExp(r"[a-z]");
                      final RegExp numeric = RegExp(r"[0-9]");
                      final RegExp special = RegExp(r"[^a-zA-Z0-9]");
          
                      if (!upper.hasMatch(val)) {
                        return "ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว";
                      }
                      if (!lower.hasMatch(val)) {
                        return "ต้องมีตัวพิมพ์เล็กอย่างน้อย 1 ตัว";
                      }
                      if (!numeric.hasMatch(val)) {
                        return "ต้องมีตัวเลข";
                      }
                      if (!special.hasMatch(val)) {
                        return "ต้องมีอักขระพิเศษ";
                      }
          
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Button(
                    buttonText: "เข้าสู่ระบบ",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .login(
                              username: usernameController.text,
                              password: passwordController.text,
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'ยังไม่มีบัญชีใช่ไหม? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'สร้างบัญชี',
                          style: TextStyle(
                            color: AppPallete.primaryDark,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            height: 1.5,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.handleToggle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
