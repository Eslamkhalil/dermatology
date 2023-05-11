import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorDialog {
  // using singleton pattern
  //ProgressIndicatorDialog._internal();  same   ProgressIndicatorDialog._();
  ProgressIndicatorDialog._();
  static final ProgressIndicatorDialog _instance = ProgressIndicatorDialog._();
  factory ProgressIndicatorDialog() => _instance;

  // for display dialog
  Future<void> show(BuildContext context,
      {String text = 'Please Waiting ....'}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // for prevent user dismiss dialog
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              backgroundColor: Colors.white,
              content: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                            width: 32,
                            height: 32),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          text,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  // dismiss( ) {
  //   Navigator.of(context).pop();
  // }
}
