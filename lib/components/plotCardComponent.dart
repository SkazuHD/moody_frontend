import 'package:flutter/material.dart';

import '../data/models/plotCard.dart';
import 'greyButton.dart';
import 'headlines.dart';

class PlotCardComponent extends StatelessWidget {
  const PlotCardComponent({super.key, required this.plotCard, this.onPressed});

  final PlotCard plotCard;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFDEBB97), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Today\'s Plot-Card:', style: h1Black, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          if (plotCard.isEmpty)
            Column(
              children: [
                Text(plotCard.quote, style: h2Black, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Column(
                  children:
                      plotCard.recommendation
                          .map(
                            (recommendation) =>
                                Text(recommendation.toString(), style: bodyBlack, textAlign: TextAlign.center),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onPressed,
                  style: greyButtonStyle,
                  child: const Text('Record something now!'),
                ),
              ],
            )
          else ...[
            Text(plotCard.quote, style: h2Black, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Column(
              children:
                  plotCard.recommendation
                      .map(
                        (recommendation) =>
                            Text(recommendation.toString(), style: bodyBlack, textAlign: TextAlign.center),
                      )
                      .toList(),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
