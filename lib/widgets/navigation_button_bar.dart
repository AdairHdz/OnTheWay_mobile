import "package:flutter/material.dart";

class NavigationButtonBar extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final int totalRows;
  final Function nextPageHandler;
  final Function previousPageHandler;
  final Function firstPageHandler;
  final Function lastPageHandler;
  NavigationButtonBar(
      {this.currentPage,
      this.totalPages,
      this.totalRows,
      this.nextPageHandler,
      this.previousPageHandler,
      this.firstPageHandler,
      this.lastPageHandler});

  @override
  _NavigationButtonBarState createState() => _NavigationButtonBarState();
}

class _NavigationButtonBarState extends State<NavigationButtonBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: widget.firstPageHandler,
            icon: Icon(Icons.skip_previous_rounded),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: widget.previousPageHandler,
            icon: Icon(Icons.navigate_before),
            color: Theme.of(context).primaryColor,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                widget.currentPage.toString() == null
                    ? "1"
                    : widget.currentPage.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              )),
          IconButton(
            onPressed: widget.nextPageHandler,
            icon: Icon(Icons.navigate_next),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: widget.lastPageHandler,
            icon: Icon(Icons.skip_next_rounded),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
