import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dofd_user_panel/base/custom_button.dart';
import 'package:dofd_user_panel/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:dofd_user_panel/routes/route_helper.dart';
import 'package:dofd_user_panel/utils/colors.dart';
import 'package:dofd_user_panel/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controller.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  _PickAddressMapState createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
          body: SafeArea(
              child: Center(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 17,
                ),
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                onCameraIdle: () {
                  Get.find<LocationController>()
                      .updatePosition(_cameraPosition, false);
                },
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                },
              ),
              Center(
                child: !locationController.loading
                    ? Image.asset(
                        "assets/image/pick_marker.png",
                        height: 50,
                        width: 50,
                      )
                    : CircularProgressIndicator(),
              ),
              /*
              showing and selecting address
               */
              Positioned(
                top: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20,
                child: InkWell(
                  onTap: () => Get.dialog(
                      LocationDialogue(mapController: _mapController)),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30 / 3)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: AppColors.yellowColor,
                        ),
                        Expanded(
                            child: Text(
                          '${locationController.pickPlacemark.name ?? ''}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Icon(
                          Icons.search,
                          size: 25,
                          color: AppColors.yellowColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 80,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: locationController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          buttonText: locationController.inZone
                              ? widget.fromAddress
                                  ? 'Pick Address'
                                  : 'Pick Location'
                              : 'Service is not available in your area',
                          onPressed: (locationController.loading ||
                                  locationController.buttonDisabled)
                              ? null
                              : () {
                                  if (locationController
                                              .pickPosition.latitude !=
                                          0 &&
                                      locationController.pickPlacemark.name !=
                                          null) {
                                    if (widget.fromAddress) {
                                      if (widget.googleMapController != null) {
                                        widget.googleMapController!.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(
                                                        locationController
                                                            .pickPosition
                                                            .latitude,
                                                        locationController
                                                            .pickPosition
                                                            .longitude))));
                                        locationController.setAddressData();
                                      }
                                      //Get.back() creates update problem
                                      //list, a value
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    }
                                  }
                                },
                        ))
            ],
          ),
        ),
      )));
    });
  }
}
