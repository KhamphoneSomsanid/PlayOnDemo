import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/models/player_model.dart';
import 'package:mobile/providers/dialog_provider.dart';
import 'package:mobile/providers/network_provider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/dimens.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/enums.dart';
import 'package:mobile/widgets/user_widget.dart';

class NPlayerListScreen extends StatefulWidget {
  const NPlayerListScreen({Key key}) : super(key: key);

  @override
  _NPlayerListScreenState createState() => _NPlayerListScreenState();
}

class _NPlayerListScreenState extends State<NPlayerListScreen> {
  final _listController = ScrollController();

  List<PlayerModel> _playerList = [];
  List<PlayerModel> _showList = [];

  FilterType type = FilterType.ByNameAZ;
  String _search = '';
  var _isSearch = false;
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Timer.run(() => _freshPlayers());
    _searchController.addListener(() {
      _search = _searchController.text;
      _filterUser(_search);
    });
  }

  @override
  void dispose() {
    _listController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  void _freshPlayers() async {
    var res = await NetworkProvider.of(context).post(
      "https://fantasy-stage-api.formula1.com",
      "partner_games/f1/players",
      {},
      isProgress: true,
    );
    if (res != null) {
      _playerList = List.of(res["players"])
          .map((playerJson) => PlayerModel.fromJson(playerJson))
          .toList();
      _filterUser('');
    } else {
      DialogProvider.of(context).showSnackBar(
        'Server Error',
        type: SnackBarType.ERROR,
      );
    }
  }

  void _filterUser(String search) {
    _showList.clear();
    if (search.isEmpty) {
      _showList.addAll(_playerList);
    } else {
      for (var player in _playerList) {
        if (player.isContainKey(search)) _showList.add(player);
      }
    }
    switch (type) {
      case FilterType.ByNameAZ:
        _showList.sort((a, b) => a.display_name.compareTo(b.display_name));
        break;
      case FilterType.ByPriceBig:
        _showList.sort(
            (b, a) => double.parse(a.price).compareTo(double.parse(b.price)));
        break;
      case FilterType.ByPoints:
        _showList.sort((a, b) =>
            double.parse(a.position).compareTo(double.parse(b.position)));
        break;
      case FilterType.ByNameZA:
        _showList.sort((a, b) => b.display_name.compareTo(a.display_name));
        break;
      case FilterType.ByPriceSmall:
        _showList.sort(
            (b, a) => double.parse(b.price).compareTo(double.parse(a.price)));
        break;
    }
    setState(() {});
  }

  void _showBottomFilterMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (_) => Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: POColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 24.0,
                ),
                Text(
                  'Filter By',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Icon(Icons.clear),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            for (var content in Constants.kFilterContents)
              Padding(
                child: InkWell(
                  onTap: () {
                    type = _getFilterType(
                        Constants.kFilterContents.indexOf(content));
                    _filterUser(_search);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 24.0,
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Constants.kFilterContents.indexOf(content) ==
                              _getSortedIndex()
                          ? Icon(
                              Icons.check,
                              color: POColors.green,
                            )
                          : Container(
                              width: 24.0,
                            ),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(16.0),
              ),
          ],
        ),
      ),
    );
  }

  String _getSortedName() {
    switch (type) {
      case FilterType.ByNameAZ:
        return 'NAME';
        break;
      case FilterType.ByNameZA:
        return 'NAME';
        break;
      case FilterType.ByPriceBig:
        return 'PRICE';
        break;
      case FilterType.ByPriceSmall:
        return 'PRICE';
        break;
      case FilterType.ByPoints:
        return 'POINTS';
        break;
    }
    return '';
  }

  int _getSortedIndex() {
    switch (type) {
      case FilterType.ByNameAZ:
        return 0;
        break;
      case FilterType.ByNameZA:
        return 1;
        break;
      case FilterType.ByPriceBig:
        return 2;
        break;
      case FilterType.ByPriceSmall:
        return 3;
        break;
      case FilterType.ByPoints:
        return 4;
        break;
    }
    return 0;
  }

  FilterType _getFilterType(int index) {
    switch (index) {
      case 0:
        return FilterType.ByNameAZ;
      case 1:
        return FilterType.ByNameZA;
      case 2:
        return FilterType.ByPriceBig;
      case 3:
        return FilterType.ByPriceSmall;
      case 4:
        return FilterType.ByPoints;
    }
    return FilterType.ByNameAZ;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Dimension dimension = Dimension(MediaQuery.of(context).size);
        return Scaffold(
          appBar: AppBar(
            title: Text('Select Player'),
            actions: [
              if (dimension.getStatus() < 3) IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearch = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: () => _showBottomFilterMenu(),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              if (_isSearch && dimension.getStatus() < 3) _searchWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: offsetBase,
                ),
                child: dimension.getStatus() < 3
                    ? _topBudgetWidget()
                    : Row(
                        children: [
                          Expanded(
                            child: _topBudgetWidget(),
                          ),
                          SizedBox(
                            width: offsetBase,
                          ),
                          Expanded(
                            child: _searchWidget(isLarge: true),
                          ),
                        ],
                      ),
              ),
              Container(
                height: 0.5,
                color: POColors.dividerColor,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Scrollbar(
                      child: ListView.separated(
                        controller: _listController,
                        itemBuilder: (context, i) => dimension.getStatus() < 3
                            ? UserListWidget(model: _showList[i])
                            : UserNListWidget(model: _showList[i]),
                        separatorBuilder: (context, i) => Divider(),
                        itemCount: _showList.length,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        margin: EdgeInsets.only(bottom: 10.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: POColors.white,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${_showList.length} RESULTS SORTED BY ${_getSortedName()}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: 1,
                                  height: 36,
                                  color: POColors.lightGray,
                                ),
                                Icon(
                                  Icons.sort,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                color: POColors.dividerColor,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: offsetBase,
                ),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      'Hide list',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'TO PICK:',
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '1/6',
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      width: 1.0,
                      height: 16.0,
                      color: POColors.dividerColor,
                    ),
                    Text(
                      'AVERAGE:',
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '\$0.0M',
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Card(
            margin: EdgeInsets.only(bottom: 50),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: InkWell(
              onTap: () => _listController.animateTo(
                _listController.position.minScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: POColors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_upward,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _topBudgetWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Budget',
              style: TextStyle(fontSize: 12.0),
            ),
            Row(
              children: [
                Text(
                  '\$00.0',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  'M',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: offsetXSm),
          child: LinearProgressIndicator(
            value: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _searchWidget({
    bool isLarge = false,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isLarge ? 0 : offsetBase,
        vertical: isLarge ? 0 : offsetBase,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: POColors.white,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: TextField(
          controller: _searchController,
          cursorColor: POColors.green,
          decoration: InputDecoration(
            focusColor: POColors.green,
            hoverColor: POColors.green,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: POColors.green,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
                color: POColors.green,
              ),
              onPressed: () {
                _search = '';
                _isSearch = false;
                _searchController.text = '';
                _filterUser('');
              },
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
