import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/global_widgets/no_data.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/screens/cart/widgets/cart_screenWidgets.dart';

class CartPageBuilder extends StatefulWidget {
  final ProductModel model;

  final List<PriceInfo> priceInfo;

  const CartPageBuilder({
    Key key,
    @required this.model,
    @required this.priceInfo,
  }) : super(key: key);

  @override
  _CartPageBuilderState createState() => _CartPageBuilderState();
}

class _CartPageBuilderState extends State<CartPageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: NetworkSensitivity(
        child: ValueListenableBuilder<Box<Cart>>(
          valueListenable: CartController.getCart().listenable(),
          builder: (context, box, _) {
            final cart = box.values.toList().cast<Cart>();
            return cart.length > 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return CartScrollPage(
                        id: cart[index].id,
                        data: cart[index],
                        imageLocation: cart[index].images,
                        title: cart[index].name,
                        price: int.parse(cart[index].price),
                        model: widget.model,
                        singlePriceInfo: widget.priceInfo[index],
                        priceInfo: widget.priceInfo,
                      );
                    },
                  )
                : NoDataIndicator(
                    message: AppStrings.noCartMessage, type: "NO_DATA");
          },
        ),
      ),
    );
  }
}
