import 'package:lezemed_mobile_app/controller/product_controller.dart';
import 'package:lezemed_mobile_app/enums/view_state.dart';
import 'package:lezemed_mobile_app/models/categories.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/models/review.dart';
import 'package:lezemed_mobile_app/models/variation.dart';
import 'package:lezemed_mobile_app/scoped_model/base_model.dart';
import 'package:lezemed_mobile_app/service_locator.dart';

class ProductModel extends BaseModel {
  ProductController productController = locator<ProductController>();

  // Fetching product categories
  Future<List<Category>> getAllProductCategories() async {
    List<Category> fetchedProductCategories = [];

    // Start model
    setCurrentAppState(ViewState.Busy);
    fetchedProductCategories =
        await productController.getAllProductCategories();
    setCurrentAppState(ViewState.Retrived);

    return fetchedProductCategories;
    // End model
  }

  // Fetching new arrival products
  Future<List<Product>> getNewArrivalProduct() async {
    List<Product> fetchedNewArrivalProducts = [];

    // Start model
    setCurrentAppState(ViewState.Busy);
    fetchedNewArrivalProducts = await productController.getNewArrivalProduct();
    setCurrentAppState(ViewState.Retrived);

    return fetchedNewArrivalProducts;
    // End model
  }

  Future getAllProductCategoriesWithFilter(categoryId, pageNumber) async {
    // Start model
    return await productController.getAllProductCategoriesWithFilter(
        categoryId, "", pageNumber);
  }

  Future<List<Variation>> getProductVariation({String productId}) async {
    // Start model
    List<Variation> variations = [];

    setCurrentAppState(ViewState.Busy);
    variations =
        await productController.getProductVariation(productId: productId);
    setCurrentAppState(ViewState.Retrived);

    return variations;
    // End model
  }

  Future<List<Product>> getProducts() async {
    return await productController.getAllProducts();
  }

  //Get Product Reviews
  Future<List<Review>> getAllProductReviews() async {
    return await productController.getAllProductReviews();
  }

//   Future getAllProductCategories() async {
//     // Start model
//     return await productController.getAllProductCategories();
// >>>>>>> ebb7c51572f8cde2480fb3bf0b2414c28584212b
//     // End model
//   }

  Future getSearchProduct(String productName) async {
    // Start model
    return await productController.getSearchProduct(productName);
    // End model
  }

  bool addWishlist(Product product) {
    // Start models
    return productController.addWishlist(product);
    // End models
  }

  void deleteWishlist(int productId) async {
    // Start models
    return await productController.deleteWishlist(productId);
    // End models
  }

  bool addCartlist(Product product) {
    // Start models
    return productController.addCartList(product);
    // End models
  }

  bool deleteAllCartList() {
    // Start models
    return productController.deleteAllCart();
    // End models
  }

  bool deleteAllPriceList() {
    // Start models
    return productController.deleteAllPrice();
    // End models
  }

  void deleteCartlist(int productId) async {
    // Start models
    return await productController.deleteCartlist(productId);
    // End models
  }

  bool addPrice(int productId, int quantity, int price) {
    // Start models
    return productController.addPrice(quantity, productId, price);
    // End models
  }

  bool updatePrice(PriceInfo model) {
    // Start models
    return productController.updatePrice(model);
    // End models
  }

  void deletePrice(int productId) async {
    // Start models
    return await productController.deletePrice(productId);
    // End models
  }

  bool addFavourite(int id, bool isfavourite) {
    // Start models
    return productController.addFavourite(id, isfavourite);
    // End models
  }

  bool updateFavourite(int id, bool isfavourite) {
    // Start models
    return productController.updateFavourite(id, isfavourite);
    // End models
  }

  void deleteFavourite(int id) async {
    // Start models
    return await productController.deleteFavourite(id);
    // End models
  }
}
