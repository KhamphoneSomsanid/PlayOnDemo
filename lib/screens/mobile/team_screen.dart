import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/models/player_model.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/dimens.dart';
import 'package:mobile/widgets/button_widget.dart';
import 'package:mobile/widgets/player_detail_widget.dart';
import 'package:mobile/widgets/user_widget.dart';

class TeamScreen extends StatefulWidget {
  final String name;
  final int index;
  final Function() rename;
  final Function() recreate;
  final Function() replicate;
  final Function() delete;

  const TeamScreen({
    Key key,
    this.name,
    this.index,
    this.rename,
    this.recreate,
    this.replicate,
    this.delete,
  }) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Card(
        margin: EdgeInsets.symmetric(
          horizontal: offsetBase,
          vertical: offsetXMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimenCorner),
        ),
        elevation: 5,
        shadowColor: POColors.shadowColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(dimenCorner),
          child: Column(
            children: [
              Container(
                height: dimenHeader,
                child: Row(
                  children: [
                    Container(
                      color: POColors.secondaryColor,
                      width: 40,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'T${widget.index}',
                        style: TextStyle(
                          fontSize: fontsize_17,
                          color: POColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: offsetSm,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: fontsize_17,
                        color: POColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // width: double.infinity,

                  color: POColors.secondaryColor,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(offsetBase),
                          child: SvgPicture.asset(
                              'assets/images/img_back_team.svg'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: offsetBase),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DriverWidget(
                                              player: PlayerModel(),
                                              onClick: () =>
                                                  _detailPlayer(PlayerModel()),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            DriverWidget(
                                              player: PlayerModel(),
                                              onClick: () =>
                                                  _detailPlayer(PlayerModel()),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            DriverWidget(
                                              player: PlayerModel(),
                                              onClick: () =>
                                                  _detailPlayer(PlayerModel()),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DriverWidget(
                                              player: PlayerModel(),
                                              onClick: () =>
                                                  _detailPlayer(PlayerModel()),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            DriverWidget(
                                              player: PlayerModel(),
                                              onClick: () =>
                                                  _detailPlayer(PlayerModel()),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        ConstructorWidget(
                                          player: PlayerModel(),
                                          onClick: () =>
                                              _detailPlayer(PlayerModel()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(offsetBase),
                              child: SvgPicture.asset(
                                'assets/images/img_logo_label.svg',
                                width: 38.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // width: double.infinity,

                height: dimenFooter,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Spacer(),
                    PopupMenuButton(
                      padding: EdgeInsets.zero,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: POColors.lightGray,
                          width: 1.0,
                        ),
                      ),
                      onSelected: (value) {
                        print('[Pop] menu index : $value');
                        switch (value) {
                          case 1:
                            widget.recreate();
                            break;
                          case 2:
                            widget.replicate();
                            break;
                          case 0:
                            widget.rename();
                            break;
                          case 3:
                            widget.delete();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: PopMenuWidget(
                                icon: Icon(Icons.edit_outlined),
                                title: 'Rename'),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: PopMenuWidget(
                                icon: Icon(Icons.copy_outlined),
                                title: 'Recreate'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: PopMenuWidget(
                                icon: Icon(Icons.copy_outlined),
                                title: 'Replicate'),
                            value: 2,
                          ),
                          PopupMenuItem(
                            enabled: false,
                            height: 4,
                            child: Container(
                              height: 1,
                              color: POColors.darkGray,
                            ),
                          ),
                          PopupMenuItem(
                            child: PopMenuWidget(
                                icon: Icon(Icons.delete_outline),
                                title: 'Delete'),
                            value: 3,
                          ),
                        ];
                      },
                      child: Container(
                        width: offsetXMd,
                        height: offsetXMd,
                        decoration: BoxDecoration(
                          color: POColors.lightGray,
                          borderRadius: BorderRadius.circular(offsetXSm),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: POColors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _detailPlayer(PlayerModel model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (_) => PlayerDetailWidget(),
    );
  }
}
