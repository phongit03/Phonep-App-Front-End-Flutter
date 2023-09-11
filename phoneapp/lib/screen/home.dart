import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class HomePage extends StatefulWidget {
  final Widget child;
  
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navItemIndex = 0;
  
  @override
  Widget build(BuildContext context) {
     List<CustomBottomNavBarItem> pages = <CustomBottomNavBarItem> [
      CustomBottomNavBarItem(
        initialLocation: "/fav", 
        icon: const Icon(Icons.star),
        label: AppLocalizations.of(context)!.favourites,
      ),

      CustomBottomNavBarItem(
        initialLocation: "/recents", 
        icon: const Icon(Icons.access_time_filled_outlined),
        label: AppLocalizations.of(context)!.recents,
      ),

      CustomBottomNavBarItem(
        initialLocation: "/phonebook", 
        icon: const Icon(Icons.account_circle_sharp),
        label: AppLocalizations.of(context)!.phoneBook,
      ),

      CustomBottomNavBarItem(
        initialLocation: "/keyboard", 
        icon: const Icon(Icons.keyboard_alt_rounded),
        label: AppLocalizations.of(context)!.keyBoard,
      ),

      CustomBottomNavBarItem(
        initialLocation: "/voicemail", 
        icon: const Icon(Icons.voicemail),
        label: AppLocalizations.of(context)!.voiceMail,
      ),
     
    ];

    return Scaffold(
     
       body: SafeArea(child: PageView(
         children: [
           widget.child
         ],
       ),),
       bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,

        items: pages,

        currentIndex: navItemIndex,

        onTap: (int index) {
          onNavItemSelected(index, context, pages);
        },

        selectedItemColor: Colors.blue,
      ),

    );
  }

  void onNavItemSelected(int index, BuildContext context, List<CustomBottomNavBarItem> pages) {
    GoRouter router = GoRouter.of(context);
    
    String location = pages[index].initialLocation;
    
    setState(() {
      navItemIndex = index;
      router.go(location);
    });

   
  }
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const CustomBottomNavBarItem ({
    required this.initialLocation,

    required Widget icon,

    String? label,

    Widget? activeIcon
  }) : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}

