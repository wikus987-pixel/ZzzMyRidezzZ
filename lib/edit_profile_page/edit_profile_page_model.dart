import 'package:ride_share_supa/components/ride_item_model.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_page_widget.dart' show EditProfilePageWidget;
import 'package:flutter/material.dart';

class EditProfilePageModel extends FlutterFlowModel<EditProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for RideItem.
  late FlutterFlowDynamicModels<RideItemModel> rideItemModels;

  // Delete account state
  bool isDeleting = false;

  @override
  void initState(BuildContext context) {
    rideItemModels = FlutterFlowDynamicModels(() => RideItemModel());
  }

  @override
  void dispose() {
    rideItemModels.dispose();
  }
}
