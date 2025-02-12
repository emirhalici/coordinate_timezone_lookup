import 'package:coordinate_timezone_lookup/coordinate_timezone_lookup.dart' as coordinate_timezone_lookup;

void main(List<String> arguments) {
  if (arguments.length < 2) {
    return print('Error: Provide lat and long');
  }

  final [lat, long] = arguments;

  final num? latNum = num.tryParse(lat);
  final num? longNum = num.tryParse(long);

  if (latNum == null || longNum == null) {
    return print('Error: provide valid lat long values');
  }

  final result = coordinate_timezone_lookup.timezoneLookup(lat: latNum, long: longNum);
  print(result);
}
