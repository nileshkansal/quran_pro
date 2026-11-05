import 'package:flutter/material.dart';

/// Shows a floating snackbar, replacing any one already visible.
void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Placeholder for features that are not wired up yet.
void showComingSoon(BuildContext context, String feature) => showAppSnackBar(context, '$feature – coming soon');
