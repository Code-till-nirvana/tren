import 'package:flutter_test/flutter_test.dart';
import 'package:tren/l10n/app_localizations_vi.dart';

void main() {
  final vi = AppLocalizationsVi();

  test('Vietnamese is registered under its own name', () {
    expect(vi.languageName, 'Tiếng Việt');
    expect(vi.cancel, 'Hủy');
    expect(vi.save, 'LƯU');
  });

  test('set confirms a number, it is not a workout set', () {
    expect(vi.set, 'Đặt');
  });

  test('Vietnamese plurals use the single other form', () {
    expect(vi.portionUnit(1), '1 miếng');
    expect(vi.portionUnit(3), '3 miếng');
  });
}
