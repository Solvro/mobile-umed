import "package:flutter/material.dart";

import "views/info_view.dart";

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  static const routeName = "/info";

  @override
  Widget build(BuildContext context) => InfoView();
}
