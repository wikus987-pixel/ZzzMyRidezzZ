import 'package:ride_share_supa/backend/backend.dart';
import 'package:ride_share_supa/index.dart';
import 'package:ride_share_supa/components/clean_compact_modern_widget.dart';
import 'package:ride_share_supa/components/metric_card_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_icon_button.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:ride_share_supa/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'dart:async';
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

    _initializeStreams();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initializeStreams() {
    // Initialize stable metrics streams with a small delay to prevent socket congestion
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _model.pendingMetricsStream = SupaFlow.client
            .from('verified_payments')
            .stream(primaryKey: ['id']).map((r) => r
                .map((e) => VerifiedPaymentsRow(e))
                .where((e) => e.verified == false)
                .toList());

        _model.verifiedMetricsStream = SupaFlow.client
            .from('verified_payments')
            .stream(primaryKey: ['id']).map((r) => r
                .map((e) => VerifiedPaymentsRow(e))
                .where((e) => e.verified == true)
                .toList());

        _model.deleteRequestsStream = SupaFlow.client
            .from('users')
            .stream(primaryKey: ['id'])
            .eq('deletion_requested', true)
            .map((r) => r.map((e) => UsersRow(e)).toList());
      });
    });
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(PaymentPageWidget.routeName);
                              },
                              text: 'Test Payments',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                      color: Colors.white,
                                    ),
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            const SizedBox(width: 12),
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
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<List<VerifiedPaymentsRow>>(
                            stream: _model.pendingMetricsStream ?? const Stream.empty(),
                            builder: (context, snapshot) {
                               if (snapshot.hasError) {
                                 return _buildErrorCard('Error', () => _initializeStreams());
                               }
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
                            stream: _model.verifiedMetricsStream ?? const Stream.empty(),
                            builder: (context, snapshot) {
                               if (snapshot.hasError) {
                                 return _buildErrorCard('Error', () => _initializeStreams());
                               }
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
                        key: const ValueKey('pending_registrations'),
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                        verified: false,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Confirmed Registrations'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.PendingApprovalsList(
                        key: const ValueKey('confirmed_registrations'),
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                        verified: true,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Ride Bookings Queue'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.BookingApprovalsList(
                        key: const ValueKey('pending_bookings'),
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                        status: 'Pending',
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Confirmed Ride Bookings'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.BookingApprovalsList(
                        key: const ValueKey('confirmed_bookings'),
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                        status: 'Booked',
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
                    const SizedBox(height: 32),
                    _buildSectionTitle('Completed & Paid Rides (History)'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.PaidRidesList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Active Rides Management'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.AdminActiveRidesList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Ride Requests Management'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: custom_widgets.AdminReqRidesList(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Delete Account Requests'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: _buildDeleteRequestsList(),
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

  Widget _buildDeleteRequestsList() {
    return StreamBuilder<List<UsersRow>>(
      stream: _model.deleteRequestsStream ?? const Stream.empty(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Connection lost'),
                TextButton(
                  onPressed: () => _initializeStreams(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final requests = snapshot.data ?? [];
        if (requests.isEmpty) {
          return const Center(
            child: Text('No pending delete requests'),
          );
        }
        
        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return _buildDeleteRequestItem(request);
          },
        );
      },
    );
  }

  Widget _buildDeleteRequestItem(UsersRow user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          '${user.firstName} ${user.surname}',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600),
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user.email ?? 'N/A'}'),
            Text(
              'Requested: ${user.accountCreatedDate != null ? '${user.accountCreatedDate!.day}/${user.accountCreatedDate!.month}/${user.accountCreatedDate!.year}' : 'Unknown'}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              tooltip: 'Approve Deletion',
              onPressed: () => _approveDeleteRequest(user.uid),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              tooltip: 'Reject Deletion',
              onPressed: () => _rejectDeleteRequest(user.uid),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _approveDeleteRequest(String uid) async {
    try {
      await UsersTable().delete(
        matchingRows: (q) => q.eq('uid', uid),
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deletion approved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve deletion: $e')),
        );
      }
    }
  }

  Future<void> _rejectDeleteRequest(String uid) async {
    try {
      await UsersTable().update(
        data: {'deletion_requested': false},
        matchingRows: (q) => q.eq('uid', uid),
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deletion request rejected')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reject deletion: $e')),
        );
      }
    }
  }

  Widget _buildErrorCard(String message, VoidCallback onRetry) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FlutterFlowTheme.of(context).error.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: FlutterFlowTheme.of(context).error, size: 24),
          const SizedBox(height: 4),
          Text(message, style: TextStyle(color: FlutterFlowTheme.of(context).error, fontSize: 12)),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 30)),
            child: const Text('Retry', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
