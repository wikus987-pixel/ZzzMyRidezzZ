import '/backend/backend.dart';
import '/components/clean_compact_modern_widget.dart';
import '/components/metric_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_page_model.dart';
export 'admin_page_model.dart';

class AdminPageWidget extends StatefulWidget {
  const AdminPageWidget({
    super.key,
    this.getdata,
    this.getdata2,
  });

  final List<RidesRow>? getdata;
  final UsersRow? getdata2;

  static String routeName = 'AdminPage';
  static String routePath = 'adminPage';

  @override
  State<AdminPageWidget> createState() => _AdminPageWidgetState();
}

class _AdminPageWidgetState extends State<AdminPageWidget> {
  late AdminPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminPageModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderRadius: 30.0,
                buttonSize: 60.0,
              ),
                'Admin Options',
              ),
              elevation: 2.0,
            ),
                  child: Column(
                    children: [
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            ],
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 16.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                ),
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                                model: _model.metricCardModel1,
                                child: MetricCardWidget(
                                  label: 'Pending',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                                model: _model.metricCardModel2,
                                child: MetricCardWidget(
                                  label: 'Verified',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        ),
                      ),
                      SizedBox(
                        child: custom_widgets.BookingApprovalsList(
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        child: custom_widgets.CompletedRidesList(
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
            ),
      ),
  }
}
