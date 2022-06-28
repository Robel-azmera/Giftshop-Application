import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/enums/view_state.dart';
import 'package:lezemed_mobile_app/global_widgets/list_item.dart';
import 'package:lezemed_mobile_app/global_widgets/shimmer_effect.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';

class CheckBusyState extends StatelessWidget {
  final ViewState state;
  final Widget child;
  final bool isShimmer;

  const CheckBusyState(
      {Key key,
      @required this.state,
      @required this.child,
      @required this.isShimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.Busy:
        return isShimmer
            ? ShimmerEffect(child: ListItem(index: -1))
            : Spinners(color: kSecondaryColor, size: 26.0);
      default:
        return child;
    }
  }
}
