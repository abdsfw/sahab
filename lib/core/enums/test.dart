/*
! to manage scroll storage
import 'package:flutter/material.dart';

class ScrollablePage extends StatelessWidget {
  final String title;
  final int pageIndex;

  ScrollablePage({required this.title, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ScrollablePageContent(
        key: PageStorageKey<String>(title), // Unique key for each page
        pageIndex: pageIndex,
      ),
    );
  }
}

class ScrollablePageContent extends StatefulWidget {
  final int pageIndex;

  ScrollablePageContent({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _ScrollablePageContentState createState() => _ScrollablePageContentState();
}

class _ScrollablePageContentState extends State<ScrollablePageContent> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: 100, // Example itemCount
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageStorage.of(context)?.readState(context, identifier: widget.pageIndex.toString()) ?? ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: PageView(
        children: [
          ScrollablePage(title: 'Page 1', pageIndex: 0),
          ScrollablePage(title: 'Page 2', pageIndex: 1),
          // Add more pages as needed
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}



 */
