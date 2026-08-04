import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class YocoRegistrationButton extends StatefulWidget {
  final String email;
  final VoidCallback onSuccess;

  const YocoRegistrationButton({
    super.key,
    required this.email,
    required this.onSuccess,
  });

  @override
  State<YocoRegistrationButton> createState() => _YocoRegistrationButtonState();
}

class _YocoRegistrationButtonState extends State<YocoRegistrationButton> {
  bool _isLoading = false;

  Future<void> _handleYocoPayment() async {
    final email = widget.email.trim().toLowerCase();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address first.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    int? recordId;
    try {
      // 1. Create the pending record in Supabase
      final insertedRows = await VerifiedPaymentsTable().insert({
        'Email': email,
        'verified': false,
        'status': 'yoco_pending',
      });
      
      if (insertedRows != null) {
        recordId = insertedRows.id;
      }

      // 2. Call Yoco Checkout Function
      final response = await SupaFlow.client.functions.invoke(
        'yoco-checkout-registration',
        body: {
          'amount_in_cents': 4500, // R45.00
          'currency': 'ZAR',
          'reference': 'Reg_$email',
          'description': 'RideShare Registration Fee ($email)',
          'customer_email': email,
        },
      );

      if (response.status != 200) {
        throw Exception('Failed to create checkout: ${response.data}');
      }

      final data = response.data;
      final redirectUrl = data['redirect_url'] as String?;

      if (redirectUrl == null || redirectUrl.isEmpty) {
        throw Exception('No redirect URL returned from Yoco');
      }

      if (!mounted) return;

      // 3. Open WebView for Payment
      final success = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final controller = WebViewController()
            ..setJavaScriptMode(JavascriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (NavigationRequest request) {
                  final url = request.url.toLowerCase();
                  if (url.contains('yoco-success')) {
                    Navigator.of(context).pop(true);
                    return NavigationDecision.prevent;
                  } else if (url.contains('cancel') || url.contains('fail') || url.contains('error')) {
                    Navigator.of(context).pop(false);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(redirectUrl));

          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Secure Payment'),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 500,
                child: WebViewWidget(controller: controller),
              ),
            ),
          );
        },
      );

      // 4. Handle result
      if (success == true) {
        if (recordId != null) {
          await VerifiedPaymentsTable().update(
            data: {'verified': true, 'status': 'yoco_success'},
            matchingRows: (q) => q.eq('id', recordId!),
          );
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Fee Paid Successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onSuccess();
      } else {
        // Delete record if cancelled or failed
        if (recordId != null) {
          await VerifiedPaymentsTable().delete(
            matchingRows: (q) => q.eq('id', recordId!),
          );
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment cancelled or failed. Your registration request has been removed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('YOCO ERROR: $e');
      if (recordId != null) {
        await VerifiedPaymentsTable().delete(
          matchingRows: (q) => q.eq('id', recordId!),
        ).catchError((_) => null);
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FFButtonWidget(
        onPressed: _isLoading ? null : _handleYocoPayment,
        text: _isLoading ? 'Processing...' : 'Pay Registration (R45 via Yoco)',
        options: FFButtonOptions(
          width: double.infinity,
          height: 50,
          color: const Color(0xFF003087), // You can change this to a Yoco brand color
          textStyle: GoogleFonts.interTight(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
        ),
      ),
    );
  }
}
