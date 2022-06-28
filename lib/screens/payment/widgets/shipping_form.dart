import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/models/order.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/components/shipping_screen_body.dart';
import 'package:lezemed_mobile_app/screens/payment/widgets/build_datetime_picker.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class ShippingForm extends StatefulWidget {
  final Billing billingInfo;
  final ProductModel productModel;

  const ShippingForm({
    Key key,
    @required this.billingInfo,
    @required this.productModel,
  }) : super(key: key);

  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  final _shippingFormKey = new GlobalKey<FormState>();
  Map<String, dynamic> _shippingFormElements = {
    'recipentFirstName': null,
    'recipentLastName': null,
    'recipentPhoneNumber': null,
    'recipentCountry': null,
    'recipentCompany': null,
    'recipentState': null,
    'recipentCity': null,
    'recipentStreetAddress': null,
    'recipentStreetAddress2': null,
    'recipentPostalCode': null,
    'recipentDeliveryDate': null,
    'recipentOrderNote': null
  };

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _orderNoteController = TextEditingController();
  final _streetAddressController2 = TextEditingController();
  final _companyController = TextEditingController();

  Shipping shipping = new Shipping();
  Order order = new Order();

  //Builds the Shipping form
  @override
  Widget build(BuildContext context) {
    setState(() {
      _shippingFormElements['recipentFirstName'] = _firstNameController.text;
      _shippingFormElements['recipentLastName'] = _lastNameController.text;
      _shippingFormElements['recipentCompany'] =
          _companyController.text != null || _companyController.text != ""
              ? _companyController.text
              : " ";
      _shippingFormElements['recipentPhoneNumber'] =
          _phoneNumberController.text;
      _shippingFormElements['recipentPostalCode'] = _postalCodeController.text;
      _shippingFormElements['recipentOrderNote'] = _orderNoteController.text;
      _shippingFormElements['recipentStreetAddress'] =
          _streetAddressController.text;
      _shippingFormElements['recipentDeliveryDate'] = _dateTimeController.text;

      _shippingFormElements['recipentStreetAddress2'] =
          _streetAddressController2.text != null ||
                  _streetAddressController2.text != ""
              ? _streetAddressController2.text
              : "";

      shipping.firstName =
          _shippingFormElements['recipentFirstName'].toString();
      shipping.company = _shippingFormElements['recipentCompany'].toString();
      shipping.lastName = _shippingFormElements['recipentLastName'].toString();
      shipping.country = _shippingFormElements['recipentCountry'].toString();
      shipping.state = _shippingFormElements['recipentState'].toString();
      shipping.city = _shippingFormElements['recipentCity'].toString();
      shipping.address1 =
          _shippingFormElements['recipentStreetAddress'].toString();
      shipping.address2 =
          _shippingFormElements['recipentStreetAddress2'].toString();
      shipping.postcode =
          _shippingFormElements['recipentPostalCode'].toString();
      shipping.note = _shippingFormElements['recipentOrderNote'].toString();

      order.shipping = shipping;
      order.billing = widget.billingInfo;
      order.customer_note =
          _shippingFormElements['recipentOrderNote'].toString();
    });
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Form(
        key: _shippingFormKey,
        child: Column(
          children: [
            customTextFormField(
              controller: _firstNameController,
              hint: AppStrings.firstName + " *",
              isRequired: true,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customTextFormField(
              controller: _lastNameController,
              hint: AppStrings.lastName + " *",
              isRequired: true,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customNumberFormField(
              controller: _phoneNumberController,
              hint: AppStrings.phone + " *",
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customTextFormField(
              controller: _companyController,
              hint: AppStrings.companyName + " (Optional)",
              isRequired: false,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _customCountryStateCityDropDown(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customTextFormField(
              controller: _streetAddressController,
              hint: AppStrings.streetAddress + " *",
              isRequired: true,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customTextFormField(
              controller: _streetAddressController2,
              hint: AppStrings.streetAddress2 + " (Optional)",
              isRequired: false,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            customNumberFormField(
              controller: _postalCodeController,
              hint: AppStrings.postCodeZIP + " *",
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            BuildDateTimePicker(
              dateTimeEditingController: _dateTimeController,
              icon: Icon(Icons.near_me),
              lableText: AppStrings.deliveryDate + " *",
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _buildOrderNoteField(
              controller: _orderNoteController,
              hint: AppStrings.orderNote + " *",
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            Text(
              AppStrings.orderNoteMessage,
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            CustomPaymentWidget(
              formKey: _shippingFormKey,
              order: order,
              productModel: widget.productModel,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(
      {TextEditingController controller, String hint, bool isRequired}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
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
      validator: (value) {
        if (isRequired) if (!Util().validateNotEmpty(value))
          return AppStrings.requiredMessage;
        return null;
      },
    );
  }

  Widget customEmailFormField({TextEditingController controller, String hint}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25.0),
        hintText: AppStrings.email,
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
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateEmail(value))
          return AppStrings.invalidFormatMessage;
        return null;
      },
    );
  }

  Widget customNumberFormField(
      {TextEditingController controller, String hint}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25.0),
        hintText: hint,
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
      validator: (value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        return null;
      },
    );
  }

  Widget _customCountryStateCityDropDown() {
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
        defaultCountry: DefaultCountry.Ethiopia,
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
          print(value);
          setState(() {
            _shippingFormElements['recipentCountry'] = value;
          });
        },
        onStateChanged: (value) {
          setState(() {
            _shippingFormElements['recipentState'] = value;
          });
        },
        onCityChanged: (value) {
          setState(() {
            _shippingFormElements['recipentCity'] = value;
          });
        },
      ),
    );
  }

  Widget _buildOrderNoteField({TextEditingController controller, String hint}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      decoration: InputDecoration(
        hintText:
            "Order Note. If it is a mobile topup, Please add reciepents phone number",
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
      onSaved: (value) => _shippingFormElements['recipentOrderNote'] = value,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildTextField({Icon icon, String lableText, onFormSaved}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: lableText,
          hintStyle: TextStyle(fontSize: 15),
          icon: icon,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        textCapitalization: TextCapitalization.words,
        onSaved: (value) => onFormSaved = value,
        validator: (value) {
          if (!Util().validateNotEmpty(value))
            return AppStrings.requiredMessage;
          if (!Util().validateName(value))
            return AppStrings.invalidFormatMessage;
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: AppStrings.phone,
          hintStyle: TextStyle(fontSize: 15),
          icon: Icon(Icons.phone),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.phone,
        onSaved: (value) =>
            _shippingFormElements['recipentPhoneNumber'] = value,
        validator: (value) {
          if (!Util().validateNotEmpty(value))
            return AppStrings.requiredMessage;
          return null;
        },
      ),
    );
  }
}
