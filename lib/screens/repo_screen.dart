import 'package:flutter/material.dart';

import '../models/repo.dart';
import '../services/http_services.dart';

class RepoScreen extends StatefulWidget {
  final String search;
  const RepoScreen({Key? key, required this.search}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RepoScreenState();
  }
}

class _RepoScreenState extends State<RepoScreen> {
  @override
  Widget build(BuildContext context) {
    String search = widget.search;
    return FutureBuilder(
        future: getRepoData(search),
        builder: (BuildContext context, AsyncSnapshot<List<MRepo>> snapshot) {
          List<MRepo>? repoData = snapshot.data;
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
                              repoData![index].imageURL,
                              height: 62,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(repoData[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(repoData[index].date,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Total Watchers: " +
                                        repoData[index].watchers.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                    "Total Stars: " +
                                        repoData[index].stars.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                    "Total Forks: " +
                                        repoData[index].forks.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
