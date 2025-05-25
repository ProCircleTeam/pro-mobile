import 'package:flutter_test/flutter_test.dart';

void main() {
  group('group name', () {
    test("Test sonar", () {
      final safetyKey = "test safety key";

      expect(safetyKey, "test safety key");
    });
  });
}
