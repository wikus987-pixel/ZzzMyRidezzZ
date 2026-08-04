import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/components/datetime_picker_widget.dart';
import 'package:ride_share_supa/components/location_input_arriva_widget.dart';
import 'package:ride_share_supa/components/location_input_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_icon_button.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_rides_page_model.dart';
export 'create_rides_page_model.dart';

class CreateRidesPageWidget extends StatefulWidget {
  const CreateRidesPageWidget({super.key});

  static String routeName = 'CreateRidesPage';
  static String routePath = 'createRidesPage';

  @override
  State<CreateRidesPageWidget> createState() => _CreateRidesPageWidgetState();
}

class _CreateRidesPageWidgetState extends State<CreateRidesPageWidget> {
  late CreateRidesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateRidesPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController(text: '0');
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController(text: '0');
    _model.textFieldFocusNode5 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDateTime(DateTime? initial) async {
    final now = DateTime.now();
    final base = initial ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) {
      return null;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (time == null || !mounted) {
      return null;
    }
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'CreateRidesPage',
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
              borderRadius: 8.0,
              buttonSize: 40.0,
              fillColor: Colors.transparent,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
              onPressed: () => context.safePop(),
            ),
            title: Text(
              'Create a Ride',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                    color: Colors.white,
                  ),
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Route Details (Note: Tap Departure/Arrival below to set Date & Time)',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                              fontWeight: FontWeight.w600),
                          fontSize: 14,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  wrapWithModel(
                    model: _model.locationInputModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const LocationInputWidget(
                      label: 'Pickup Location',
                      hint: 'Enter pickup location',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  wrapWithModel(
                    model: _model.locationInputArrivaModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const LocationInputArrivaWidget(
                      label: 'Drop off Location',
                      hint: 'Enter destination',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked =
                                await _pickDateTime(_model.departureDateTime);
                            if (picked != null) {
                              safeSetState(() => _model.departureDateTime = picked);
                            }
                          },
                          child: wrapWithModel(
                            model: _model.datetimePickerModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: DatetimePickerWidget(
                              label: 'Departure',
                              value: _model.departureDateTime,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked =
                                await _pickDateTime(_model.arrivalDateTime);
                            if (picked != null) {
                              safeSetState(() => _model.arrivalDateTime = picked);
                            }
                          },
                          child: wrapWithModel(
                            model: _model.datetimePickerModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: DatetimePickerWidget(
                              label: 'Arrival',
                              value: _model.arrivalDateTime,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Ride Details',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                              fontWeight: FontWeight.w600),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Price Per Seat (R)',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium,
                            hintText: 'e.g. 50.00',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Number of seats being offered:',
                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.inter(),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    fontSize: 10,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      int current = int.tryParse(_model.textController3.text) ?? 0;
                                      if (current > 0) {
                                        setState(() => _model.textController3.text = (current - 1).toString());
                                      }
                                    },
                                  ),
                                  Text(
                                    _model.textController3.text.isEmpty ? '0' : _model.textController3.text,
                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      int current = int.tryParse(_model.textController3.text) ?? 0;
                                      setState(() => _model.textController3.text = (current + 1).toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Parcel Details',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                              fontWeight: FontWeight.w600),
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController4,
                          focusNode: _model.textFieldFocusNode4,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Price Per Parcel (R)',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium,
                            hintText: 'e.g. 20.00',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  int current = int.tryParse(_model.textController5.text) ?? 0;
                                  if (current > 0) {
                                    setState(() => _model.textController5.text = (current - 1).toString());
                                  }
                                },
                              ),
                              Text(
                                _model.textController5.text.isEmpty ? '0' : _model.textController5.text,
                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.inter(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  int current = int.tryParse(_model.textController5.text) ?? 0;
                                  setState(() => _model.textController5.text = (current + 1).toString());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _model.textController1,
                    focusNode: _model.textFieldFocusNode1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Additional Comments',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      hintText: 'Any extra info...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  FFButtonWidget(
                    onPressed: () async {
                      if (_model.departureDateTime == null ||
                          _model.arrivalDateTime == null ||
                          _model.textController2.text.isEmpty ||
                          _model.textController3.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all required fields')),
                        );
                        return;
                      }
                      try {
                        await RidesTable().insert({
                          'departure_location': _model.locationInputModel
                              .textTextController.text.trim(),
                          'arrival_location': _model.locationInputArrivaModel
                              .textTextController.text.trim(),
                          'departure_time': supaSerialize<DateTime>(
                              _model.departureDateTime),
                          'arrival_time': supaSerialize<DateTime>(
                              _model.arrivalDateTime),
                          'seats_available':
                              int.tryParse(_model.textController3.text) ?? 0,
                          'price_per_seat':
                              double.tryParse(_model.textController2.text) ?? 0.0,
                          'number_of_parcels':
                              int.tryParse(_model.textController5.text) ?? 0,
                          'price_per_parcel':
                              double.tryParse(_model.textController4.text) ?? 0.0,
                          'additional_comments': _model.textController1.text.trim(),
                          'driver_reference': currentUserUid,
                          'CreatedBy': currentUserUid,
                          'RideStatus': 'Open',
                        });
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ride Created Successfully')),
                        );
                        context.safePop();
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error creating ride: $e')),
                        );
                      }
                    },
                    text: 'Create Ride',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.interTight(
                                fontWeight: FontWeight.bold),
                            color: Colors.white,
                          ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(8.0),
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
}
