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
      title: 'Admin Options',
      color: FlutterFlowTheme.of(context).primary,
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
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30.0),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Admin Options',
              style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 2.0,
          ),
          body: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dashboard', style: FlutterFlowTheme.of(context).headlineSmall),
                            Text('Payment Approvals Portal', style: FlutterFlowTheme.of(context).labelMedium),
                          ],
                        ),
                        FlutterFlowIconButton(
                          borderRadius: 16.0,
                          buttonSize: 40.0,
                          fillColor: FlutterFlowTheme.of(context).primary,
                          icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24.0),
                          onPressed: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: const CleanCompactModernWidget(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<List<VerifiedPaymentsRow>>(
                            stream: SupaFlow.client.from('verified_payments').stream(primaryKey: ['id']).map((r) => r.map((e) => VerifiedPaymentsRow(e)).where((e) => e.verified == false).toList()),
                            builder: (context, snapshot) {
                               return wrapWithModel(
                                model: _model.metricCardModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: MetricCardWidget(
                                  label: 'Pending',
                                  value: (snapshot.data?.length ?? 0).toString(),
                                  tone: FlutterFlowTheme.of(context).warning,
                                  icon: const Icon(Icons.hourglass_empty_rounded),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StreamBuilder<List<VerifiedPaymentsRow>>(
                            stream: SupaFlow.client.from('verified_payments').stream(primaryKey: ['id']).map((r) => r.map((e) => VerifiedPaymentsRow(e)).where((e) => e.verified == true).toList()),
                            builder: (context, snapshot) {
                               return wrapWithModel(
                                model: _model.metricCardModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: MetricCardWidget(
                                  label: 'Verified',
                                  value: (snapshot.data?.length ?? 0).toString(),
                                  tone: FlutterFlowTheme.of(context).success,
                                  icon: const Icon(Icons.check_circle_outline_rounded),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('User Verification Queue'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.PendingApprovalsList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Ride Bookings Queue'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.BookingApprovalsList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Completed Rides (Payouts)'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.CompletedRidesList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: FlutterFlowTheme.of(context).titleMedium.override(
              font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
            ),
      ),
    );
  }
}
