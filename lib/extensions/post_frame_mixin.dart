import 'package:flutter/widgets.dart';

/// Execute only when page is mounted
mixin PostFrameMixin<T extends StatefulWidget> on State<T> {
  void postFrame(void Function() callback) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          // Execute callback if page is mounted
          if (mounted) callback();
        },
      );
}
