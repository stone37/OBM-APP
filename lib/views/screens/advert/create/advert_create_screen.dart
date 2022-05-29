import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/utils/advert_field_state.dart';
import 'package:obm_market/utils/dialog_data.dart';
import 'package:obm_market/views/screens/menu/menu_screen.dart';
import 'package:obm_market/views/widgets/advert/advert_create_category_view.dart';
import 'package:obm_market/views/widgets/message/voidMessage.dart';
import '../../../../utils/avert_data.dart';
import '../../../common/btn_bulk.dart';
import '../../../common/form_advert_data.dart';
import '../../../widgets/advert/form/advert_create_form.dart';
import '../../../widgets/advert/form/advert_create_image.dart';
import '../../../widgets/stepper/stepper.dart';

class AdvertCreateScreen extends StatelessWidget {

  final AdvertCreateController controller = Get.put<AdvertCreateController>(AdvertCreateController());
  final CategoryController categoryController = Get.find();
  final MenuController menuController = Get.find();
  final List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          toolbarHeight: 60.0,
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Déposer une annonce',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
          //leadingWidth: 45.0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            splashRadius: 20.0,
            onPressed: () {
              DialogData().dialogText(
                title: 'Voulez vous quittez ?',
                content: 'Toute vos modifications seront perdues.',
                onContinue: () {
                  Navigator.pop(context);
                  controller.clear();

                  Get.off(() => MenuScreen());
                },
                onCancel: () {
                  Navigator.pop(context);
                }
              );
            },
          ),
        ),
        body: Container(
          color: AppTheme.background,
          child: Obx(() => WillPopScope(
            onWillPop: () async {
              return await _showDialog(context);
            },
            child: StepProgress(
              curStep: controller.activeStepIndex.value,
              steppers: stepList(context, controller, categoryController, menuController),
            )
          ))
        ),
    );
  }

  List<StepItem> stepList(
    BuildContext context,
    AdvertCreateController controller,
    CategoryController categoryController,
    MenuController menuController) => [
      StepItem(
      title: 'Catégories',
      number: '1',
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 30.0, bottom: 3.0),
              child: Text(
                'Commencez par choisir une catégorie',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.categories?.length,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return AdvertCategoryView(
                  category: categoryController.categories![index],
                  controller: controller,
                );
              }
            ),
          ],
        ),
      ),
      StepItem(
        title: 'Infos',
        number: '2',
        content: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 30.0, bottom: 3.0),
              child: Text(
                'Complètez les détails de votre annonces',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3
                ),
              ),
            ),
            Form(
              key: _formKeys[0],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  (controller.categoryParent.value.slug == 'acheter-et-vendre') ?
                    TypeExtendFielData(controller: controller) :
                    TypeFielData(controller: controller), // Type Field

                  SizedBox(height: 15.0),
                  TitleFieldData(controller: controller), // Title Field
                  SizedBox(height: 12.0),
                  DescriptionFielData(controller: controller), // Description Field
                  SizedBox(height: 12.0),
                  CityFieldData(controller: controller), // City Field
                  SizedBox(height: 12.0),
                  ZoneFieldData(controller: controller), // Zone Field
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0),
                    child: FormInputNoData(
                      title: 'Numéro de telephone',
                      content: '0140075681',
                      icon: Icons.phone,
                      helpText: 'Votre numéro de telephone apparaitra dans votre annonce.',
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: FormInputNoData(
                      title: 'Adresse e-mail',
                      content: 'stonedev@yahoo.com',
                      icon: Icons.email,
                      helpText: 'Votre adresse e-mail ne sera pas communiquée à des tiers.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.43,
                          child: PageButton(
                            text: 'Retour',
                            textColor: AppTheme.primary,
                            backgroundColor: AppTheme.white,
                            borderColor: AppTheme.primary,
                            callback: () {
                              if (controller.activeStepIndex.value == 1) {
                                return;
                              }

                              controller.activeStepIndex.value--;
                              controller.clear();
                            }
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.43,
                          child: PageButton(
                            text: 'Suivant',
                            textColor: AppTheme.white,
                            backgroundColor: AppTheme.primary,
                            borderColor: AppTheme.primary,
                            callback: () {
                              (controller.type.value.isEmpty) ?
                                controller.typeValidatorState.value = 'error' :
                                controller.typeValidatorState.value = '';

                              (controller.city.value.isEmpty) ?
                                controller.cityValidatorState.value = 'error' :
                                controller.cityValidatorState.value = '';

                              if (_formKeys[0].currentState!.validate() &&
                                  controller.type.value.isNotEmpty &&
                                  controller.city.value.isNotEmpty) {
                                controller.activeStepIndex.value++;
                              }
                            }
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    ),
    StepItem(
      title: 'Critères',
      number: '3',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 3.0, left: 13.0),
            child: Text(
              'Remplisez les critères',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3
              ),
            ),
          ),
          Form(
            key: _formKeys[1],
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                PriceFieldData(controller: controller), // Price Field
                SizedBox(height: 12),
                if (controller.categoryParent.value.slug == 'acheter-et-vendre')
                  Column(
                    children: <Widget>[
                      StateFielData(controller: controller), // State Field
                      SizedBox(height: 12),
                      if (AdvertCreateFieldState(controller: controller).brandState())
                        BrandFieldData(controller: controller), // Brand Field
                      TraitementFieldData(controller: controller), // Traitement Field
                      SizedBox(height: 12),
                    ],
                  ),

                if (controller.categoryParent.value.slug == 'auto-moto')
                  Column(
                    children: <Widget>[
                      if (AdvertCreateFieldState(controller: controller).marqueState())
                        MarqueFieldData(controller: controller), // Marque Field

                      if (AdvertCreateFieldState(controller: controller).modelState())
                        ModelFieldData(controller: controller),// Model Field

                      if (AdvertCreateFieldState(controller: controller).modelTextState())
                        ModelTextFieldData(controller: controller),// Model Text Field

                      if (AdvertCreateFieldState(controller: controller).autoYearState())
                        AutoYearFieldData(controller: controller), // Year Field

                      if (AdvertCreateFieldState(controller: controller).autoTypeState())
                        AutoTypeFieldData(controller: controller),// Auto Type Field

                      if (AdvertCreateFieldState(controller: controller).autoStateState())
                      AutoStateFieldData(controller: controller),// Auto State Field

                      if (AdvertCreateFieldState(controller: controller).kiloState())
                        KiloFieldData(controller: controller), // Kilometrage Field

                      if (AdvertCreateFieldState(controller: controller).cylindreState())
                        CylindreFieldData(controller: controller), // Cylindree Field

                      if (AdvertCreateFieldState(controller: controller).boiteVitesseState())
                        BoiteVitesseFieldData(controller: controller), // Boite vitesse Field

                      if (AdvertCreateFieldState(controller: controller).transmissionState())
                        TransmissionFieldData(controller: controller), // Transmission Field

                      if (AdvertCreateFieldState(controller: controller).colorState())
                        ColorFieldData(controller: controller), // Color Field

                      if (AdvertCreateFieldState(controller: controller).typeCarburantState())
                        TypeCarburantFieldData(controller: controller), // Type carburant Field

                      if (AdvertCreateFieldState(controller: controller).nombrePorteState())
                        NombrePorteFieldData(controller: controller), // Nombre porte Field

                      if (AdvertCreateFieldState(controller: controller).nombrePlaceState())
                        NombrePlaceFieldData(controller: controller), // Nombre de place Field

                      if (AdvertCreateFieldState(controller: controller).autreInformationState())
                        AutreInformationFieldData(controller: controller, data: AdvertCreateData().autreInformationList), // Autre information Field

                      if (AdvertCreateFieldState(controller: controller).autoSecurityState())
                        AutoSecurityFieldData(controller: controller, data: AdvertCreateData().autoSecurity), // Auto security Field

                      if (AdvertCreateFieldState(controller: controller).informationExtState())
                        InformationExtFieldData(controller: controller, data: AdvertCreateData().informationExt), // Information ext Field
                    ],
                  ),

                if (controller.categoryParent.value.slug == 'immobilier')
                  Column(
                    children: <Widget>[
                      if (AdvertCreateFieldState(controller: controller).surfaceState())
                        SurfaceFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).nombrePieceState())
                        NombrePieceFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).nombreChambreState())
                        NombreChambreFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).nombreSalleState())
                        NombreSalleBainFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).immoStateState())
                        ImmobilierStateFielData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).surfaceBalconState())
                        SurfaceBalconFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).nombrePlacardState())
                        NombrePlacardFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).dateConstructionState())
                        DateConstructionFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).cuisineState())
                        CuisineFieldData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).standingState())
                        StandingFielData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).situationState())
                        SituationFielData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).salleMangerState())
                        SalleMangerFielData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).etatGeneralState())
                        StateGeneraleFielData(controller: controller),

                      if (AdvertCreateFieldState(controller: controller).accessState())
                        AccesFieldData(controller: controller, data: AdvertCreateData().accessList),

                      if (AdvertCreateFieldState(controller: controller).exteriorState())
                        ExteriorFieldData(controller: controller, data: AdvertCreateData().exteriorList),

                      if (AdvertCreateFieldState(controller: controller).interiorState())
                        InteriorFieldData(controller: controller, data: AdvertCreateData().interiorList),

                      if (AdvertCreateFieldState(controller: controller).typeSolState())
                        TypeSolFieldData(controller: controller, data: AdvertCreateData().typeSolList),

                      if (AdvertCreateFieldState(controller: controller).serviceInclusState())
                        ServiceInclusFieldData(controller: controller, data: AdvertCreateData().serviceInclusList),

                      if (AdvertCreateFieldState(controller: controller).proximiteState())
                        ProximiteFieldData(controller: controller, data: AdvertCreateData().proximiteList),

                      if (AdvertCreateFieldState(controller: controller).facadeState())
                        FacadeFieldData(controller: controller, data: AdvertCreateData().facadeList),

                      if (AdvertCreateFieldState(controller: controller).toitureState())
                        ToitureFieldData(controller: controller, data: AdvertCreateData().toitureList),
                    ]
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.43,
                        child: PageButton(
                          text: 'Retour',
                          textColor: AppTheme.primary,
                          backgroundColor: AppTheme.white,
                          borderColor: AppTheme.primary,
                          callback: () {
                            if (controller.activeStepIndex.value == 1) {
                              return;
                            }

                            controller.activeStepIndex.value--;
                          }
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.43,
                        child: PageButton(
                          text: 'Suivant',
                          textColor: AppTheme.white,
                          backgroundColor: AppTheme.primary,
                          borderColor: AppTheme.primary,
                          callback: () {

                            int validator = 0;

                            if (controller.categoryParent.value.slug == 'acheter-et-vendre') {
                              if (controller.state.value.isEmpty) {
                                controller.stateValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.stateValidatorState.value = '';
                              }
                            }
                            
                            if (AdvertValidateFieldState(controller: controller).marqueState()) {
                              if (controller.marque.value.isEmpty) {
                                controller.marqueValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.marqueValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).brandState()) {
                              if (controller.brand.value.isEmpty) {
                                controller.brandValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.brandValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).modelState()) {
                              if (controller.model.value.isEmpty) {
                                controller.modelValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.modelValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).autoYearState()) {
                              if (controller.autoYear.value.isEmpty) {
                                controller.autoYearValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.autoYearValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).autoTypeState()) {
                              if (controller.autoType.value.isEmpty) {
                                controller.autoTypeValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.autoTypeValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).autoStateState()) {
                              if (controller.autoState.value.isEmpty) {
                                controller.autoStateValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.autoStateValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).nombrePieceState()) {
                              if (controller.nombrePiece.value.isEmpty) {
                                controller.nombrePieceValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.nombrePieceValidatorState.value = '';
                              }
                            }

                            if (AdvertValidateFieldState(controller: controller).immoStateState()) {
                              if (controller.immobilierState.value.isEmpty) {
                                controller.immobilierStateValidatorState.value = 'error';
                                validator++;
                              } else {
                                controller.immobilierStateValidatorState.value = '';
                              }
                            }

                            print(validator);

                            if (_formKeys[1].currentState!.validate() && (validator == 0)) {
                              controller.activeStepIndex.value++;
                            }
                          }
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ]
      )
    ),
    StepItem(
        title: 'Images',
        number: '4',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 3.0, left: 13.0, right: 13.0),
              child: Text(
                'Ajoutez vos photos pour rendre votre annonce encore plus visible (facultatif)',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, right: 15.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                  onTap: () {
                    showVoidMessage('Vous pouvez ajouter gratuitement vos photos plus tart en quelques secondes.');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.5, right: 2.0),
                        child: Icon(FontAwesomeIcons.questionCircle, color: AppTheme.primary, size: 15.0),
                      ),
                      Text(
                        'Pas de photos sous la main',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primary,
                          letterSpacing: 0.3,
                          decoration: TextDecoration.underline
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
              child: PageButton(
                text: 'Telecharger des photos',
                textColor: AppTheme.white,
                backgroundColor: AppTheme.primary,
                borderColor: AppTheme.primary,
                elevation: 2.0,
                overlay: false,
                icon: FontAwesomeIcons.cameraRetro,
                iconPosition: 'left',
                callback: () async {
                  controller.addImage();
                },
              ),
            ),
            Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.images.length > 0)
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List<Widget>.generate(
                      controller.images.length,
                        (int index) {
                          return AdvertCreateImage(
                            controller: controller,
                            image: controller.images[index],
                            index: index
                          );
                        }
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.9,
                    ),
                  )
              ],
            )),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: PageButton(
                      text: 'Retour',
                      textColor: AppTheme.primary,
                      backgroundColor: AppTheme.white,
                      borderColor: AppTheme.primary,
                      callback: () {
                        if (controller.activeStepIndex.value == 1) {
                          return;
                        }

                        controller.activeStepIndex.value--;
                      }
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.48,
                    child: PageButton(
                      text: 'Valider',
                      textColor: AppTheme.white,
                      backgroundColor: AppTheme.success_color,
                      borderColor: AppTheme.success_color,
                      iconPosition: 'right',
                      icon: FontAwesomeIcons.solidPaperPlane,
                      callback: () async {
                        final bool response = await controller.add();

                        if (response) {
                          controller.activeStepIndex.value++;
                        }
                      }
                    ),
                  )
                ],
              ),
            )
          ],
        )
    ),
    StepItem(
        title: 'Succès',
        number: '5',
        content: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0, right: 15.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.5, right: 5.0),
                    child: Icon(FontAwesomeIcons.solidCheckCircle, color: AppTheme.success_color, size: 27.0),
                  ),
                  Text(
                    'Votre annonce a été enregistrée',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkerText,
                      letterSpacing: 0.3
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 3.0, left: 13.0, right: 13.0),
              child: Text(
                'Votre annonce est cours de validation, elle sera validée par notre équipe en moins de 20 munites, vous recevrez une notification lorsqu\'elle sera approuvéé.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.dark_grey,
                  letterSpacing: 0.3
                ),
              ),
            ),
            SizedBox(height: 33.0),
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.44,
                    child: PageButton(
                      text: 'Accueil',
                      textColor: AppTheme.primary,
                      backgroundColor: AppTheme.white,
                      borderColor: AppTheme.primary,
                      callback: () {
                        controller.clear();
                        menuController.goToHome();
                        Get.off(() => MenuScreen());
                      }
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.44,
                    child: PageButton(
                      text: 'Mes annonces',
                      textColor: AppTheme.white,
                      backgroundColor: AppTheme.primary,
                      borderColor: AppTheme.primary,
                      callback: () {
                        controller.clear();
                        menuController.goToAdvert();
                        Get.off(() => MenuScreen());
                      }
                    ),
                  )
                ],
              ),
            )
          ],
        )
    )
  ];


  /*Widget _cityFormData(AdvertCreateController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Choisir une ville',
            content: (controller.city.value.isEmpty) ?
            Text(
              'Choisir une ville',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.city.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            icon: Icons.location_on,
            onTap: () {
              Get.to(() => AdvertCityScreen());
            },
          ),
          (controller.cityValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez choisir une ville.',
              style: TextStyle(
                  fontSize: 11.6,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }*/

  Future _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Voulez vous quittez ?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkerText,
                letterSpacing: 0.3
              ),
            ),
            content: Text(
              'Toute vos modifications seront perdues.',
              style: TextStyle(
                fontSize: 15.5,
                color: AppTheme.darkerText,
                letterSpacing: 0.3
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Rester'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkerText
                  ),
                )
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.clear();

                  Get.off(() => MenuScreen());
                },
                child: Text(
                  'Quitter'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkerText
                  ),
                )
              )
            ],
          );
        }
    );
  }

}




