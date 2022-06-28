import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/scoped_model/order_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/shipping_payement_screen.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class BillingForm extends StatefulWidget {
  final OrderModel orderModel;
  final ProductModel productModel;

  BillingForm({@required this.orderModel, @required this.productModel});
  @override
  _BillingFormState createState() => _BillingFormState();
}

class _BillingFormState extends State<BillingForm> {
  Billing billing = new Billing();
  var customerDetailsModel;
  String valueChoose;
  final _billingFormKey = new GlobalKey<FormState>();
  Map<String, dynamic> _billingFormElements = {
    'billingFirstName': null,
    'billingLastName': null,
    'billingPhoneNumber': null,
    'billingCountry': null,
    'billingState': null,
    'billingCity': null,
    'billingStreetAddress': null,
    'billingStreetAddress2': null,
    'billingCompany': null,
    'billingEmail': null,
    'billingPostcode': null,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30.0)),
      child: Form(
        key: _billingFormKey,
        child: Column(
          children: [
            firstNameTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            lastNameTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            companyTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _customCountryStateCityDropDown(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            postalCodeTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            streetAddressOneTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            streetAddressTwoTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            phoneNumberTextField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            emailTextField(),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            ToShippingScreen(
              formKey: _billingFormKey,
              billingInfo: billing,
              productModel: widget.productModel,
              billingFormElement: _billingFormElements,
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.firstName + " *",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingFirstName'] = value;
          billing.firstName = _billingFormElements['billingFirstName'];
        });
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateName(value)) return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget lastNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.lastName + " *",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingLastName'] = value;
          billing.lastName = _billingFormElements['billingLastName'];
        });
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateName(value)) return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget phoneNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.phone + " *",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingPhoneNumber'] = value;
          billing.phone = _billingFormElements['billingPhoneNumber'];
        });
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().isNumberOnly(value)) return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget companyTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.companyName + " (Optional)",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        print(value);
        setState(() {
          _billingFormElements['billingCompany'] =
              value != null || value != "" ? value : " ";
          billing.company = _billingFormElements['billingCompany'];
        });
      },
    );
  }

  Widget postalCodeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.postCodeZIP + " *",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingPostcode'] = value;
          billing.postcode = _billingFormElements['billingPostcode'];
        });
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().isNumberOnly(value)) return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget streetAddressOneTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.streetAddress + " *",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingStreetAddress'] = value;
          billing.address1 = _billingFormElements['billingStreetAddress'];
        });
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        return null;
      },
    );
  }

  Widget streetAddressTwoTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.streetAddress2 + " (Optional)",
        contentPadding: EdgeInsets.all(25.0),
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        setState(() {
          _billingFormElements['billingStreetAddress2'] =
              value != null || value != "" ? value : " ";
          billing.address2 = _billingFormElements['billingStreetAddress2'];
        });
      },
    );
  }

  Widget emailTextField(
      {TextEditingController controller,
      String hint,
      String billingElement,
      String billingModelElement}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25.0),
        hintText: AppStrings.email + " *",
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        _billingFormElements['billingEmail'] = value;
        billing.email = _billingFormElements['billingEmail'];
      },
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateEmail(value))
          return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget _customCountryStateCityDropDown(
      {onCountrySaved, onStateSaved, onCitySaved}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: CSCPicker(
        showStates: true,
        showCities: true,
        flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
        layout: Layout.vertical,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        disabledDropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        selectedItemStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        dropdownHeadingStyle: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        searchBarRadius: 10.0,
        onCountryChanged: (value) {
          setState(() {
            _billingFormElements['billingCountry'] = value;
            billing.country = _billingFormElements['billingCountry'];
          });
        },
        onStateChanged: (value) {
          setState(() {
            _billingFormElements['billingState'] = value;
            billing.state = _billingFormElements['billingState'];
          });
        },
        onCityChanged: (value) {
          setState(() {
            _billingFormElements['billingCity'] = value;
            billing.city = _billingFormElements['billingCity'];
          });
        },
      ),
    );
  }
}

class ToShippingScreen extends StatelessWidget {
  final Billing billingInfo;
  final GlobalKey<FormState> formKey;
  final ProductModel productModel;
  final Map<String, dynamic> billingFormElement;

  const ToShippingScreen({
    Key key,
    @required this.billingInfo,
    @required this.formKey,
    @required this.productModel,
    this.billingFormElement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: kPrimaryFromLefttoRightGradientColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          // Checking optional fields
          if (billingInfo.company == null || billingInfo.address2 == null) {
            billingInfo.company = " ";
            billingInfo.address2 = " ";
          }

          // Displaying error message for country state city
          if (billingInfo.country == null ||
              billingInfo.state == null ||
              billingInfo.city == null)
            return Fluttertoast.showToast(
                msg: "Country, state or city are not filled.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[200],
                textColor: kPrimaryColor,
                fontSize: 16.0);

          if (formKey.currentState.validate()) {
            Routes().navigation(
              context,
              ShippingPayementPageScreen(
                  billingInfo: billingInfo, productModel: productModel),
            );
          }
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          primary: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.next,
              style: TextStyle(fontSize: 20.0, color: kWhitishBackgrounColor),
            ),
            SizedBox(width: 20.0),
            Icon(
              MaterialIcons.arrow_forward,
              color: kWhitishBackgrounColor,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
