import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/settings/settings_cubit.dart';
import 'package:shop_app/bloc/settings/settings_state.dart';
import 'package:shop_app/screens/settingscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './providers/auth.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './helpers/custom_route.dart';
import 'localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final customPrimaryColor = const MaterialColor(0xFF291E02, {
    50: Color(0xFFEAE1D9),
    100: Color(0xFFDAC6B9),
    200: Color(0xFFC8A594),
    300: Color(0xFFB68570),
    400: Color(0xFFA8684D),
    500: Color(0xFF964D2C),
    600: Color(0xFF84341A),
    700: Color(0xFF71280F),
    800: Color(0xFF5E1D08),
    900: Color(0xFF4C1200),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsCubit(SettingsState()),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (ctx) => Auth()),
              ChangeNotifierProxyProvider<Auth, Products>(
                create: (ctx) => Products('', '', []),
                update: (ctx, auth, previousProduct) => Products(
                  auth.token.toString(),
                  auth.userId.toString(),
                  previousProduct == null ? [] : previousProduct.items,
                ),
              ),
              ChangeNotifierProvider(create: (ctx) => Cart()),
              ChangeNotifierProxyProvider<Auth, Orders>(
                create: (ctx) => Orders('', '', []),
                update: (ctx, auth, previousOrder) => Orders(
                  auth.token.toString(),
                  auth.userId.toString(),
                  previousOrder == null ? [] : previousOrder.orders,
                ),
              ),
            ],
            child: MaterialApp(
              title: 'MyShop',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: state.darkmode ? Brightness.dark : Brightness.light,
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('tr', ''),
              ],
              locale: Locale(state.language),
              home: Consumer<Auth>(
                builder: (ctx, auth, _) => auth.isAuth
                    ? ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen(),
                      ),
              ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                SettingsScreen.routeName: (ctx) => SettingsScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
