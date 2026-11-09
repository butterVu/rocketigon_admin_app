import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';

class ListTextStyles extends StatelessWidget {
  const ListTextStyles({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = <(String, TextStyle)>[
      ('regular10', AppTextStyle.regular10()),
      ('regular11', AppTextStyle.regular11()),
      ('regular12', AppTextStyle.regular12()),
      ('regular13', AppTextStyle.regular13()),
      ('regular14', AppTextStyle.regular14()),
      ('regular15', AppTextStyle.regular15()),
      ('regular16', AppTextStyle.regular16()),
      ('regular18', AppTextStyle.regular18()),
      ('regular20', AppTextStyle.regular20()),
      ('regular24', AppTextStyle.regular24()),
      ('regular28', AppTextStyle.regular28()),
      ('regular32', AppTextStyle.regular32()),
      ('medium10', AppTextStyle.medium10()),
      ('medium11', AppTextStyle.medium11()),
      ('medium12', AppTextStyle.medium12()),
      ('medium13', AppTextStyle.medium13()),
      ('medium14', AppTextStyle.medium14()),
      ('medium15', AppTextStyle.medium15()),
      ('medium16', AppTextStyle.medium16()),
      ('medium18', AppTextStyle.medium18()),
      ('medium20', AppTextStyle.medium20()),
      ('medium24', AppTextStyle.medium24()),
      ('medium28', AppTextStyle.medium28()),
      ('medium32', AppTextStyle.medium32()),
      ('semibold10', AppTextStyle.semibold10()),
      ('semibold11', AppTextStyle.semibold11()),
      ('semibold12', AppTextStyle.semibold12()),
      ('semibold13', AppTextStyle.semibold13()),
      ('semibold14', AppTextStyle.semibold14()),
      ('semibold15', AppTextStyle.semibold15()),
      ('semibold16', AppTextStyle.semibold16()),
      ('semibold18', AppTextStyle.semibold18()),
      ('semibold20', AppTextStyle.semibold20()),
      ('semibold24', AppTextStyle.semibold24()),
      ('semibold28', AppTextStyle.semibold28()),
      ('semibold32', AppTextStyle.semibold32()),
      ('bold10', AppTextStyle.bold10()),
      ('bold11', AppTextStyle.bold11()),
      ('bold12', AppTextStyle.bold12()),
      ('bold13', AppTextStyle.bold13()),
      ('bold14', AppTextStyle.bold14()),
      ('bold15', AppTextStyle.bold15()),
      ('bold16', AppTextStyle.bold16()),
      ('bold18', AppTextStyle.bold18()),
      ('bold20', AppTextStyle.bold20()),
      ('bold24', AppTextStyle.bold24()),
      ('bold28', AppTextStyle.bold28()),
      ('bold32', AppTextStyle.bold32()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('List Text Styles')),
      body: ListView.separated(
        itemCount: styles.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final (name, style) = styles[index];
          return ListTile(
            title: Text('The quick brown fox', style: style),
            subtitle: Text(name),
          );
        },
      ),
    );
  }
}
