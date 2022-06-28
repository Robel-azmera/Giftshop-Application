class Review {
  int id;
  int product_id;
  String reviewer;
  String review;
  int rating;
  Image image;

  Review({this.id, this.reviewer, this.rating, this.review, this.image});

  Review.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    product_id = json["product_id"];
    reviewer = json["reviewer"];
    review = json["review"];
    rating = json["rating"];
    image = json["reviewer_avatar_urls"] != null
        ? new Image.fromJSON(json["reviewer_avatar_urls"])
        : null;
  }
}

class Image {
  String url;

  Image({this.url});

  Image.fromJSON(Map<String, dynamic> json) {
    url = json['24'];
  }
}

// import 'package:flutter/material.dart';

// class Category {
//   int categoryID;
//   String categoryName;
//   String categoryDescription;
//   Image image;

//   Category(
//       {this.categoryID,
//       this.categoryName,
//       this.categoryDescription,
//       this.image});

//   Category.fromJSON(Map<String, dynamic> json) {
//     categoryID = json["id"];
//     categoryName = json["name"];
//     categoryDescription = json["description"];
//     image = json["image"] != null ? new Image.fromJSON(json["image"]) : null;
//   }
// }

// class Image {
//   String url;

//   Image({this.url});

//   Image.fromJSON(Map<String, dynamic> json) {
//     url = json['src'];
//   }
// }

// class Review {
//   int id;
//   String reviewer;
//   String review;
//   int rating;
//   List<Avatar> images;

//   Review({
//     this.id,
//     this.reviewer,
//     this.review,
//     this.rating,
//   });

//   Review.fromJSON(Map<String, dynamic> json) {
//     id = json['id'];
//     reviewer = json['reviewer'];
//     review = json['review'];
//     rating = json['rating'];

//     if (json['reviewer_avatar_urls'] != null) {
//       images = [];
//       json['reviewer_avatar_urls']
//           .forEach((eachImage) => images.add(new Avatar.fromJSON(eachImage)));
//     }
//   }
// }

// class Avatar {
//   String src;

//   Avatar({this.src});
//   Avatar.fromJSON(Map<String, dynamic> json) {
//     src = json['24'];
//   }
// }
