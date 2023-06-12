import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localizations.dart';
import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/badge.dart' as CustomBadge;

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Delay the execution using Future.delayed
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60), // AppBar'ın yüksekliğini ayarlayın
        child: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: const Color.fromARGB(255, 255, 255, 255),
                )),
          ),
          backgroundColor: Color(0xFFFAA419), // AppBar'ın arka plan rengi
          elevation: 0, // Gölgeyi kaldırmak için
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo6.png', // Logo dosyasının yolunu belirtin
                height: 77, // Boyutu isteğe bağlı olarak ayarlayın
              ),
              const SizedBox(
                  width: 10), // Logo ile yazı arasındaki boşluğu ayarlayın
              // Yazı
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert,
                  color:
                      Color.fromARGB(255, 255, 255, 255)), // Sarı renkte ikon
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(AppLocalizations.of(context)
                      .getTranslate('favoritesOnly')),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text(AppLocalizations.of(context).getTranslate('all')),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => CustomBadge.Badge(
                child: ch!,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart,
                    color:
                        Color.fromARGB(255, 255, 255, 255)), // Sarı renkte ikon
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
