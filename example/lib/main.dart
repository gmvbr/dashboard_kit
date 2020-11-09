import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/theme.dart';
import 'package:dashboard_kit/dashboard_kit.dart';

void main() async {
  var preferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferences: preferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  MyApp({this.preferences});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(preferences: this.preferences),
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dashboard',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            onGenerateRoute: (settings) {
              if (settings.name == Product.tag) {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, __, ___) => Product(),
                );
              }
              if (settings.name == Home.tag) {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, __, ___) => Home(),
                );
              }
              return null;
            },
            darkTheme: ThemeData.dark(),
            themeMode: theme.getThemeMode(),
            initialRoute: Home.tag,
          );
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final MenuState state;

  const MyDrawer(this.state);

  DashboardItem item({
    BuildContext context,
    String path,
    String title,
    IconData icon,
  }) {
    return DashboardItem(
      state: state,
      icon: icon,
      title: title,
      activeColor: Colors.purple,
      active: ModalRoute.of(context).settings.name == path,
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, path, (context) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        item(
          context: context,
          icon: Icons.home_outlined,
          title: "Home",
          path: Home.tag,
        ),
        item(
          context: context,
          icon: Icons.card_travel_outlined,
          title: "Product",
          path: Product.tag,
        )
      ],
    );
  }
}

class Home extends StatelessWidget {
  static String tag = 'home';

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      primaryColor: Colors.deepPurple,
      secondColor: Colors.deepPurple.shade700,
      drawer: (state) => MyDrawer(state),
      header: (state) => DashboardLogo(
        icon: Icons.developer_board,
        title: "GMVBR",
        state: state,
      ),
      themeChange: (mode) {
        print(mode);
        Provider.of<ThemeProvider>(context, listen: false).setThemeDark(mode);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DashboardTitle(
            title: "Home",
          ),
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {
  static String tag = 'product';

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      primaryColor: Colors.deepPurple,
      secondColor: Colors.deepPurple.shade700,
      drawer: (state) => MyDrawer(state),
      header: (state) => DashboardLogo(
        icon: Icons.developer_board,
        title: "GMVBR",
        state: state,
      ),
      themeChange: (mode) {
        Provider.of<ThemeProvider>(context, listen: false).setThemeDark(mode);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DashboardTitle(
            title: "Product",
          ),
        ],
      ),
    );
  }
}
