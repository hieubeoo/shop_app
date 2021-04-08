import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem({this.id, this.imageUrl, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProducItem(id);
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Lỗi'),
                    ));
                  }
                },
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
