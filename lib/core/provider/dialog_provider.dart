import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

/// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Dialog helper
class DialogProvider {
  DialogProvider._privateConstructor();
  static final DialogProvider instance = DialogProvider._privateConstructor();

  /// Show a simple dialog with title and message
  Future<bool> showDialogBox({
    String title = "",
    String message = "",
    String okText = "OK",
    VoidCallback? onOk,
    VoidCallback? onCancel,
    Widget? content,
  }) async {
    final context = navigatorKey.currentContext;
    if (context == null) return false;
    bool ok = false;
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: DimensionConstant.horizontalPadding(context, 4),
        ),
        // backgroundColor: AppPallete.backgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(
            DimensionConstant.horizontalPadding(context, 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppPallete.primaryDark,
                  fontSize: DimensionConstant.responsiveFont(context, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              if (content != null)
                content
              else ...[
                Text(
                  message,
                  style: TextStyle(
                    fontSize: DimensionConstant.responsiveFont(context, 16),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ok = true;
                    if (onOk != null) onOk();
                  },
                  child: Text(
                    okText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    return ok;
  }

  Future<void> showErrorDialog({
    String title = "เกิดข้อผิดพลาด",
    required String message,
    String okText = "OK",
    VoidCallback? onOk,
    VoidCallback? onCancel,
  }) async {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
            // maxHeight: 900,  <-- ลองคอมเมนต์ออกก่อน
          ),
          child: Padding(
            padding: EdgeInsets.all(
              DimensionConstant.horizontalPadding(context, 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppPallete.destructiveDark,
                    fontSize: DimensionConstant.responsiveFont(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: DimensionConstant.responsiveFont(context, 16),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onOk != null) onOk();
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 120,
                      minWidth: 80,
                      maxHeight: 50,
                    ),
                    padding: EdgeInsets.all(
                      DimensionConstant.horizontalPadding(context, 3),
                    ),
                    decoration: BoxDecoration(
                      color: AppPallete.destructiveDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      okText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: DimensionConstant.responsiveFont(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showWarningDialog({
    String title = "คำเตือน",
    required String message,
    String okText = "ตกลง",
    VoidCallback? onOk,
    VoidCallback? onCancel,
  }) async {
    bool ok = false;
    final context = navigatorKey.currentContext;
    if (context == null) return false;

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        // backgroundColor: AppPallete.backgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(
            DimensionConstant.horizontalPadding(context, 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: DimensionConstant.responsiveFont(context, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                message,
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 16),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onCancel != null) onCancel();
                    },
                    child: Container(
                      width: 80,
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 120),
                      padding: EdgeInsets.all(
                        DimensionConstant.horizontalPadding(context, 3),
                      ),
                      child: Text(
                        "ยกเลิก",
                        style: TextStyle(
                          color: AppPallete.primaryDark,
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            16,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      ok = true;
                      if (onOk != null) onOk();
                    },
                    child: Container(
                      width: 80,
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 120),
                      padding: EdgeInsets.all(
                        DimensionConstant.horizontalPadding(context, 3),
                      ),
                      child: Text(
                        okText,
                        style: TextStyle(
                          color: AppPallete.destructiveDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return ok;
  }

  /// Show a loading dialog
  void showLoading({String? message}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 10),
                Text(message, style: const TextStyle(color: Colors.white)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Close any dialog
  void hideDialog() {
    final context = navigatorKey.currentContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
