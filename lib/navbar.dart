import 'package:flutter/material.dart';
import 'package:github_search/screens/issues_screen.dart';
import 'package:github_search/screens/repo_screen.dart';
import 'package:github_search/screens/user_screen.dart';
import 'package:github_search/services/http_services.dart';
import 'models/user.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  final _searchController = TextEditingController();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.search),
                iconSize: 28,
                onPressed: () {
                  setState(() {
                    search = _searchController.text;
                  });
                },
              ),
              title: TextField(
                controller: _searchController,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserScreen(search: search),
              IssueScreen(search: search),
              RepoScreen(search: search),
            ],
          ),
        ),
      ),
    );
  }
}
