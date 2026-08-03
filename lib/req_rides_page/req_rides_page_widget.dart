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
import 'req_rides_page_model.dart';
export 'req_rides_page_model.dart';

class ReqRidesPageWidget extends StatefulWidget {
  const ReqRidesPageWidget({super.key});

  static String routeName = 'ReqRidesPage';
  static String routePath = 'reqRidesPage';

  @override
  State<ReqRidesPageWidget> createState() => _ReqRidesPageWidgetState();
}

class _ReqRidesPageWidgetState extends State<ReqRidesPageWidget> {
  late ReqRidesPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? departureTime;
  DateTime? arrivalTime;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReqRidesPageModel());
    departureTime = DateTime.now();
    arrivalTime = DateTime.now().add(const Duration(hours: 2));
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
      initialDate: base.isBefore(now) ? now : base,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (time == null || !mounted) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'ReqRidesPage',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () => context.safePop(),
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            'Request a Ride',
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Route Details',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
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
                        Text(
                          'Departure',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        InkWell(
                          onTap: () async {
                            final picked = await _pickDateTime(departureTime);
                            if (picked != null) {
                              setState(() => departureTime = picked);
                            }
                          },
                          child: wrapWithModel(
                            model: _model.datetimePickerModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: DatetimePickerWidget(
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              label: 'Departure Date & Time',
                              value: departureTime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Estimated Arrival',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        InkWell(
                          onTap: () async {
                            final picked = await _pickDateTime(arrivalTime);
                            if (picked != null) {
                              setState(() => arrivalTime = picked);
                            }
                          },
                          child: wrapWithModel(
                            model: _model.datetimePickerModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: DatetimePickerWidget(
                              icon: Icon(
                                Icons.event_available_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              label: 'Arrival Date & Time',
                              value: arrivalTime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Passenger Requirements',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.chair_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Text(
                                    'Seats Needed',
                                    style: FlutterFlowTheme.of(context).bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      if (_model.seatsNeeded > 0) {
                                        setState(() => _model.seatsNeeded--);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    _model.seatsNeeded.toString(),
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                        ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      if (_model.seatsNeeded < 10) {
                                        setState(() => _model.seatsNeeded++);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Parcel Requirements',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.inventory_2_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Text(
                                    'Parcels Needed',
                                    style: FlutterFlowTheme.of(context).bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      if (_model.parcelsNeeded > 0) {
                                        setState(() => _model.parcelsNeeded--);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    _model.parcelsNeeded.toString(),
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                        ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      if (_model.parcelsNeeded < 20) {
                                        setState(() => _model.parcelsNeeded++);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 18.0,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  'Your request will be visible to drivers heading this way in ReqRides.',
                                  style: FlutterFlowTheme.of(context).bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        FFButtonWidget(
                          onPressed: () async {
                            try {
                              await ReqRidesTable().insert({
                                'DepartureLocation': _model.locationInputModel.textTextController.text.trim(),
                                'DepartureTime': supaSerialize<DateTime>(departureTime),
                                'ArrivalLocation': _model.locationInputArrivaModel.textTextController.text.trim(),
                                'ArrivalTime': supaSerialize<DateTime>(arrivalTime),
                                'SeatsNeeded': _model.seatsNeeded.toString(),
                                'number_of_parcels_req': _model.parcelsNeeded,
                                'price_per_parcel_req': 0.0,
                                'RequestedBy': currentUserUid,
                              });
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Requested Successfully')),
                              );
                              context.safePop();
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          },
                          text: 'Submit Request',
                          options: FFButtonOptions(
                            height: 50.0,
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ],
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
