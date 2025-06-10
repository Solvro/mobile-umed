import "package:url_launcher/url_launcher.dart";

Future<void> customLaunchUrl(String url, String errorMessage) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw Exception("$errorMessage: \n$url");
  }
}
