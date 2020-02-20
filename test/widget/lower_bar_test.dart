import 'package:flutter_test/flutter_test.dart';

import 'package:queuetodo/lower_bar.dart';

void main() {
  testWidgets('App widget contents', (WidgetTester tester) async {
    await tester.pumpWidget(LowerBar(index: 1, onTap: () {},));
    await tester.pump();
  });
}
