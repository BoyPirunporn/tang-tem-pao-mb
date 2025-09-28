import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/feature/auth/viewmodel/auth_viewmodel.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Button(
          buttonText: "Log out",
          onTap: () async {
            DialogProvider.instance.showDialogBox(
              title: "Warning",
              message: "ต้องการออกจากระบบใช่ไหม",
              onOk: () async {
                await ref.read(authViewModelProvider.notifier).logout();
              },
            );
          },
        ),
      ),
    );
  }
}
