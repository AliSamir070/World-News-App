import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker{
  static ConnectivityResult connectionStatus = ConnectivityResult.none;

  static Future<void> checkConnectivity() async {
    connectionStatus= await Connectivity().checkConnectivity();
  }

}