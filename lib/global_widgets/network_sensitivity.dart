import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';

class NetworkSensitivity extends StatelessWidget {
  final Widget child;

  NetworkSensitivity({this.child});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return new Stack(fit: StackFit.expand, children: [
          child,
          Positioned(
            height: connected ? 0.0 : 32.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              color: kBackgroundColor,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: connected
                    ? null
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(AppStrings.offline),
                          SizedBox(width: 8.0),
                          SizedBox(
                            width: 12.0,
                            height: 12.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ]);
      },
      child: child,
    );
  }
}
