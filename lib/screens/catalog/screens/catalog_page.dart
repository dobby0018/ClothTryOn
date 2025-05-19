import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder:
          (context, index) => ListTile(
            leading: CircleAvatar(child: Icon(Icons.checkroom)),
            title: Text('Garment #$index'),
            subtitle: Text('Size: M | Color: Blue'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
    );
  }
}
