import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';

class ReviewBuilder extends StatefulWidget {
  final Product data;
  final ProductModel model;

  ReviewBuilder({Key key, this.data, this.model}) : super(key: key);

  @override
  _ReviewBuilderState createState() => _ReviewBuilderState();
}

class _ReviewBuilderState extends State<ReviewBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: widget.model.getAllProductReviews(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
                child: Spinners(
                    color: kSecondaryColor,
                    size: getProportionateScreenWidth(30.0)));
            break;
          case ConnectionState.active:
          case ConnectionState.done:
          default:
            if (snapshot.hasError)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Error Found: " + snapshot.error.toString()),
              ));
            if (snapshot.data.length <= 0)
              return Center(child: Text("No Reviews"));
            if (snapshot.hasData) {
              return Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      print(widget.data.id);
                      print(snapshot.data[index].product_id);

                      return widget.data.id == snapshot.data[index].product_id
                          ? Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                  title: Container(
                                      margin: EdgeInsets.only(
                                        top: getProportionateScreenHeight(8.0),
                                      ),
                                      child: Text(
                                        snapshot.data[index].reviewer,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: kSecondaryColor,
                                          fontSize: 17,
                                        ),
                                      )),
                                  subtitle: Text(snapshot.data[index].review),
                                ),
                                Divider(),
                              ],
                            )
                          : Container();
                    }),
              );
            }

            return Container();
        }
      },
    );
  }
}
