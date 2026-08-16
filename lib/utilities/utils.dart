String getInitials(String fullName) {
  if (fullName.isEmpty) return "";
  // Split name by space
  List<String> parts = fullName.trim().split(" ");
  // Take first letter of first part
  String initials = parts[0][0].toUpperCase();
  // If there is more than one part, take first letter of second part
  if (parts.length > 1) {
    initials += parts[1][0].toUpperCase();
  }

  return initials;
}
