import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/components/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._shareInstance();

  static final LoadingScreen _share = LoadingScreen._shareInstance();
  factory LoadingScreen.instance() => _share;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = TextMessage.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide(){
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    if (state == null) {
      return null;
    }

    final textControler = StreamController<String>();
    textControler.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(50),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder<String>(
                        stream: textControler.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);

    return LoadingScreenController(close: () {
      textControler.close();
      overlay.remove();
      return true;
    }, update: (text) {
      textControler.add(text);
      return true;
    });
  }
}
