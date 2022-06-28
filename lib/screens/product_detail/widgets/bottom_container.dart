// import 'package:flutter/material.dart';
// import 'package:lezemed_mobile_app/config/palete.dart';
// import 'package:lezemed_mobile_app/config/size.dart';

// class BottomContainer extends StatefulWidget {
//   const BottomContainer({
//     Key key,
//     this.title,
//     this.detail,
//     this.price,
//     this.amount,
//   }) : super(key: key);

//   final String title;
//   final String detail;
//   final int price;
//   final int amount;

//   @override
//   _BottomContainerState createState() => _BottomContainerState();
// }

// class _BottomContainerState extends State<BottomContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(35.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(65.0),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: getProportionateScreenWidth(250),
//                 child: Text(
//                   widget.title,
//                   style: TextStyle(
//                     color: kSecondaryColor,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               Icon(
//                 Icons.favorite_outline,
//                 size: 20,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: getProportionateScreenHeight(15.0),
//           ),
//           Text(
//             widget.detail,
//             style: TextStyle(
//               fontSize: 13,
//             ),
//           ),
//           SizedBox(
//             height: getProportionateScreenHeight(10.0),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '\$ ${widget.price}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 22,
//                 ),
//               ),
//               SizedBox(
//                 width: getProportionateScreenWidth(50.0),
//               ),
//               Container(
//                 width: getProportionateScreenWidth(90.0),
//                 padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
//                 decoration: BoxDecoration(
//                   color: kBackgroundColor,
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(Icons.remove_outlined),
//                     Text(
//                       '${widget.amount}',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     Icon(Icons.add_outlined),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: getProportionateScreenWidth(20.0),
//               ),
//               Container(
//                 height: 55.0,
//                 width: 55.0,
//                 child: FittedBox(
//                   child: FloatingActionButton(
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       child: Icon(
//                         Icons.add_shopping_cart,
//                         size: 27,
//                       ),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: kPrimaryFromTopToBottomGradientColor),
//                     ),
//                     onPressed: () {
//                       // print('yesss');
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
