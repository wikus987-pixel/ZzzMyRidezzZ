import 'package:flutter/material.dart';
import 'package:ride_share_supa/services/paypal_service.dart';

class PayPalButton extends StatefulWidget {
  final String amount;
  final String currency;
  final String description;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final VoidCallback? onCancel;
  final Color buttonColor;
  final Color textColor;

  const PayPalButton({
    super.key,
    required this.amount,
    this.currency = 'USD',
    required this.description,
    this.onSuccess,
    this.onError,
    this.onCancel,
    this.buttonColor = const Color(0xFF0070BA), // PayPal Blue
    this.textColor = Colors.white,
  });

  @override
  State<PayPalButton> createState() => _PayPalButtonState();
}

class _PayPalButtonState extends State<PayPalButton> {
  bool _isLoading = false;

  void _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await PayPalService.processPayment(
        amount: widget.amount,
        currency: widget.currency,
        description: widget.description,
        context: context,
      );

      if (success) {
        widget.onSuccess?.call();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Payment Successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        widget.onError?.call();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('❌ Payment Failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      widget.onError?.call();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePayment,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonColor,
        disabledBackgroundColor: widget.buttonColor.withValues(alpha: 0.6),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.payment, color: widget.textColor),
                const SizedBox(width: 8),
                Text(
                  'Pay Now \$${widget.amount}',
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Alternative button style - Minimal design
class PayPalButtonMinimal extends StatefulWidget {
  final String amount;
  final String currency;
  final String description;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;

  const PayPalButtonMinimal({
    super.key,
    required this.amount,
    this.currency = 'USD',
    required this.description,
    this.onSuccess,
    this.onError,
  });

  @override
  State<PayPalButtonMinimal> createState() => _PayPalButtonMinimalState();
}

class _PayPalButtonMinimalState extends State<PayPalButtonMinimal> {
  bool _isLoading = false;

  void _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    final success = await PayPalService.processPayment(
      amount: widget.amount,
      currency: widget.currency,
      description: widget.description,
      context: context,
    );

    if (success) {
      widget.onSuccess?.call();
    } else {
      widget.onError?.call();
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _handlePayment,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0070BA),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                'PayPal - \$${widget.amount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
