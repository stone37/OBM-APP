import 'package:obm_market/modules/advert/models/entities/categoryPremium.dart';
import 'package:obm_market/modules/advert/services/remote_category_premiun_api.dart';

class CategoryPremiumRepository {

  Future<List<CategoryPremium>> getPremiums() {
    return RemoteCategoryPremiumApi
        .getPremiums()
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
