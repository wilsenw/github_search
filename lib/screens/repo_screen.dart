import 'package:flutter/material.dart';

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
    return Text("Repo Screen",
        style: Theme.of(context).textTheme.headlineMedium);
  }
}
