import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
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
      title: 'LoginPage',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                Text(
                  'RideShare',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.interTight(fontWeight: FontWeight.w900),
                        fontSize: 40.0,
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
                _buildTabBar(),
                SizedBox(
                  height: 600,
                  child: TabBarView(
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
      ),
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: const Alignment(-1.0, 0),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: FlutterFlowTheme.of(context).primary,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: FlutterFlowTheme.of(context).displaySmall.override(
              font: GoogleFonts.interTight(
                fontWeight: FontWeight.bold,
              ),
              fontSize: 24,
            ),
        indicatorColor: FlutterFlowTheme.of(context).primary,
        indicatorWeight: 4.0,
        tabs: const [Tab(text: 'Sign In'), Tab(text: 'Sign Up')],
        controller: _model.tabBarController,
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
            style: FlutterFlowTheme.of(context).bodyLarge,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordTextController,
            obscureText: !_model.passwordVisibility,
            decoration: _inputDecoration('Password', Icons.lock_outline).copyWith(
              suffixIcon: InkWell(
                onTap: () => setState(() => _model.passwordVisibility = !_model.passwordVisibility),
                child: Icon(_model.passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyLarge,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                final email = _model.emailAddressTextController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email address to reset password.')),
                  );
                  return;
                }
                await authManager.resetPassword(email: email, context: context);
              },
              child: Text(
                'Forgot Password?',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: FlutterFlowTheme.of(context).primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: () async {
              final user = await authManager.signInWithEmail(
                context,
                _model.emailAddressTextController.text,
                _model.passwordTextController.text,
              );
              if (user != null) context.pushNamedAuth(HomePageWidget.routeName, context.mounted);
            },
            text: 'Sign In',
            options: _buttonOptions(),
          ),
          const SizedBox(height: 16),
          const Text('Or'),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: () async {
              await authManager.signInWithGoogle(context);
            },
            text: 'Continue with Google',
            icon: const Icon(Icons.login_rounded, color: Colors.white),
            options: _buttonOptions().copyWith(
              color: Colors.white,
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              elevation: 2,
              borderSide: const BorderSide(color: Colors.grey, width: 1),
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
        children: [
          TextFormField(
            controller: _model.emailAddressCreateTextController,
            onChanged: (val) => EasyDebounce.debounce('signUpEmail', const Duration(milliseconds: 500), () => setState(() {})),
            decoration: _inputDecoration('E-mail Address', Icons.mail_outline),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
              font: GoogleFonts.inter(),
              color: Colors.black,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordCreateTextController,
            obscureText: !_model.passwordCreateVisibility,
            decoration: _inputDecoration('Password', Icons.lock_outline),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
              font: GoogleFonts.inter(),
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _model.passwordConfirmTextController,
            obscureText: !_model.passwordConfirmVisibility,
            decoration: _inputDecoration('Confirm Password', Icons.lock_outline),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
              font: GoogleFonts.inter(),
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          FFButtonWidget(
            onPressed: () async {
              final email = _model.emailAddressCreateTextController.text.trim();
              if (email.isEmpty) return;
              final registrationUsd = 45 * 0.056;
              final paid = await actions.payWithPaypal(context, registrationUsd, 'Registration Fee');
              if (paid) {
                await VerifiedPaymentsTable().insert({'Email': email, 'verified': false});
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment received! Please email proof.')));
              }
            },
            text: 'Pay Registration Fee (R45)',
            options: _buttonOptions(),
          ),
          const SizedBox(height: 16),
          FFButtonWidget(
            onPressed: () => launchURL('mailto:rideshare8855@gmail.com'),
            text: 'Email Proof of Payment',
            options: _buttonOptions().copyWith(color: FlutterFlowTheme.of(context).secondary),
          ),
          const SizedBox(height: 24),
          _buildUnlockableCreateAccountButton(),
          const SizedBox(height: 16),
          Text(
            'Once paid and verified, you can set your password here to complete registration.',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockableCreateAccountButton() {
    final email = _model.emailAddressCreateTextController.text.trim().toLowerCase();
    if (email.isEmpty) return const SizedBox.shrink();

    return StreamBuilder<List<VerifiedPaymentsRow>>(
      stream: SupaFlow.client.from('verified_payments').stream(primaryKey: ['id']).eq('email', email).eq('verified', true).map((r) => r.map((e) => VerifiedPaymentsRow(e)).toList()),
      builder: (context, snapshot) {
        final isVerified = snapshot.hasData && snapshot.data!.isNotEmpty;
        if (!isVerified) return const SizedBox.shrink();

        return FFButtonWidget(
          onPressed: () async {
            if (_model.passwordCreateTextController.text != _model.passwordConfirmTextController.text) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords mismatch')));
              return;
            }
            final user = await authManager.createAccountWithEmail(context, email, _model.passwordCreateTextController.text);
            if (user != null) context.pushNamedAuth(Screen3Widget.routeName, context.mounted);
          },
          text: 'Create Account',
          options: _buttonOptions().copyWith(color: FlutterFlowTheme.of(context).success),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary)),
    );
  }

  FFButtonOptions _buttonOptions() {
    return FFButtonOptions(
      width: double.infinity,
      height: 50,
      color: FlutterFlowTheme.of(context).primary,
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
