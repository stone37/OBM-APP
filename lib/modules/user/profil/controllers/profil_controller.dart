import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/advert/repository/advert_repository.dart';
import 'package:obm_market/modules/auth/repository/user_repository.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';

import '../../../../views/widgets/message/errorMessage.dart';

class ProfilController extends GetxController {

  final box = GetStorage();
  late ImagePicker imagePicker;
  RxString photoProfil = ''.obs;

  @override
  void onInit() {
    super.onInit();

    imagePicker = ImagePicker();
  }

  Future<List<Advert>> getAdvertEnabled() async {
    return AdvertRepository().getUserAdvertEnabled(id: box.read('user_id'), token: box.read('token'));
  }

  changeProfilImage() async {
    final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (File(file!.path).readAsBytesSync().lengthInBytes > 8388608) {
      showErrorMessage('L\'image est trop volumineuse (supérieur a 8Mo).');
    } else {
      final response = await UserRepository().upload(id: box.read('user_id'), token: box.read('token'), image: file);

      if (response.status == '201') {
        photoProfil.value = response.imageUrl;
        await box.write('user_file', response.imageUrl);

        showSuccessMessage(message: 'Votre photo de profil a bien été modifier');
      }
    }
  }
}

