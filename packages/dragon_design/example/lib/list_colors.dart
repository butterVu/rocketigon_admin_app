import 'package:flutter/material.dart';
import 'package:dragon_design/dragon_design.dart';

class ListColors extends StatelessWidget {
  const ListColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Colors')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Primary Color'),
            leading: CircleAvatar(backgroundColor: AppColor.primary),
          ),
          ListTile(
            title: const Text('Secondary Color'),
            leading: CircleAvatar(backgroundColor: AppColor.secondary),
          ),
          ListTile(
            title: const Text('Success Color'),
            leading: CircleAvatar(backgroundColor: AppColor.success),
          ),
          ListTile(
            title: const Text('Warning Color'),
            leading: CircleAvatar(backgroundColor: AppColor.warning),
          ),
          ListTile(
            title: const Text('Error Color'),
            leading: CircleAvatar(backgroundColor: AppColor.error),
          ),
        ],
      ),
    );
  }
}
