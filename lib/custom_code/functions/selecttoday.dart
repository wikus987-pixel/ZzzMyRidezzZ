

DateTime? selecttoday() {
  // Grab the current date and time
  DateTime now = DateTime.now();

  // Return a new DateTime pinned exactly to midnight of today
  return DateTime(now.year, now.month, now.day);
}
