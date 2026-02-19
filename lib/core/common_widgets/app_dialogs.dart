import 'package:flutter/material.dart';
import 'package:labamu_test/core/error/exceptions/general_exception.dart';
import 'package:labamu_test/extensions/int_extensions.dart';
import 'package:labamu_test/extensions/navigation_extension.dart';
import 'package:labamu_test/extensions/string_extension.dart';
import 'package:labamu_test/extensions/text_style_extension.dart';

class AppDialog {
  static BuildContext? _dialogContext;

  static void showLoadingDialog(
    BuildContext localContext, {
    String message = 'Please Wait...',
  }) {
    showDialog(
      context: localContext,
      barrierDismissible: false,
      builder: (context) {
        _dialogContext = context;
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    );
  }

  static void dismissDialog() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }

  static void showSuccessDialog(
    BuildContext context, {
    String? message,
    VoidCallback? onTapped,
    bool barrierDismissible = false,
  }) {
    // auto-pop after
    Future.delayed(const Duration(seconds: 1), () {
      if (Navigator.canPop(context)) {
        context.pop();
        onTapped?.call();
      }
    });

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 111),
                16.toHeightGap(),
                Text(message ?? 'Success').fontSize(18).mediumWeight(),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: onTapped != null
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 25,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onTapped.call();
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ]
              : null,
        );
      },
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    String? message,
    VoidCallback? onTapped,
    Widget? title,
    String? titleText,
  }) {
    if (!message.isNotNullAndNotEmpty) {
      message = GeneralException.defaultMessage;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, size: 115, color: Colors.orange),
                8.toHeightGap(),
                title ??
                    Text(titleText ?? 'Sorry')
                        .center()
                        .mediumWeight()
                        .fontSize(22)
                        .textColor(Colors.orange),
                8.toHeightGap(),
                Text(message ?? GeneralException.defaultMessage).fontSize(14),
                32.toHeightGap(),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onTapped?.call();
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
