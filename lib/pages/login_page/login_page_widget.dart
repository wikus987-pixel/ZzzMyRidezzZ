import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:ride_share_supa/services/paypal_service.dart';
import 'package:ride_share_supa/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ride_share_supa/widgets/yoco_registration_button.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'LoginPage';
  static String routePath = 'loginPage';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.emailAddressTextController ??= TextEditingController();
    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.emailAddressCreateTextController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();
    _model.passwordCreateTextController ??= TextEditingController();
    _model.passwordCreateFocusNode ??= FocusNode();
    _model.passwordConfirmTextController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      safeSetState(() {});
      if (loggedIn) {
        context.pushNamedAuth(HomePageWidget.routeName, true);
      }
      _loadRememberedCredentials();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  bool _isPaymentVerified = false;
  bool _checkingVerification = false;

  Future<void> _checkVerification() async {
    final email = _model.emailAddressCreateTextController.text.trim().toLowerCase();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email first.')),
      );
      return;
    }

    setState(() => _checkingVerification = true);
    try {
      final rows = await VerifiedPaymentsTable().queryRows(
        queryFn: (q) => q.eq('Email', email).eq('verified', true),
      );
      
      if (mounted) {
        setState(() {
          _isPaymentVerified = rows.isNotEmpty;
          _checkingVerification = false;
        });
        
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isPaymentVerified 
              ? 'Verification successful! You can now create your account.' 
              : 'Payment not yet verified. Please ensure you have emailed proof of payment.'),
            backgroundColor: _isPaymentVerified ? Colors.green : const Color(0xFFFFCC80),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _checkingVerification = false);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error checking verification: $e')),
        );
      }
    }
  }

  Future<void> _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('remember_me') ?? false;
    if (rememberMe) {
      final email = prefs.getString('saved_email') ?? '';
      final password = prefs.getString('saved_password') ?? '';
      if (email.isNotEmpty && password.isNotEmpty) {
        _model.emailAddressTextController.text = email;
        _model.passwordTextController.text = password;
        _model.rememberMeValue = true;
      }
    }
  }

  Future<void> _saveCredentials(String email, String password, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('saved_email', email);
      await prefs.setString('saved_password', password);
    } else {
      await prefs.remove('remember_me');
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'LoginPage',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'RideShare',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.interTight(
                              fontWeight: FontWeight.w900),
                          fontSize: 40.0,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1670285030808-a5d86b1525d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxjYXJzJTIwYW5pbWF0ZWR8ZW58MHx8fHwxNzgxMDc2MDM0fDA&ixlib=rb-4.1.0&q=80&w=1080',
                      width: 200.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: const Alignment(-1.0, 0),
                            child: TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              labelColor: FlutterFlowTheme.of(context).primary,
                              unselectedLabelColor: Colors.grey[400],
                              labelStyle: GoogleFonts.interTight(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              indicatorColor:
                                  FlutterFlowTheme.of(context).primary,
                              indicatorWeight: 3.0,
                              dividerColor: Colors.transparent,
                              tabs: const [
                                Tab(text: 'Sign In'),
                                Tab(text: 'Sign Up')
                              ],
                              controller: _model.tabBarController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 1200, 
                            child: TabBarView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _model.tabBarController,
                              children: [
                                _buildSignInTab(),
                                _buildSignUpTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormField(
            controller: _model.emailAddressTextController,
            decoration: _inputDecoration('E-mail Address', Icons.mail_outline),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordTextController,
            obscureText: !_model.passwordVisibility,
            decoration: _inputDecoration('Password', Icons.lock_outline).copyWith(
              suffixIcon: InkWell(
                onTap: () => setState(
                    () => _model.passwordVisibility = !_model.passwordVisibility),
                child: Icon(_model.passwordVisibility
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: _model.rememberMeValue ?? false,
                onChanged: (v) => setState(() => _model.rememberMeValue = v),
                activeColor: FlutterFlowTheme.of(context).primary,
              ),
              const Text('Remember me', style: TextStyle(fontSize: 14)),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final email = _model.emailAddressTextController.text.trim();
                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter your email address.')),
                    );
                    return;
                  }
                  await authManager.resetPassword(email: email, context: context);
                },
                child: const Text('Forgot Password?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: () async {
              final email = _model.emailAddressTextController.text;
              final password = _model.passwordTextController.text;
              final rememberMe = _model.rememberMeValue ?? false;
              final user = await authManager.signInWithEmail(context, email, password);
              if (user != null && mounted) {
                await _saveCredentials(email, password, rememberMe);
                if (!mounted) return;
                if (!context.mounted) return;
                context.pushNamedAuth(HomePageWidget.routeName, true);
              }
            },
            text: 'Sign In',
            options: _buttonOptions(),
          ),
          const SizedBox(height: 24),
          const Text('Or', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          FFButtonWidget(
            onPressed: () => authManager.signInWithGoogle(context),
            text: 'Continue with Google',
            icon: const Icon(Icons.login_rounded, color: Colors.white, size: 20),
            options: FFButtonOptions(
              width: double.infinity,
              height: 50,
              color: const Color(0xFF4285F4),
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _model.emailAddressCreateTextController,
            onChanged: (val) => EasyDebounce.debounce('signUpEmail',
                const Duration(milliseconds: 500), () => setState(() {})),
            decoration: _inputDecoration('E-mail Address', Icons.mail_outline),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordCreateTextController,
            obscureText: !_model.passwordCreateVisibility,
            decoration: _inputDecoration('Password', Icons.lock_outline),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordConfirmTextController,
            obscureText: !_model.passwordConfirmVisibility,
            decoration: _inputDecoration('Confirm Password', Icons.lock_outline),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FFButtonWidget(
                  onPressed: () async {
                    final email = _model.emailAddressCreateTextController.text.trim().toLowerCase();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your email first.')),
                      );
                      return;
                    }
                    
                    bool recorded = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registering your payment request...')),
                    );

                    try {
                      // Attempt to create the verification record immediately
                      await VerifiedPaymentsTable().insert({
                        'Email': email,
                        'verified': false,
                        'status': 'pending_payment',
                      });
                      recorded = true;
                      debugPrint('Signup Record Created: $email');
                    } catch (e) {
                      final errStr = e.toString().toLowerCase();
                      if (errStr.contains('duplicate') || errStr.contains('already exists')) {
                        recorded = true; 
                        debugPrint('Signup Record already exists for $email');
                      } else {
                        // If it's a real DB error (like RLS or Connection), we log it
                        debugPrint('Signup Record Database Error: $e');
                        // We still set recorded to true to try and allow the payment
                        recorded = true;
                      }
                    }
                    
                    if (!recorded) return;
                    if (!mounted) return;

                    final success = await PayPalService.processPayment(
                      amount: "2.50",
                      currency: "USD",
                      description: 'RideShare Registration Fee ($email)',
                      context: context,
                    );
                    
                    if (success) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Payment Successful! Once paid, email proof and tap "Check Verification Status".'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 8),
                      ));
                    }
                  },
                  text: 'PayPal',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: const Color(0xFF003087),
                    textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FFButtonWidget(
                  onPressed: null,
                  text: 'Card',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Colors.grey[300],
                    textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Card Payments under Maintenance',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(),
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () => context.pushNamed('EftDetails'),
              child: Text.rich(
                TextSpan(
                  text: 'If any issues with PayPal account payments, press ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                  children: [
                    TextSpan(
                      text: 'here',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' for temporary EFT payments.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FFButtonWidget(
            onPressed: _checkingVerification ? null : () => _checkVerification(),
            text: _checkingVerification ? 'Checking...' : 'Check Verification Status',
            options: FFButtonOptions(
              width: double.infinity,
              height: 50,
              color: FlutterFlowTheme.of(context).primary,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
            ),
          ),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: () => launchURL('mailto:rideshare8855@gmail.com?subject=Proof%20of%20Payment%20-%20${_model.emailAddressCreateTextController.text.trim()}'),
            text: 'Email Proof of Payment',
            options: FFButtonOptions(
              width: double.infinity,
              height: 50,
              color: FlutterFlowTheme.of(context).secondary,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
            ),
          ),
          const SizedBox(height: 24),
          if (_isPaymentVerified) _buildCreateAccountButton(),
          YocoRegistrationButton(
            email: _model.emailAddressCreateTextController.text,
            onSuccess: () => _checkVerification(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Once paid and verified, you can set your password here to complete registration.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    final email = _model.emailAddressCreateTextController.text.trim().toLowerCase();
    return FFButtonWidget(
      onPressed: () async {
        if (_model.passwordCreateTextController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a password')));
          return;
        }
        if (_model.passwordCreateTextController.text !=
            _model.passwordConfirmTextController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Passwords mismatch'))); 
          return;
        }
        final user = await authManager.createAccountWithEmail(
            context, email, _model.passwordCreateTextController.text);
        if (user != null) {
          if (!mounted) return;
          context.pushNamedAuth(Screen3Widget.routeName, true);
        }
      },
      text: 'Create Account',
      options: FFButtonOptions(
        width: double.infinity,
        height: 52.0,
        color: FlutterFlowTheme.of(context).success,
        textStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        borderRadius: BorderRadius.circular(12.0),
        elevation: 2,
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E3E7))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primary, width: 2)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  FFButtonOptions _buttonOptions() {
    return FFButtonOptions(
      width: double.infinity,
      height: 50,
      color: FlutterFlowTheme.of(context).primary,
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
    );
  }
}
