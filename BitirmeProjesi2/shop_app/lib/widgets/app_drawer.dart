import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/screens/settingscreen.dart';

import '../localizations.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: const Color(0xFFFAA419),
            title: Text(AppLocalizations.of(context).getTranslate('menu')),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: Text(AppLocalizations.of(context).getTranslate('store')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  '/'); // pushReplacementNamed: bir sonraki sayfada da drawer menüyü gösteriyor.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(AppLocalizations.of(context).getTranslate('orders')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen
                  .routeName); // pushReplacementNamed: bir sonraki sayfada da drawer menüyü gösteriyor.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(
                AppLocalizations.of(context).getTranslate('manageProducts')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductsScreen
                  .routeName); // pushReplacementNamed: bir sonraki sayfada da drawer menüyü gösteriyor.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context).getTranslate('settings')),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingsScreen.routeName);
              // pushReplacementNamed: bir sonraki sayfada da drawer menüyü gösteriyor.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context).getTranslate('logout')),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
