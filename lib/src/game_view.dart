import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameView extends StatefulWidget {
  final String url;
  final String cid;
  final String gid;
  final String uid;
  final String rid;
  final String token;
  final String language;
  final bool canOpenGame;
  final int width;
  final int height;
  final EdgeInsets padding;

  final Future<void> Function()? gameLoadFail;
  final Future<bool> Function(int uid, int seat)? preJoinGame;
  final Future<void> Function(int uid)? joinGame;
  final Future<void> Function(int uid)? gamePrepare;
  final Future<void> Function(int uid)? cancelPrepare;
  final Future<void> Function(int uid)? gameTerminated;
  final Future<void> Function(int uid)? gameOver;

  final Future<void> Function()? openChargePage;
  final Future<void> Function()? closeGamePage;

  const GameView({
    super.key,
    required this.url,
    required this.cid,
    required this.gid,
    required this.uid,
    required this.rid,
    required this.token,
    required this.language,
    required this.canOpenGame,
    required this.width,
    required this.height,
    required this.padding,
    this.gameLoadFail,
    this.preJoinGame,
    this.joinGame,
    this.gamePrepare,
    this.cancelPrepare,
    this.gameTerminated,
    this.gameOver,
    this.openChargePage,
    this.closeGamePage,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() async {
    final injectJS =
        await rootBundle.loadString('packages/flutter_luk/assets/inject.js');

    _controller
      ..setBackgroundColor(Colors.transparent)
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('CFGameLifeCaller', onMessageReceived: (msg) {
        final param = jsonDecode(msg.message);
        if (param['func'] == 'gameLoadFail') {
          widget.gameLoadFail?.call();
        } else if (param['func'] == 'joinGame') {
          final userId = param['userId'];
          widget.joinGame?.call(int.parse(userId));
        } else if (param['func'] == 'gamePrepare') {
          final userId = param['userId'];
          widget.gamePrepare?.call(int.parse(userId));
        } else if (param['func'] == 'cancelPrepare') {
          final userId = param['userId'];
          widget.cancelPrepare?.call(int.parse(userId));
        } else if (param['func'] == 'gameTerminated') {
          final userId = param['userId'];
          widget.gameTerminated?.call(int.parse(userId));
        } else if (param['func'] == 'gameOver') {
          final userId = param['userId'];
          widget.gameOver?.call(int.parse(userId));
        } else if (param['func'] == 'preJoinGame') {
          final invokeId = param['invokeId'];
          final userId = param['userId'];
          final seat = param['seat'];
          if (widget.preJoinGame != null) {
            widget.preJoinGame!(int.parse(userId), seat).then((value) {
              final js = '''
                cfgCallJsBacks['$invokeId'](JSON.stringify({
                  code: ${value ? 0 : -1},
                  msg: ${value ? '"success"' : '"fail"'},
                  result: {
                    is_ready: ${value ? 'true' : 'false'}
                   }
                }));
              ''';
              _controller.runJavaScript(js);
            });
          } else {
            final js = '''
                cfgCallJsBacks['$invokeId'](JSON.stringify({
                  code: 0,
                  msg: 'success',
                  result: {
                    is_ready: true
                  }
                }));
              ''';

            _controller.runJavaScript(js);
          }
        }
      })
      ..addJavaScriptChannel('CFGameOpenApiCaller', onMessageReceived: (msg) {
        final param = jsonDecode(msg.message);
        if (param['func'] == 'getBaseInfo') {
          final invokeId = param['invokeId'];

          final js = '''
            cfgCallJsBacks['$invokeId'](JSON.stringify({
              code: 0,
              msg: 'success',
              result: {
                cid: '${widget.cid}',
                gid: '${widget.gid}',
                uid: '${widget.uid}',
                token: '${widget.token}',
                version: '1.3.5',
                language: '${widget.language}',
                window: '${widget.width}x${widget.height}',
                rid: '${widget.rid}',
                room_owner: ${widget.canOpenGame ? 'true' : 'false'}
              }
            }));
          ''';
          _controller.runJavaScript(js);
        } else if (param['func'] == 'getWindowSafeArea') {
          final invokeId = param['invokeId'];

          final js = '''
            cfgCallJsBacks['$invokeId'](JSON.stringify({
              code: 0,
              msg: 'success',
              result: {
                top: ${widget.padding.top},
                left: ${widget.padding.left},
                right: ${widget.padding.right},
                bottom: ${widget.padding.bottom},
                scale_min_limit: 0.01
              }
            }));
          ''';

          _controller.runJavaScript(js);
        } else if (param['func'] == 'openChargePage') {
          widget.openChargePage?.call();
        } else if (param['func'] == 'closeGamePage') {
          widget.closeGamePage?.call();
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _controller.runJavaScript(injectJS);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }
}
