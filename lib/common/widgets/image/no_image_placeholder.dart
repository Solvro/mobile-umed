import "package:flutter/material.dart";

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({super.key, this.size});

  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/no_image.png",
        width: size?.width, height: size?.height);
  }
}
