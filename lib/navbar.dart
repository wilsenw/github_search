import 'package:flutter/material.dart';
import 'package:github_search/models/issue.dart';
import 'package:github_search/models/repo.dart';
import 'package:github_search/screens/issues_screen.dart';
import 'package:github_search/screens/repo_screen.dart';
import 'package:github_search/screens/user_screen.dart';
import 'package:github_search/services/http_services.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider<List<MUser>>.value(
            value: Stream.fromFuture(getUserData(search)),
            initialData: const []),
        StreamProvider<List<MIssue>>.value(
            value: Stream.fromFuture(getIssueData(search)),
            initialData: const []),
        StreamProvider<List<MRepo>>.value(
            value: Stream.fromFuture(getRepoData(search)),
            initialData: const []),
      ],
      child: MaterialApp(
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
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Text("User",
                          style: Theme.of(context).textTheme.bodyMedium)),
                  Tab(
                      child: Text("Issues",
                          style: Theme.of(context).textTheme.bodyMedium)),
                  Tab(
                      child: Text("Repositories",
                          style: Theme.of(context).textTheme.bodyMedium)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                const UserScreen(),
                IssueScreen(search: search),
                const RepoScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
