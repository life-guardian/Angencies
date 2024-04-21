import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListviewShimmerAnimation extends StatelessWidget {
  const ListviewShimmerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: currentBrightness == Brightness.light
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.background,
            highlightColor: currentBrightness == Brightness.light
                ? Colors.grey.shade100
                : Theme.of(context).colorScheme.secondary,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
