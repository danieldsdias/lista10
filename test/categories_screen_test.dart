import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista10/controllers/db_controller.dart';
import 'package:lista10/screens/categories_screen.dart';

void main() {
  testWidgets('Adiciona uma categoria', (WidgetTester tester) async {
    //WidgetsFlutterBinding.ensureInitialized();
    await DBController.openDatabase();

    //Pega todos os widgets
    final addButton = find.byKey(ValueKey('AddCategoriesButton'));
    final addTitle = find.byKey(ValueKey('AddTitleField'));
    final createButton = find.byKey(ValueKey('CreateItemButton'));

    //executa o teste
    await tester.pumpWidget(const MaterialApp(home: CategoriesScreen()));
    await tester.tap(addButton);
    await tester.enterText(addTitle, 'Item teste');
    await tester.tap(createButton);
    await tester.pump();

    //verifica
    expect(find.text('Item teste'), findsOneWidget);
  });
}
