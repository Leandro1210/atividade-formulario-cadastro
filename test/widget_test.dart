import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:atividade_formulario_cadastro/main.dart';

void main() {
  testWidgets('exibe erros quando os campos estão vazios', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();

    expect(find.text('Informe o nome completo'), findsOneWidget);
    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe o CPF'), findsOneWidget);
    expect(find.text('Informe o telefone'), findsOneWidget);
    expect(find.text('Informe a senha'), findsOneWidget);
  });

  testWidgets('CPF aceita apenas números', (tester) async {
    await tester.pumpWidget(const MeuApp());

    final cpf = find.widgetWithText(TextFormField, 'CPF');
    await tester.enterText(cpf, 'abc123.456-78');

    final field = tester.widget<EditableText>(
      find.descendant(of: cpf, matching: find.byType(EditableText)),
    );
    expect(field.controller.text, '12345678');
  });

  testWidgets('exibe SnackBar de sucesso com dados válidos', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Nome completo'), 'Maria Silva');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'E-mail'), 'maria@email.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'CPF'), '12345678901');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Telefone'), '11987654321');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'), '123456');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirmar senha'), '123456');

    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();

    expect(find.text('Cadastro de Maria Silva realizado com sucesso!'),
        findsOneWidget);
  });
}
