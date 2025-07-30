import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:wiredash/wiredash.dart";

import "config/env.dart";

class ProdWiredash extends StatelessWidget {
  const ProdWiredash({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      return Wiredash(
          projectId: Env.wiredashProjectId,
          secret: Env.wiredashSecretKey,
          child: child);
    } else {
      return child;
    }
  }
}
