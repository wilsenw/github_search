import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_search/models/issue.dart';
import 'package:provider/provider.dart';

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
  int _currentMax = 10;
  int _currentMin = 0;
  bool _lazyLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_lazyLoading) {
          _loadMore();
        }
      }
    });
  }

  _loadMore() {
    _currentMax += 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<MIssue> issueData = Provider.of<List<MIssue>>(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: buttons(issueData.length),
        ),
        Expanded(
          flex: 7,
          child: ListView.builder(
              controller: _scrollController,
              itemCount: itemCount(issueData.length, _currentMax),
              itemBuilder: (context, index) {
                if (index == itemCount(issueData.length, _currentMax)) {
                  return const CupertinoActivityIndicator();
                }
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          issueData[index + _currentMin].imageURL,
                          height: 62,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(issueData[index + _currentMin].title,
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(issueData[index + _currentMin].date,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "State: " +
                                    issueData[index + _currentMin].state,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              }),
        ),
        pagination(issueData.length),
      ],
    );
  }

  Widget pagination(int totalItem) {
    List list = [];
    for (int i = 1; i <= (totalItem / 10).ceil(); i++) {
      list.add(i);
    }
    if (_lazyLoading) {
      return const SizedBox();
    } else {
      if (totalItem < 10) {
        return const SizedBox();
      } else {
        return Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i in list)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentMax = 10;
                      _currentMin = (i * 10) - 10;
                    });
                  },
                  child: Text(i.toString()),
                )
            ],
          ),
        );
      }
    }
  }

  Widget buttons(int totalItem) {
    if (_lazyLoading) {
      return Padding(
        padding: const EdgeInsets.only(right: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Lazy Loading'),
              onPressed: () {
                setState(() {
                  _lazyLoading = true;
                });
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.teal,
                  side: const BorderSide(color: Colors.teal, width: 5),
                  padding: const EdgeInsets.all(15)),
              child: const Text('With Index'),
              onPressed: () {
                setState(() {
                  _lazyLoading = false;
                  if (_currentMax > totalItem) {
                    _currentMin = totalItem - 10;
                    if (_currentMin < 0) {
                      _currentMin = 0;
                    }
                  } else {
                    _currentMin = _currentMax - 10;
                  }
                  _currentMax = 10;
                });
              },
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.teal,
                  side: const BorderSide(color: Colors.teal, width: 5),
                  padding: const EdgeInsets.all(15)),
              child: const Text('Lazy Loading'),
              onPressed: () {
                setState(() {
                  _currentMin = 0;
                  _lazyLoading = true;
                });
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('With Index'),
              onPressed: () {
                setState(() {
                  _currentMin = 0;
                  _lazyLoading = false;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}

int itemCount(int? length, int max) {
  if (length == null) {
    return 0;
  } else if (length < max) {
    return length;
  } else {
    return max;
  }
}
