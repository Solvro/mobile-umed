import "package:flutter/material.dart";
import "../../app/theme/app_theme.dart";
import "views/full_screen_error_view.dart";

class ErrorPage extends StatelessWidget {
  static const routeName = "/fullScreenError";

  final String? message;
  final VoidCallback onBackToHome;

  const ErrorPage({super.key, this.message, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: FullScreenErrorView(message: message, onBackToHome: onBackToHome),
    );
  }
}
