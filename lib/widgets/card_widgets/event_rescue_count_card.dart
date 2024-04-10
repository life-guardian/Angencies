import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class EventRescueCountCard extends StatelessWidget {
  const EventRescueCountCard({
    super.key,
    required this.eventCount,
    required this.rescueCount,
  });

  final String eventCount;
  final String rescueCount;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: (themeData.brightness == Brightness.dark)
            ? Theme.of(context).colorScheme.secondary
            : Colors.black87,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.green,
                size: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    text: "Events",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 220, 217, 217),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextWidget(
                    text: eventCount,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                ],
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.white,
            indent: 15,
            endIndent: 15,
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.green,
                size: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    text: 'Rescue Ops',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 220, 217, 217),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextWidget(
                    text: rescueCount,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
