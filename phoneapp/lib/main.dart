import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phoneapp/l10n/l10n.dart';

import 'package:phoneapp/models/stateModels/ContactsModel.dart';
import 'package:phoneapp/models/stateModels/DialModel.dart';

import 'package:phoneapp/screen/ContactsListPage/contacts_page.dart';
import 'package:phoneapp/screen/dial_page/dial_page.dart';

import 'package:phoneapp/screen/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    const PhoneApp(),
  );
}

class PhoneApp extends StatelessWidget {
  const PhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactsModel()),
        ChangeNotifierProvider(create: (_) => DialModel())
      ],
      child: MaterialApp.router(
        supportedLocales: L10n.locales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routerConfig: _routers,

      ),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _routers = GoRouter(
  initialLocation: "/fav",
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>  HomePage(child: child),
      routes: [
      GoRoute(path: "/fav", builder: (context, state) => const Center(
        child: Text("Favourites"),
        ),
        
      ),
      
      GoRoute(path: "/recents", builder: (context, state) => const Center(
        child: Text("Recents")
        ),
      ),
      
      GoRoute(path: "/phonebook", builder: (context, state) => const ContactsPage(),),
      
      GoRoute(path: "/keyboard", builder: (context, state) => const DialPage(),),
      
      GoRoute(path: "/voicemail", builder: (context, state) => const Center(
        child: Text("Voice Mail")
        ),
      )
      ] 
    ),
    
  ] 
);