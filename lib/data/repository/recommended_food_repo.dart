import 'package:dofd_user_panel/data/api/api_client.dart';
import 'package:dofd_user_panel/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    Response response =
        await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
    return response;
  }
}
