import 'package:flutter/material.dart';
import 'package:flutter_luk/flutter_luk.dart';

class GamePage extends StatefulWidget {
  final int gameId;
  final String gameName;
  final String gameUrl;

  const GamePage(
      {super.key,
      required this.gameId,
      required this.gameName,
      required this.gameUrl});

  @override
  State<GamePage> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: Colors.tealAccent,
            child: const Center(
              child: Text(
                "Room UI",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )),
          GameView(
            key: ValueKey(widget.gameId),
            url: widget.gameUrl,
            gid: widget.gameId.toString(),
            rid: "这里填写业务方的房间ID",
            canOpenGame: true,
            //是否可以打开游戏
            language: "en",
            //游戏语言
            width: MediaQuery.of(context).size.width.toInt(),
            height: MediaQuery.of(context).size.height.toInt(),
            cid: '这里填写LUK给的Appid',
            uid: "业务用户Uid",
            token: "业务token,",
            padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.of(context).padding.top + 32,
                16,
                MediaQuery.of(context).padding.bottom + 16),
            //游戏安全区
            preJoinGame: (int uid, int seat) async {
              //TODO 加入前回调
              return true;
            },
            openChargePage: () async {
              //TODO 跳转 到充值页面
            },
          ),
        ],
      ),
    );
  }
}
