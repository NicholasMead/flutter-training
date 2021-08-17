import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final ValueChanged<int> onPageChange;

  SelectPage({
    required this.pageCount,
    required this.currentPage,
    required this.onPageChange,
    Key? key,
  })  : assert(pageCount >= currentPage && pageCount > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed:
                currentPage > 1 ? () => onPageChange(currentPage - 1) : null,
          ),
          Text("${currentPage} of ${pageCount}"),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: currentPage < pageCount
                ? () => onPageChange(currentPage + 1)
                : null,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
