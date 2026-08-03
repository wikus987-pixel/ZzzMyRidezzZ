# Implementation Plan - Ride Details, Payments, and User Relationships

This plan outlines the changes to revert the payment flow to its previous state, enhance the ride details screen, clarify location labels, and ensure drivers and passengers can see each other's details.

## User Review Required

> [!IMPORTANT]
> - I am disabling the "Card" button on the Ride Details screen as requested.
> - I am adding a new section in "My Created Rides" (for drivers) to show a list of passengers who have booked seats/parcels for each ride, including their contact details.
> - The "My Bookings" section for passengers already shows driver details via the `BookedRidesCardWidget`. I will ensure these details are complete.

## Proposed Changes

### Ride Details Screen
`lib/ride_details_screen/ride_details_screen_widget.dart`
- Add a display row for "Available Parcels" next to "Available Seats".
- Disable the "Card" button.
- Update the "Submit Booking" button notification: "Submit Booking (Booking will be cancelled if proof of payment is not received in 30min)".
- Make "Submit Booking" available to all users.

---

### Ride Creation & Request Screens
`lib/create_rides_page/create_rides_page_widget.dart`
- Change "From" label to "Pickup Location".
- Change "Arrival" label to "Drop off Location".

`lib/req_rides_page/req_rides_page_widget.dart`
- Change "From" label to "Pickup Location".
- Change "Arrival" label to "Drop off Location".

---

### Location Components
`lib/components/location_input_widget.dart` & `lib/components/location_input_arriva_widget.dart`
- Update default labels to "Pickup Location" and "Drop off Location".

---

### User Relationship Details (Driver/Passenger Info)
`lib/pages/my_created_rides/my_created_rides_widget.dart`
- Under each ride in the "My Created" tab, add a `FutureBuilder` or `StreamBuilder` that fetches all `PendingPayments` for that `ride_id`.
- For each booking, fetch the passenger's user details (Name, Phone, Email) and display them in a list under the ride card.
- Include "WhatsApp" and "Email" buttons for drivers to contact their passengers.

`lib/components/booked_rides_card_widget.dart`
- Ensure all driver details (Name, Vehicle, Phone, Email) are correctly fetched and displayed for the passenger. (Existing logic seems solid, but I will verify).

---

## Verification Plan

### Automated Tests
- `flutter build apk --debug` to verify no compilation errors.

### Manual Verification
- Verify that the "Card" button is disabled and shows the "Maintenance" snackbar.
- Verify the "Submit Booking" button text and visibility.
- Verify the location labels on both Create and Request screens.
- **Critical**: Verify that a driver can see a list of passengers who booked their ride in the "My Created" tab of the profile.
- Verify that a passenger can see the driver's details in the "My Bookings" tab.

### Build APK
- Run `flutter build apk --release` to generate the final APK.
