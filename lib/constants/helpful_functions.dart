import 'dart:io';

import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class Throttler {
  final int milliseconds;

  Timer? timer;

  Throttler({required this.milliseconds});

  void run(VoidCallback action) {
    if (timer?.isActive ?? false) {
      return;
    }
    timer?.cancel();

    action();
    timer = Timer(Duration(milliseconds: milliseconds), () {});
  }

  void dispose() {
    timer?.cancel();
  }
}

String? validator(
  String? value,
  Validator field, {
  String? passwordText,
}) {
  if (value!.trim().isEmpty) {
    return "$field cannot be empty";
  } else if (field == Validator.email &&
      !value.contains(RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"))) {
    return 'Email is Invalid';
  } else if (field == Validator.phoneNumber &&
      !value.contains(RegExp(r'^[0-9]{11}$'))) {
    return "$field isn't valid";
  } else if (field == Validator.password && !(value.length > 4)) {
    return "$field isn't long enough";
  } else if (field == Validator.confirmPassword &&
      (value.trim() != passwordText?.trim())) {
    return "Passwords aren't the same";
  } else {
    return null;
  }
}

enum Validator {
  email,
  phoneNumber,
  password,
  confirmPassword,
  normal,
}

extension Currency on num {
  //Can be updated to
  //auto detect the currency to be used.
  String toCurrency() {
    return NumberFormat.compactSimpleCurrency(
      locale: Platform.localeName,
      name: "NGN",
      decimalDigits: 2,
    ).format(this);
  }
}
