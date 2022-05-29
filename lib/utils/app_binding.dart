import 'package:get/get.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_search_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_similar_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_division_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_view_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/controllers/premium_controller.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/auth/controllers/register_controller.dart';
import 'package:obm_market/modules/auth/controllers/reset_password_controller.dart';
import 'package:obm_market/modules/location/controllers/city_controller.dart';
import 'package:obm_market/modules/location/controllers/zone_controller.dart';
import 'package:obm_market/modules/menu/controllers/bottom_bar_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/modules/settings/controllers/settings_controller.dart';
import 'package:obm_market/modules/user/advert/controllers/user_advert_controller.dart';
import 'package:obm_market/modules/user/alert/controllers/alert_controller.dart';
import 'package:obm_market/modules/user/favorite/controllers/favorite_controller.dart';
import 'package:obm_market/modules/user/notification/controllers/locale_notification_controller.dart';
import 'package:obm_market/modules/user/notification/controllers/notification_controller.dart';
import 'package:obm_market/modules/user/profil/controllers/account_delete_controller.dart';
import 'package:obm_market/modules/user/profil/controllers/password_edit_controller.dart';
import 'package:obm_market/modules/user/profil/controllers/profil_controller.dart';
import 'package:obm_market/modules/user/profil/controllers/profil_edit_controller.dart';
import 'package:obm_market/modules/user/thread/controllers/thread_controller.dart';

class AppBinding implements Bindings {

  @override
  void dependencies() {
    Get.put<MenuController>(MenuController());
    Get.put<BottomBarController>(BottomBarController());
    Get.put<CategoryController>(CategoryController());
    Get.put<PremiumController>(PremiumController());
    Get.put<AuthController>(AuthController());
    Get.put<RegisterController>(RegisterController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<AdvertSearchController>(AdvertSearchController());
    Get.put<CityController>(CityController());
    Get.put<ZoneController>(ZoneController());
    Get.put<AdvertController>(AdvertController());
    Get.put<AdvertCategoryController>(AdvertCategoryController());
    Get.put<AdvertSubCategoryController>(AdvertSubCategoryController());
    Get.put<AdvertSubDivisionController>(AdvertSubDivisionController());
    Get.put<AdvertViewController>(AdvertViewController());
    Get.put<AdvertSimilarController >(AdvertSimilarController());
    Get.put<FavoriteController>(FavoriteController());
    Get.put<AlertController>(AlertController());
    Get.put<UserAdvertController>(UserAdvertController());
    Get.put<ProfilEditController>(ProfilEditController());
    Get.put<AccountDeleteController>(AccountDeleteController());
    Get.put<PasswordEditController>(PasswordEditController());
    Get.put<ProfilController>(ProfilController());
    Get.put<AdvertSearchController>(AdvertSearchController());
    Get.put<SettingsController>(SettingsController());
    Get.put<NotificationController>(NotificationController());
    Get.put<LocaleNotificationController>(LocaleNotificationController());
    Get.put<ThreadController>(ThreadController());
  }
}

