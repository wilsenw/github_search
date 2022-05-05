import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/http_services.dart';

class UserScreen extends StatefulWidget {
  final String search;
  const UserScreen({Key? key, required this.search}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UserScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  _loadMore() {
    _currentMax += 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String search = widget.search;
    return FutureBuilder(
        future: getUserData(search),
        builder: (BuildContext context, AsyncSnapshot<List<MUser>> snapshot) {
          List<MUser>? userData = snapshot.data;
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
                controller: _scrollController,
                itemCount: itemCount(snapshot.data?.length, _currentMax),
                itemBuilder: (context, index) {
                  if (index == itemCount(snapshot.data?.length, _currentMax)) {
                    return const CupertinoActivityIndicator();
                  }
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          userData![index].imageURL,
                          height: 62,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(userData[index].username,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ));
                });
          }
        });
  }
}

int itemCount(int? length, int max) {
  print(length);
  print(max);
  if (length == null) {
    return 0;
  } else if (length < max) {
    return length;
  } else {
    return max;
  }
}
