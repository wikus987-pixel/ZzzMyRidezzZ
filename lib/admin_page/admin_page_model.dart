import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/components/metric_card_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'admin_page_widget.dart' show AdminPageWidget;
import 'package:flutter/material.dart';

class AdminPageModel extends FlutterFlowModel<AdminPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MetricCard.
  late MetricCardModel metricCardModel1;
  // Model for MetricCard.
  late MetricCardModel metricCardModel2;
  // State field(s) for Switch widget.
  bool? switchValue;

  // Streams for stable connections
  Stream<List<VerifiedPaymentsRow>>? pendingMetricsStream;
  Stream<List<VerifiedPaymentsRow>>? verifiedMetricsStream;
  Stream<List<UsersRow>>? deleteRequestsStream;

  @override
  void initState(BuildContext context) {
    metricCardModel1 = createModel(context, () => MetricCardModel());
    metricCardModel2 = createModel(context, () => MetricCardModel());
  }

  @override
  void dispose() {
    metricCardModel1.dispose();
    metricCardModel2.dispose();
  }
}
