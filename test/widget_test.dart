import 'package:flutter_app/http/tmdb_api.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should start at movies screen', (WidgetTester tester) async {
    // provideMockedNetworkImages(() async {
      await tester.pumpWidget(MovieApp());

      final titleFinder = find.text('Movies');
      expect(titleFinder, findsOneWidget);
    // });
  });
}
