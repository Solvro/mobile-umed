import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class ModalBeforeExiting extends StatelessWidget {
  const ModalBeforeExiting({required this.modal, required this.child});

  final Widget modal;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showDialog<bool>(context: context, builder: (context) => modal) ?? false;
        if (context.mounted && shouldPop) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.pop();
          });
        }
      },
      child: child,
    );
  }
}
