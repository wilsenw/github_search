import 'package:flutter/material.dart';
import 'package:github_search/models/issue.dart';
import 'package:github_search/models/repo.dart';
import 'package:github_search/screens/issues_screen.dart';
import 'package:github_search/screens/repo_screen.dart';
import 'package:github_search/screens/user_screen.dart';
import 'package:github_search/services/http_services.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

//============ Navigasi Aplikasi ================
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

  //============ Provider untuk semua layar ================
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
      //============ AppBar ================
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                pinned: true,
                floating: true,
                snap: false,
                //============ Search Bar ================
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
                    decoration: const InputDecoration(hintText: "Search"),
                    onSubmitted: (String str) {
                      setState(() {
                        search = str;
                      });
                    },
                    controller: _searchController,
                  ),
                ),
                //============ Tab Bar untuk Navigasi ================
                bottom: TabBar(
                  tabs: [
                    Tab(
                        child: Text("User",
                            style: Theme.of(context).textTheme.bodyLarge)),
                    Tab(
                        child: Text("Issues",
                            style: Theme.of(context).textTheme.bodyLarge)),
                    Tab(
                        child: Text("Repositories",
                            style: Theme.of(context).textTheme.bodyLarge)),
                  ],
                ),
              )
            ],
            body: const TabBarView(
              children: [
                UserScreen(), // Screen user
                IssueScreen(), // Screen issues
                RepoScreen(), // Screen repositories
              ],
            ),
          ),
        ),
      ),
    );
  }
}
