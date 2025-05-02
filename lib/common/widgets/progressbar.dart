import "package:flutter/material.dart";

class ProgressBar extends StatelessWidget {
  final double progress;
  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 5))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 15,
                    backgroundColor: Colors.transparent, // nie nadpisuj tła
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
