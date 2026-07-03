import '/backend/backend.dart';
import '/components/ride_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'edit_profile_page_widget.dart' show EditProfilePageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfilePageModel extends FlutterFlowModel<EditProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for RideItem.
  late FlutterFlowDynamicModels<RideItemModel> rideItemModels;

  @override
  void initState(BuildContext context) {
    rideItemModels = FlutterFlowDynamicModels(() => RideItemModel());
  }

  @override
  void dispose() {
    rideItemModels.dispose();
  }
}
