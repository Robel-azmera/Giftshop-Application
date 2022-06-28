import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lezemed_mobile_app/config/api.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';
import 'package:lezemed_mobile_app/models/categories.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/models/wishlist.dart';
import 'package:lezemed_mobile_app/models/review.dart';
import 'package:lezemed_mobile_app/models/favourite.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/models/variation.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/favourite_controller.dart';
import 'package:lezemed_mobile_app/controller/price_info_controller.dart';

class ProductController {
  // Fetching product categories
  Future<List<Category>> getAllProductCategories() async {
    List<Category> data = [];

    try {
      String url = Util().getOAuthURL('GET', API.url + API.categoryURL);
      final http.Response response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map(
              (i) => Category.fromJSON(i),
            )
            .toList()
            .cast<Category>();
      } else {
        print("Error " + response.statusCode.toString());
      }
    } on Exception catch (error) {
      print(error);
    }

    return data;
  }

  // Get variation of single product
  Future<List<Variation>> getProductVariation({String productId}) async {
    List<Variation> data = [];

    try {
      String varUrl = API.productURL + '/' + productId + '/' + API.variationURL;
      String url = Util().getOAuthURL('GET', API.url + varUrl);
      final http.Response response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map(
              (i) => Variation.fromJSON(i),
            )
            .toList()
            .cast<Variation>();
      }
    } catch (error) {
      print(error);
    }

    return data;
  }

  // Fetching new arrival product
  Future<List<Product>> getNewArrivalProduct() async {
    List<Product> newArrivalProducts = [];
    try {
      String url = Util().getOAuthURL(
          'GET', API.url + API.productURL + "?tag=" + API.newArrivalTagid);
      final http.Response response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        newArrivalProducts = (jsonDecode(response.body) as List)
            .map(
              (i) => Product.fromJSON(i),
            )
            .toList()
            .cast<Product>();
      } else {
        print("Error " + response.statusCode.toString());
      }
    } on Exception catch (error) {
      print(error);
    }
    return newArrivalProducts;
  }

  // Get all products
  Future<List<Product>> getAllProducts() async {
    List<Product> allProduct = [];

    try {
      String url = Util().getOAuthURL('GET', API.url + API.productURL);

      final http.Response response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        allProduct = (jsonDecode(response.body) as List)
            .map((e) {
              Product.fromJSON(e);
            })
            .toList()
            .cast<Product>();
      } else {
        print("Error: " + response.statusCode.toString());
      }
    } on Exception catch (error) {
      print(error);
    }
    return allProduct;
  }

  // Fetching all products with respect to category
  // If the category id 0, fetching all products
  // Otherwise, fetching all products in the store
  Future<List<Product>> getAllProductCategoriesWithFilter(
      String categoryId, String searchTerm, int pageNumber) async {
    List<Product> allProducts = [];

    try {
      String url;

      if (categoryId != "-1" && categoryId != null) {
        url = Util().getOAuthURL(
            'GET',
            API.url +
                API.productURL +
                "?category=" +
                categoryId +
                "?page=" +
                pageNumber.toString() +
                "&per_page=11");
      } else {
        url = Util().getOAuthURL(
            'GET',
            API.url +
                API.productURL +
                "?page=" +
                pageNumber.toString() +
                "&per_page=21");
      }
      final http.Response response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        allProducts = (jsonDecode(response.body) as List)
            .map((i) => Product.fromJSON(i))
            .toList()
            .cast<Product>();
      } else {
        print("Error: " + response.statusCode.toString());
      }
    } on Exception catch (error) {
      print(error);
    }

    return allProducts;
  }

  // Fetching products reviews
  Future<List<Review>> getAllProductReviews() async {
    List<Review> data = [];

    try {
      String url = Util().getOAuthURL('GET', API.url + API.reviewURL);
      final http.Response response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map(
              (i) => Review.fromJSON(i),
            )
            .toList()
            .cast<Review>();
      }
    } catch (error) {
      print(error);
    }

    return data;
  }

  // Search product
  Future<List<Product>> getSearchProduct(String productName) async {
    List<Product> searchedProductResult = [];

    try {
      String url = Util().getOAuthURL(
          'GET', API.url + API.productURL + "?search=" + productName);
      final http.Response response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        searchedProductResult = (jsonDecode(response.body) as List)
            .map((i) => Product.fromJSON(i))
            .toList()
            .cast<Product>();
      } else {
        print("Error: " + response.statusCode.toString());
      }
    } on Exception catch (error) {
      print(error);
    }

    return searchedProductResult;
  }

  // Cart
  // Add CartList
  bool addCartList(Product product) {
    var jsonaddCartList = jsonEncode(product.toJson());

    var decodeFromJson = jsonDecode(jsonaddCartList);

    if (checkCartAvailability(decodeFromJson['id'])) {
      return false;
    } else {
      final cart = Cart()
        ..id = decodeFromJson['id']
        ..name = decodeFromJson['name']
        ..description = decodeFromJson['description']
        ..shortDescription = decodeFromJson['shortDescription']
        ..sku = decodeFromJson['sku']
        ..price = decodeFromJson['price']
        ..regularPrice = decodeFromJson['regularPrice']
        ..salesPrice = decodeFromJson['salesPrice']
        ..stockStatus = decodeFromJson['stockStatus']
        ..status = decodeFromJson['status']
        ..catalog_visibility = decodeFromJson['catalog_visibility']
        ..images = decodeFromJson['images'];

      final cartListHiveBox = CartController.getCart();
      cartListHiveBox.put(decodeFromJson['id'], cart);

      return true;
    }
  }

  // Checking if the product is already in the cart
  // Return true is the product is already in the cart
  // False otherwise
  bool checkCartAvailability(int productId) {
    final cartlistBox = CartController.getCart();

    if (cartlistBox.get(productId) != null)
      return true;
    else
      return false;
  }

  // Delete Cart
  void deleteCartlist(int productId) {
    final cartBox = CartController.getCart();
    cartBox.delete(productId);
  }

  // Wishlist
  // Add wishlist
  bool addWishlist(Product product) {
    var jsonWishlist = jsonEncode(product.toJson());

    var decodeFromJson = jsonDecode(jsonWishlist);

    if (checkWishlistAvailability(decodeFromJson['id'])) {
      return false;
    } else {
      final wishlist = Wishlist()
        ..id = decodeFromJson['id']
        ..name = decodeFromJson['name']
        ..description = decodeFromJson['description']
        ..shortDescription = decodeFromJson['shortDescription']
        ..sku = decodeFromJson['sku']
        ..price = decodeFromJson['price']
        ..regularPrice = decodeFromJson['regularPrice']
        ..salesPrice = decodeFromJson['salesPrice']
        ..stockStatus = decodeFromJson['stockStatus']
        ..status = decodeFromJson['status']
        ..catalog_visibility = decodeFromJson['catalog_visibility']
        ..images = decodeFromJson['images'];

      final wishlistHiveBox = WishlistController.getWishlist();
      wishlistHiveBox.put(decodeFromJson['id'], wishlist);

      return true;
    }
  }

  // Checking if the product is already in the wishlist
  // Return true is the product is already in the wishlist
  // False otherwise
  bool checkWishlistAvailability(int productId) {
    final wishlistBox = WishlistController.getWishlist();

    if (wishlistBox.get(productId) != null)
      return true;
    else
      return false;
  }

  // Delete wishlist
  void deleteWishlist(int productId) {
    final wishlistBox = WishlistController.getWishlist();
    wishlistBox.delete(productId);
  }

  bool checkPriceAvailability(int id) {
    final amountBox = PriceInfoController.getPrice();
    if (amountBox.get(id) != null)
      return true;
    else
      return false;
  }

  // Price
  // Add Price
  bool addPrice(int quantity, int id, int price) {
    if (checkPriceAvailability(id)) {
      return false;
    } else {
      final data = PriceInfo()
        ..id = id
        ..amount = quantity
        ..price = price;

      final amountHiveBox = PriceInfoController.getPrice();
      amountHiveBox.put(id, data);

      return true;
    }
  }

  // Delete Price
  bool updatePrice(PriceInfo model) {
    final priceBox = PriceInfoController.getPrice();

    final modelExists = priceBox.containsKey(model.id);
    if (!modelExists) {
      return false;
    }
    model.save();
    return true;
  }

  // Delete Price
  void deletePrice(int id) {
    final priceBox = PriceInfoController.getPrice();
    priceBox.delete(id);
  }

  bool checkFavouriteAvailability(int id) {
    final favBox = FavouriteController.getfavourite();
    if (favBox.get(id) != null)
      return true;
    else
      return false;
  }

  // Favourite
  // Add Favourite
  bool addFavourite(int id, bool isfavourite) {
    if (checkFavouriteAvailability(id)) {
      return false;
    } else {
      final data = Favourite()
        ..id = id
        ..isFavourite = isfavourite;

      final favHiveBox = FavouriteController.getfavourite();
      favHiveBox.put(id, data);

      return true;
    }
  }

  bool updateFavourite(int id, bool isfavourite) {
    final data = Favourite()
      ..id = id
      ..isFavourite = isfavourite;

    final favHiveBox = FavouriteController.getfavourite();
    favHiveBox.putAt(id, data);

    return true;
  }

// Delete Amount
  void deleteFavourite(int id) {
    final favHiveBox = FavouriteController.getfavourite();
    favHiveBox.delete(id);
  }

  bool deleteAllCart() {
    final cartBox = CartController.getCart();
    cartBox.clear();
    cartBox.deleteAll(cartBox.keys);

    return true;
  }

  bool deleteAllPrice() {
    final priceBox = PriceInfoController.getPrice();
    priceBox.clear();
    priceBox.deleteAll(priceBox.keys);

    return true;
  }
}
