import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/feature/auth/viewmodel/auth_viewmodel.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Center(
            child: Text("Coming soon!!",style: TextStyle(fontSize: DimensionConstant.responsiveFont(context, 20)),),
          )),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: DimensionConstant.horizontalPadding(context, 4),vertical: DimensionConstant.horizontalPadding(context, 4)),
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
          ),
        ],
      ),
    );
  }
}
