import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_body.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class ShopSearch extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isSearchActivated;
  final String searchTerm;
  final StringCallback setSearch;
  final VoidCallback onChange;

  ShopSearch(
      {Key key,
      this.formKey,
      this.isSearchActivated,
      this.onChange,
      this.setSearch,
      this.searchTerm})
      : super(key: key);

  @override
  _ShopSearchState createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Material(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          elevation: 5.0,
          child: Form(
            key: widget.formKey,
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: kSecondaryColor),
              child: TextFormField(
                  initialValue: widget.searchTerm,
                  cursorColor: kSecondaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.search,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    suffixIcon: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      // child: widget.isSearchActivated
                      //     ? Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: <Widget>[
                      //           IconButton(
                      //             icon: Icon(Icons.close),
                      //             onPressed: () {
                      //               widget.setSearch("");
                      //               widget.onChange();
                      //             },
                      //           ),
                      //           IconButton(
                      //               icon: Icon(Icons.search),
                      //               onPressed: () {
                      //                 widget.onChange();
                      //               })
                      //         ],
                      //       )
                      child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => widget.onChange()),
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (String value) {
                    if (!Util().validateNotEmpty(value))
                      return AppStrings.requiredMessage;
                    return null;
                  },
                  onChanged: (value) {
                    widget.setSearch(value);
                    widget.onChange();
                  }),
            ),
          )),
    );
  }
}
