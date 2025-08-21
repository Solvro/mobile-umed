import "package:url_launcher/url_launcher.dart";

Future<bool> customLaunchUrl(String url) async {
  if (url.isEmpty) return false;
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return true;
  }
  return false;
}
