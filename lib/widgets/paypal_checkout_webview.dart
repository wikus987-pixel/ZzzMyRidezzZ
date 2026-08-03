import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Result of a PayPal checkout attempt via the in-app WebView.
class PayPalCheckoutResult {
  final bool success;
  final String? orderId;
  final String? errorMessage;

  const PayPalCheckoutResult({
    required this.success,
    this.orderId,
    this.errorMessage,
  });
}

/// Opens the PayPal approve URL inside an in-app WebView, listens for the
/// `ridesharel://paypalpay?token=...&PayerID=...` deep-link redirect (or the
/// cancel variant), then resolves with the order ID.
///
/// The caller is expected to call `PayPalService.captureOrder(orderId)`
/// after a success, so the server actually charges the card.
class PayPalCheckoutWebView extends StatefulWidget {
  final String approveUrl;
  final String returnScheme; // e.g. "ridesharel"
  final void Function(String orderId) onSuccess;
  final VoidCallback onCancel;
  final void Function(String error) onError;

  const PayPalCheckoutWebView({
    super.key,
    required this.approveUrl,
    this.returnScheme = "ridesharel",
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<PayPalCheckoutWebView> createState() => _PayPalCheckoutWebViewState();
}

class _PayPalCheckoutWebViewState extends State<PayPalCheckoutWebView> {
  late final WebViewController _controller;
  bool _handled = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _loading = true);
            _maybeHandle(url);
          },
          onPageFinished: (url) {
            setState(() => _loading = false);
            _maybeHandle(url);
          },
          onWebResourceError: (error) {
            // Soft-fail; navigation errors during redirects are common
            // and not necessarily fatal. Real failures come through the
            // redirect URL with error params.
            debugPrint('PayPal WebView resource error: ${error.description}');
          },
          onNavigationRequest: (request) {
            final url = request.url;
            if (_isReturnUrl(url)) {
              _handleReturnUrl(url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.approveUrl));
  }

  bool _isReturnUrl(String url) {
    return url.startsWith('${widget.returnScheme}://');
  }

  void _maybeHandle(String url) {
    if (_isReturnUrl(url)) _handleReturnUrl(url);
  }

  void _handleReturnUrl(String url) {
    if (_handled) return;
    _handled = true;

    final uri = Uri.parse(url);

    // Cancel path: ridesharel://paypalpay?cancel=1
    if (uri.queryParameters['cancel'] == '1') {
      widget.onCancel();
      return;
    }

    // PayPal appends the order id as `token`. Older integrations used
    // `orderId` / `paymentId` — accept both just in case.
    final orderId =
        uri.queryParameters['token'] ??
        uri.queryParameters['orderId'] ??
        uri.queryParameters['paymentId'];

    if (orderId == null || orderId.isEmpty) {
      widget.onError('No order id in return URL: $url');
      return;
    }

    widget.onSuccess(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!_handled) widget.onCancel();
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
