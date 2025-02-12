import 'package:coordinate_timezone_lookup/timezone_info.dart';

final TimezoneInfo _info = TimezoneInfo();

String timezoneLookup({required num lat, required num long}) {
  // Convert parameters to doubles for precise calculations
  double latitude = lat.toDouble();
  double longitude = long.toDouble();

  // Validate coordinates
  if (!(latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180)) {
    throw RangeError('Invalid coordinates');
  }

  // Special case for north pole
  if (latitude >= 90) {
    return 'Etc/GMT';
  }

  // Node offset in the tree
  int n = -1;

  // Convert coordinates to relative position
  // Using constants for precise floating-point comparison
  const double lonDivisor = 360.00000000000006;
  const double latDivisor = 180.00000000000003;

  double x = (180 + longitude) * 48 / lonDivisor;
  double y = (90 - latitude) * 24 / latDivisor;

  // Integer coordinates of child node
  int u = x.floor();
  int v = y.floor();

  // Calculate initial node index
  int i = v * 96 + u * 2;
  i = _info.timezoneData.codeUnitAt(i) * 56 + _info.timezoneData.codeUnitAt(i + 1) - 1995;

  // Recurse until we hit a leaf node
  while (i + _info.timezoneList.length < 3136) {
    // Increment the node pointer
    n = n + i + 1;

    // Find position relative to child node
    x = (x - u) * 2 % 2;
    y = (y - v) * 2 % 2;
    u = x.floor();
    v = y.floor();

    // Read the child node
    i = n * 8 + v * 4 + u * 2 + 2304;
    i = _info.timezoneData.codeUnitAt(i) * 56 + _info.timezoneData.codeUnitAt(i + 1) - 1995;
  }

  // Return the timezone from the leaf node
  return _info.timezoneList[i + _info.timezoneList.length - 3136];
}
