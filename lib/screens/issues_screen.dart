import 'package:flutter/material.dart';
import 'package:github_search/models/issue.dart';

import '../services/http_services.dart';

class IssueScreen extends StatefulWidget {
  final String search;
  const IssueScreen({Key? key, required this.search}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _IssueScreenState();
  }
}

class _IssueScreenState extends State<IssueScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _currentMax = 10;
  @override
  Widget build(BuildContext context) {
    String search = widget.search;
    return FutureBuilder(
        future: getIssueData(search),
        builder: (BuildContext context, AsyncSnapshot<List<MIssue>> snapshot) {
          List<MIssue>? issueData = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Please wait its loading...'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.network(
                              issueData![index].imageURL,
                              height: 62,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(issueData[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(issueData[index].date,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("State: " + issueData[index].state,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  });
            }
          }
        });
  }
}
