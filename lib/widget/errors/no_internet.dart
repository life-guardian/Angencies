import 'package:agencies_app/helper/classes/check_internet_connection.dart';
import 'package:agencies_app/widget/buttons/custom_outlined_button.dart';
import 'package:agencies_app/widget/errors/search_error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoInternet extends ConsumerWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SearchErrorImage(
          headingText:
              "No Internet Connection! \nCheck your connection, then refresh the page",
          imagePath: "assets/images/animated_images/nointernet.png",
        ),
        const SizedBox(
          height: 11,
        ),
        CustomOutlinedButton(
          text: "Retry",
          onPressed: () {
            CheckInternetConnection checkInternetConnection =
                CheckInternetConnection();
            checkInternetConnection.checkInternetConnection(ref: ref);
          },
          borderRadius: 20,
        ),
      ],
    );
  }
}
