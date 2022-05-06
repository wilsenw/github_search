import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repo.dart';

//============ Layar Repo ================
class RepoScreen extends StatefulWidget {
  const RepoScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RepoScreenState();
  }
}

class _RepoScreenState extends State<RepoScreen> {
  //============ Inisialisasi dan Lazy Loading ================
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

  //============ Tampilan Layar Issue ================
  @override
  Widget build(BuildContext context) {
    final List<MRepo> repoData = Provider.of<List<MRepo>>(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(children: [
        Expanded(
          flex: 1,
          child: buttons(repoData.length), // tombol lazy loading & with index
        ),
        Expanded(
            flex: 7,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: itemCount(repoData.length, _currentMax),
                  itemBuilder: (context, index) {
                    if (index == itemCount(repoData.length, _currentMax)) {
                      return const CupertinoActivityIndicator();
                    }
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              repoData[index + _currentMin].imageURL,
                              height: 62,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(repoData[index + _currentMin].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                                Text(
                                    repoData[index + _currentMin]
                                        .date
                                        .substring(0, 10),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Total Watchers: " +
                                        repoData[index + _currentMin]
                                            .watchers
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                    "Total Stars: " +
                                        repoData[index + _currentMin]
                                            .stars
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(
                                    "Total Forks: " +
                                        repoData[index + _currentMin]
                                            .forks
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  }),
            )),
        pagination(repoData.length),
      ]),
    );
  }

  //============ Tombol Page Number ================
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
                  child: Text(i.toString(),
                      style: Theme.of(context).textTheme.headlineMedium),
                )
            ],
          ),
        );
      }
    }
  }

  //============ Tombol Lazy Loading & With Index ================
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

//============ Jumlah item pada list ================
int itemCount(int? length, int max) {
  if (length == null) {
    return 0;
  } else if (length < max) {
    return length;
  } else {
    return max;
  }
}
