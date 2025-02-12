import 'package:coordinate_timezone_lookup/coordinate_timezone_lookup.dart';
import 'package:test/test.dart';

void main() async {
  void testPass(List<num> coords, String expected) {
    test('should return "$expected" given ${coords.join(", ")}', () {
      final result = timezoneLookup(lat: coords[0], long: coords[1]);
      expect(result, equals(expected));
    });
  }

  void testFail(List<num> coords) {
    test('should fail given ${coords.join(", ")}', () {
      expect(() => timezoneLookup(lat: coords[0], long: coords[1]),
          throwsA(isA<RangeError>().having((e) => e.message, 'message', 'Invalid coordinates')));
    });
  }

  group('tzlookup', () {
    // These tests are hand-crafted for specific locations
    final List<MapEntry<List<num>, String>> testCases = [
      MapEntry([40.7092, -74.0151], "America/New_York"),
      MapEntry([42.3668, -71.0546], "America/New_York"),
      MapEntry([41.8976, -87.6205], "America/Chicago"),
      MapEntry([47.6897, -122.4023], "America/Los_Angeles"),
      MapEntry([42.7235, -73.6931], "America/New_York"),
      MapEntry([42.5807, -83.0223], "America/Detroit"),
      MapEntry([36.8381, -84.8500], "America/Kentucky/Monticello"),
      MapEntry([40.1674, -85.3583], "America/Indiana/Indianapolis"),
      MapEntry([37.9643, -86.7453], "America/Indiana/Tell_City"),
      MapEntry([38.6043, -90.2417], "America/Chicago"),
      MapEntry([41.1591, -104.8261], "America/Denver"),
      MapEntry([35.1991, -111.6348], "America/Phoenix"),
      MapEntry([43.1432, -115.6750], "America/Boise"),
      MapEntry([47.5886, -122.3382], "America/Los_Angeles"),
      MapEntry([58.3168, -134.4397], "America/Juneau"),
      MapEntry([21.4381, -158.0493], "Pacific/Honolulu"),
      MapEntry([42.7000, -80.0000], "America/Toronto"),
      MapEntry([51.0036, -114.0161], "America/Edmonton"),
      MapEntry([-16.4965, -68.1702], "America/La_Paz"),
      MapEntry([-31.9369, 115.8453], "Australia/Perth"),
      MapEntry([42.0000, -87.5000], "America/Chicago"),
      MapEntry([36.9147, -111.4558], "America/Phoenix"), // #7
      MapEntry([46.1328, -64.7714], "America/Moncton"),
      MapEntry([44.9280, -87.1853], "America/Chicago"), // #13
      MapEntry([50.7029, -57.3511], "America/St_Johns"), // #13
      MapEntry([29.9414, -85.4064], "America/Chicago"), // #14
      MapEntry([49.7261, -1.9104], "Europe/Paris"), // #15
      MapEntry([65.5280, 23.5570], "Europe/Stockholm"), // #16
      MapEntry([35.8722, -84.5250], "America/New_York"), // #18
      MapEntry([60.0961, 18.7970], "Europe/Stockholm"), // #23 (Grisslehamn)
      MapEntry([59.9942, 18.7794], "Europe/Stockholm"), // #23 (Ortala)
      MapEntry([59.0500, 15.0412], "Europe/Stockholm"), // #23 (Tomta)
      MapEntry([60.0270, 18.7594], "Europe/Stockholm"), // #23 (Björkkulla)
      MapEntry([60.0779, 18.8102], "Europe/Stockholm"), // #23 (Kvarnsand)
      MapEntry([60.0239, 18.7625], "Europe/Stockholm"), // #23 (Semmersby)
      MapEntry([59.9983, 18.8548], "Europe/Stockholm"), // #23 (Gamla Grisslehamn)
      MapEntry([37.3458, -85.3456], "America/New_York"), // #24
      MapEntry([46.4547, -90.1711], "America/Menominee"), // #25
      MapEntry([46.4814, -90.0531], "America/Menominee"), // #25
      MapEntry([46.4753, -89.9400], "America/Menominee"), // #25
      MapEntry([46.3661, -89.5969], "America/Menominee"), // #25
      MapEntry([46.2678, -89.1781], "America/Menominee"), // #25
      MapEntry([45.1078, -87.6142], "America/Menominee"), // #25
      MapEntry([39.6217, -87.4522], "America/Indiana/Indianapolis"), // #27
      MapEntry([39.6631, -87.4307], "America/Indiana/Indianapolis"), // #27
      MapEntry([61.7132, 29.3968], "Europe/Helsinki"), // #36
      MapEntry([41.6724, -86.5082], "America/Indiana/Indianapolis"), // #38
      MapEntry([27.9881, 86.9253], "Asia/Shanghai"), // Mount Everest
      MapEntry([47.3525, -102.6214], "America/Denver"), // Dunn Center, North Dakota
      MapEntry([20.5104, -86.9493], "America/Cancun"), // #40 (San Miguel de Cozumel)
      MapEntry([19.5786, -88.0453], "America/Cancun"), // #40 (Felipe Carrillo Puerto)
      MapEntry([21.2333, -86.7333], "America/Cancun"), // #40 (Isla Mujeres)
      MapEntry([18.5036, -88.3053], "America/Cancun"), // #40 (Chetumal)
      MapEntry([21.1606, -86.8475], "America/Cancun"), // #40 (Cancún)
      MapEntry([19.7500, -88.7000], "America/Cancun"), // #40 (José María Morelos)
      MapEntry([21.1000, -87.4833], "America/Cancun"), // #40 (Kantunilkín)
      MapEntry([20.6275, -87.0811], "America/Cancun"), // #40 (Playa del Carmen)
      MapEntry([20.2119, -87.4658], "America/Cancun"), // #40 (Tulum)
      MapEntry([18.6769, -88.3953], "America/Cancun"), // #40 (Bacalar)
      MapEntry([20.8536, -86.8753], "America/Cancun"), // #40 (Puerto Morelos)
      MapEntry([-31.6750, 128.8831], "Australia/Eucla"), // # 45
      MapEntry([-31.9567, 141.4678], "Australia/Broken_Hill"), // #46

      // Check that we resolve conflicting zones adequately
      MapEntry([43.8250, 87.6000], "Asia/Urumqi"),
      MapEntry([25.0667, 121.5167], "Asia/Taipei"),

      // Collapse the north pole so that it always returns GMT regardless of the longitude
      MapEntry([90, -180], "Etc/GMT"), // #20
      MapEntry([90, -90], "Etc/GMT"), // #20
      MapEntry([90, 0], "Etc/GMT"), // #20
      MapEntry([90, 90], "Etc/GMT"), // #20
      MapEntry([90, 180], "Etc/GMT"), // #20

      // Sanity-check international waters
      MapEntry([-56.25, -180], "Etc/GMT+12"),
      MapEntry([-56.25, -165], "Etc/GMT+11"),
      MapEntry([-56.25, -150], "Etc/GMT+10"),
      MapEntry([-56.25, -135], "Etc/GMT+9"),
      MapEntry([-56.25, -120], "Etc/GMT+8"),
      MapEntry([-56.25, -105], "Etc/GMT+7"),
      MapEntry([-56.25, -90], "Etc/GMT+6"),
      MapEntry([26.25, -60], "Etc/GMT+4"),
      MapEntry([-48.75, -45], "Etc/GMT+3"),
      MapEntry([-48.75, -30], "Etc/GMT+2"),
      MapEntry([-56.25, -15], "Etc/GMT+1"),
      MapEntry([-56.25, 0], "Etc/GMT"),
      MapEntry([-56.25, 15], "Etc/GMT-1"),
      MapEntry([-56.25, 30], "Etc/GMT-2"),
      MapEntry([-56.25, 45], "Etc/GMT-3"),
      MapEntry([-56.25, 60], "Etc/GMT-4"),
      MapEntry([-56.25, 75], "Etc/GMT-5"),
      MapEntry([-56.25, 90], "Etc/GMT-6"),
      MapEntry([-56.25, 105], "Etc/GMT-7"),
      MapEntry([-56.25, 120], "Etc/GMT-8"),
      MapEntry([-56.25, 135], "Etc/GMT-9"),
      MapEntry([-56.25, 150], "Etc/GMT-10"),
      MapEntry([-48.75, 165], "Etc/GMT-11"),
      MapEntry([-56.25, 180], "Etc/GMT-12"),
    ];

    // Add all test cases
    for (final testCase in testCases) {
      testPass(testCase.key, testCase.value);
    }

    // Test invalid inputs
    final failCases = [
      [100, 10],
      [10, 190],
      // ["hello", 10],
      // [10, "hello"],
      [-91, 0],
      [0, 181],
    ];

    for (final coords in failCases) {
      testFail(coords);
    }
  });
}
