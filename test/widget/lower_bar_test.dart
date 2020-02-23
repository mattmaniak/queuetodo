import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:queuetodo/lower_bar.dart';

void main() {
  testWidgets('App widget contents', (WidgetTester tester) async {
    try {
      await tester.pumpWidget(LowerBar(index: 1, onTap: (_) {},));
      // await tester.pump();
      // expect(find.text('Push a task'), findsOneWidget);
      // expect(find.text('Queue'), findsOneWidget);
    } on MissingPluginException {}
  });
}
