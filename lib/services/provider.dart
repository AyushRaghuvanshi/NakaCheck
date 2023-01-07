import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nakacheck/services/Api.dart';

final alertsprov = FutureProvider<dynamic>((ref) {
  String number = ref.watch(numberPlate);
  log(number);
  return ref.watch(prov).getAlerts(number);
});

final numberPlate = StateProvider(
  (ref) => "",
);
