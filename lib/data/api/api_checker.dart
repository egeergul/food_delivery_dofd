import 'package:dofd_user_panel/base/show_custom_snackbar.dart';
import 'package:dofd_user_panel/routes/route_helper.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 491) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
