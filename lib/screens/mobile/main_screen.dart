import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/generated/l10n.dart';
import 'package:mobile/providers/navigator_provider.dart';
import 'package:mobile/screens/mobile/empty_screen.dart';
import 'package:mobile/screens/mobile/player_list_screen.dart';
import 'package:mobile/screens/mobile/team_screen.dart';
import 'package:mobile/themes/dimens.dart';
import 'package:mobile/widgets/rename_bottom_widget.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _pageNotifier = ValueNotifier<int>(-1);

  List<String> _teams = [];

  @override
  void initState() {
    super.initState();
  }

  void _addPage() {
    _teams.add("Team Name");
    _pageNotifier.value = _teams.length;
  }

  void _deletePage(int index) {
    print('[Screen] delete : $index');
    _teams.removeAt(index);
    _pageNotifier.value = _teams.length;
  }

  void _rename(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (_) => RenameBottomWidget(
        index: index + 1,
        onSubmitted: (value) {
          setState(() {
            _teams[index] = value;
          });
        },
      ),
    );
  }

  void _recreate(int index) {
    setState(() {
      _teams[index] = 'Team Name';
    });
  }

  void _replicate(int index) {
    if (_teams.length < 3) {
      var title = _teams[index];
      _teams.insert(index + 1, title);
      _pageNotifier.value = _teams.length;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(offsetSm),
          child: SvgPicture.asset('assets/images/img_logo.svg'),
        ),
        title: Text(S.current.teams),
        actions: [
          IconButton(
            icon: Icon(Icons.menu_outlined),
            onPressed: () => NavigatorProvider.of(context).pushToWidget(
              screen: PlayerListScreen(),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _pageNotifier,
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemBuilder: (context, i) {
                    if (i < _teams.length) {
                      return TeamScreen(
                        name: _teams[i],
                        index: i + 1,
                        rename: () => _rename(i),
                        recreate: () => _recreate(i),
                        replicate: () => _replicate(i),
                        delete: () => _deletePage(i),
                      );
                    } else {
                      return EmptyScreen(
                        action: () => _addPage(),
                        index: _teams.length + 1,
                      );
                    }
                  },
                  itemCount: min(_teams.length + 1, 3),
                  onPageChanged: (index) {
                    _currentPageNotifier.value = index;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(offsetSm),
                child: CirclePageIndicator(
                  itemCount: min(_teams.length + 1, 3),
                  currentPageNotifier: _currentPageNotifier,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
