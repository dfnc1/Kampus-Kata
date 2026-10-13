import 'package:flutter_test/flutter_test.dart';
import 'package:kampus_kata/main.dart';

void main() {
  testWidgets('KampusKata smoke test', (WidgetTester tester) async {
    // Build aplikasi KampusKata
    await tester.pumpWidget(const KampusKataApp());

    // Memverifikasi bahwa header Beranda muncul
    expect(find.text('Halo, Mahasiswa!'), findsOneWidget);
  });
}
