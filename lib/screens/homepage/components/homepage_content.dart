import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/homepage/components/homepage_widgets.dart';
import 'package:lezemed_mobile_app/models/categories.dart';
import 'package:lezemed_mobile_app/models/products.dart';

class ScrollingHomeBuilder extends StatefulWidget {
  final ProductModel model;

  ScrollingHomeBuilder({this.model});

  @override
  _ScrollingHomeBuilderState createState() => _ScrollingHomeBuilderState();
}

class _ScrollingHomeBuilderState extends State<ScrollingHomeBuilder> {
  List<Category> categories = [];
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProductCategories();
    fetchNewArrival();
  }

  Future fetchProductCategories() async {
    categories = await widget.model.getAllProductCategories();
  }

  void fetchNewArrival() async {
    products = await widget.model.getNewArrivalProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: NetworkSensitivity(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            customSlider(), //Slider Builder Function
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenHeight(250),
              child: categoryItemsListViewBuilder(
                fetchedProductCategories: categories,
                context: context,
                model: widget.model,
              ), //Categories Part builder function
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: getProportionateScreenHeight(325),
              child: newArrivalsListViewBuilder(
                model: widget.model,
                context: context,
                fetchedNewArrivalProducts: products,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

CarouselSlider customSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      initialPage: 0,
      height: getProportionateScreenHeight(175),
      enlargeCenterPage: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.easeIn,
      reverse: false,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: kSliderAnimationDuration,
      enableInfiniteScroll: true,
      viewportFraction: 0.8,
    ),
    items: [
      sliderItemBuilder('assets/images/HeroOne.jpeg'),
      sliderItemBuilder('assets/images/slider_image1.jpg'),
      sliderItemBuilder('assets/images/HeroTwo.jpeg'),
      sliderItemBuilder('assets/images/slider_image4.jpg'),
    ],
  );
}
