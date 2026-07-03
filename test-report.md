# RideShareSupa — First-Run Test Report

**Result: PASS.** The FlutterFlow-exported app now compiles, boots, and connects to Supabase end-to-end (read + auth).

## Environment
- Flutter stable 3.44.4, built for web (`flutter build web`) + run via `flutter run -d web-server`
- Supabase project: `https://empawnadqvmalfqvbkbp.supabase.co`
- Tables: users, rides, ReqRides, PendingPayments, verified_payments

## What was broken (and fixed)
1. **~33 compile errors** from incomplete Firebase→Supabase migration + manual edits (class renames, wrong field names, leftover Firebase calls, commented-out `MyAppScrollBehavior`, malformed widgets). Fixed across 9 files.
2. **App stuck forever on the splash spinner.** Root cause: `go_router 17.3.0` re-runs the route `redirect` on `refreshListenable` changes but does **not** re-run `pageBuilder` when the location is unchanged. FlutterFlow's boilerplate relied on `pageBuilder` re-running to swap the splash for the real page. Fix: wrap the page/splash swap in a `ListenableBuilder` that listens to `AppStateNotifier`, so the swap is driven directly by the notifier. (`lib/flutter_flow/nav/nav.dart`)
3. **HTTP 401 `42501 permission denied`** on every table (RLS on, no grants). Applied allow-all grants + permissive RLS policies (per user's choice) so the API returns data.

## Tests

### 1. It should boot and reach the login screen — PASS
App boots past the splash to the LoginPage; the startup `verified_payments` query returns 200.

![Login screen](login_screen.png)

### 2. It should render the Sign Up payment-gate from live data — PASS
The Sign Up tab loads a second live `verified_payments` read and renders the payment-gate ("Pay Registration Fee (R45/Year)" + "Email Proof of Payment"). Confirms the DB read path works.

![Sign Up pay-gate](signup_paygate.png)

### 3. It should reach Supabase Auth on Sign In — PASS
Signing in with a non-existent account returns a real Supabase Auth response: "Error: Invalid login credentials". Confirms the auth round-trip works.

![Auth round-trip](signin_auth.png)

## Notes / follow-ups
- The Sign Up flow is **payment-gated**: pay registration fee → email proof of payment → admin adds the email to `verified_payments` → user returns and sets a password. Full account creation can't be completed without a `verified_payments` record.
- "Allow all" RLS means anyone with the publishable key (shipped in the app) can read/write those 5 tables via the API. Tighten before real users.
- All lint issues remaining are FlutterFlow style warnings (unused imports, `avoid_print`), not errors. `flutter analyze` = 0 errors.
