import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/advert/models/request/category_request.dart';
import 'package:obm_market/modules/advert/services/remote_category_api.dart';

class CategoryRepository {

  Future<List<Category>> getCategories() {
    return RemoteCategoryApi
        .getCategories()
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<Category> getCategory({required int id}) {
    return RemoteCategoryApi.getCategory(CategoryRequest(id: id))
        .then((value) => value!.toEntity());
  }
}

