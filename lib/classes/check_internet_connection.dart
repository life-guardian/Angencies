import 'dart:async';

import 'package:agencies_app/providers/agencydetails_providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInternetConnection {
  late StreamSubscription subscription;

  checkInternetConnection({required WidgetRef ref}) async {
    try {
      var results = await Connectivity()
          .checkConnectivity(); // Use var to declare results as a List<ConnectivityResult>
      ConnectivityResult result = results.isNotEmpty
          ? results[0]
          : ConnectivityResult.none; // Get the first result from the list

      if (result != ConnectivityResult.none) {
        debugPrint("Internet is on true");
        ref.read(isInternetConnectionOnProvider.notifier).state = true;
      } else {
        ref.read(isInternetConnectionOnProvider.notifier).state = false;
      }
    } catch (e) {
      debugPrint("Exception occurent in checkInternet ${e.toString()}");
    }
  }

  startStreamSubscription({required WidgetRef ref}) {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternetConnection(ref: ref);
    });
  }
}
