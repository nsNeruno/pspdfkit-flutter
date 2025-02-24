///
///  Copyright © 2024 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///

import 'package:flutter/material.dart';
import 'utils/platform_utils.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

class PspdfkitBasicExample extends StatefulWidget {
  final String documentPath;

  const PspdfkitBasicExample({super.key, required this.documentPath});

  @override
  State<PspdfkitBasicExample> createState() => _PspdfkitBasicExampleState();
}

class _PspdfkitBasicExampleState extends State<PspdfkitBasicExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: PlatformUtils.isAndroid(),
        // Do not resize the the document view on Android or
        // it won't be rendered correctly when filling forms.
        resizeToAvoidBottomInset: PlatformUtils.isIOS(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                _controller?.undo();
              },
              icon: const Icon(Icons.undo,),
            ),
            IconButton(
              onPressed: () {
                _controller?.redo();
              },
              icon: const Icon(Icons.redo,),
            ),
          ],
        ),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
                padding: PlatformUtils.isAndroid()
                    ? const EdgeInsets.only(top: kToolbarHeight)
                    : null,
                child: PspdfkitWidget(
                  documentPath: widget.documentPath,
                  onPspdfkitWidgetCreated: (controller) {
                    _controller = controller;
                    // If `annotationsDeleted` is being subscribed unto,
                    // Programmatic redo attempts would fail
                    //
                    // Try adding some annotations, then redo all of it
                    // You may notice the last annotation couldn't be undo-ed
                    // and subsequent redo attempts also not working anymore
                    //
                    // controller.addEventListener(NutrientEvent.annotationsDeleted, (_) {},);
                  },
                ))));
  }

  PspdfkitWidgetController? _controller;
}
