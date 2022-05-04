import 'package:flutter/material.dart';

class IssueScreen extends StatefulWidget {
  final String search;
  const IssueScreen({Key? key, required this.search}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _IssueScreenState();
  }
}

class _IssueScreenState extends State<IssueScreen> {
  @override
  Widget build(BuildContext context) {
    String search = widget.search;
    return Text(search, style: Theme.of(context).textTheme.headlineMedium);
  }
}
