import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/utils/navigator_helper.dart';

class ToolScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ToolScaffold({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildSpacedChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildSpacedChildren() {
    final spaced = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i < children.length - 1) {
        spaced.add(const SizedBox(height: 24));
      }
    }
    return spaced;
  }
}
