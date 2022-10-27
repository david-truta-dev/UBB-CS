import 'package:flutter/material.dart';
import '../../theming/dimensions.dart';

class TabBarWidget extends StatefulWidget {
  final List<Map<String, Widget>> screens;
  const TabBarWidget({Key? key, required this.screens}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  Widget _buildTab(Text text, Icon icon) {
    return Tab(
      icon: icon,
      text: text.data,
      iconMargin: tabIconMargin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.screens.length,
      child: Scaffold(
        body: TabBarView(
          children: widget.screens.map((e) => e['screen']!).toList(),
        ),
        bottomNavigationBar: Container(
          height: tabBarHeight,
          color: Theme.of(context).primaryColor,
          child: TabBar(
            labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
            labelStyle: Theme.of(context).textTheme.labelSmall,
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
            tabs: widget.screens.map((e) {
              return _buildTab(e['label'] as Text, e['icon'] as Icon);
            }).toList()
          ),
        ),
      ),
    );
  }
}
