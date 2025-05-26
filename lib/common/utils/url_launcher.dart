import "package:url_launcher/url_launcher.dart";

Future<void> customLaunchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw Exception("Could not launch $url");
  }
}
