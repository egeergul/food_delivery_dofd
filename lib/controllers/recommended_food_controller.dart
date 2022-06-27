import 'package:dofd_user_panel/utils/app_constants.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_food_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;



  RecommendedProductController ({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got products recommended ");
      _recommendedProductList = [];
      _recommendedProductList  .addAll(Product.fromJson(response.body).products);
      //_recommendedProductList  .addAll(Product.fromJson(data).products);

      _isLoaded = true;

      update();
    } else {
      print("App base url is " + AppConstants.BASE_URL );
      print("could not ge t products recommended ");
    }
  }
}
