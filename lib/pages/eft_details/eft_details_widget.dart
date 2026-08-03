import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'eft_details_model.dart';
export 'eft_details_model.dart';

import 'package:flutter/services.dart';

class EftDetailsWidget extends StatefulWidget {
  const EftDetailsWidget({super.key});

  static String routeName = 'EftDetails';
  static String routePath = 'eftDetails';

  @override
  State<EftDetailsWidget> createState() => _EftDetailsWidgetState();
}

class _EftDetailsWidgetState extends State<EftDetailsWidget> {
  late EftDetailsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EftDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text.replaceAll(' ', '')));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: Text(
          'EFT Payment Details',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.interTight(),
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bank Account Details',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.interTight(),
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildAccountCard(
                  bankName: 'FNB (First National Bank)',
                  accName: 'IMIT Respond',
                  accNumber: '6321 6401 173',
                  branchCode: '250655',
                  accType: 'Current Account',
                ),
                const SizedBox(height: 16),
                _buildEmailInstruction('Registration Fee'),
                const SizedBox(height: 24),
                _buildAccountCard(
                  bankName: 'Capitec Bank',
                  accName: 'IMIT Respond',
                  accNumber: '2488 3444 07',
                  branchCode: '470010',
                  accType: 'Savings/Current',
                ),
                const SizedBox(height: 16),
                _buildEmailInstruction('Booking Payment'),
                const SizedBox(height: 48),
                Text(
                  'Card Payments Temporarily Under Maintenance',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We apologize for any inconvenience caused.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 32),
                FFButtonWidget(
                  onPressed: () => context.safePop(),
                  text: 'Back',
                  options: FFButtonOptions(
                    height: 50,
                    color: FlutterFlowTheme.of(context).alternate,
                    textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInstruction(String type) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent2.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).secondary, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'E-mail proof of payment for $type to:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => _copyToClipboard('rideshare8855@gmail.com', 'Email'),
            child: Text(
              'rideshare8855@gmail.com',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard({
    required String bankName,
    required String accName,
    required String accNumber,
    required String branchCode,
    String? accType,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankName,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.interTight(),
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
            const Divider(height: 24, thickness: 1),
            _row('Account Holder:', accName),
            _row('Account Number:', accNumber, canCopy: true),
            _row('Branch Code:', branchCode, canCopy: true),
            if (accType != null) _row('Account Type:', accType),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool canCopy = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label, 
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(),
                  fontWeight: FontWeight.w600,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (canCopy) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _copyToClipboard(value, label.replaceAll(':', '')),
                  child: Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
