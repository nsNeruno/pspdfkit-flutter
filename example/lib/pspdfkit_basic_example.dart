///
///  Copyright © 2024-2025 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'utils/platform_utils.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

class PspdfkitBasicExample extends StatelessWidget {
  final String documentPath;

  const PspdfkitBasicExample({super.key, required this.documentPath});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: PlatformUtils.isAndroid(),
        // Do not resize the the document view on Android or
        // it won't be rendered correctly when filling forms.
        resizeToAvoidBottomInset: PlatformUtils.isIOS(),
        appBar: AppBar(),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
                padding: PlatformUtils.isAndroid()
                    ? const EdgeInsets.only(top: kToolbarHeight)
                    : null,
                child: PspdfkitWidget(
                  documentPath: documentPath,
                ))));
  }
}

class PspdfkitSplitExample extends StatefulWidget {

  const PspdfkitSplitExample({super.key, required this.documentPath});

  @override
  State<PspdfkitSplitExample> createState() => _PspdfkitSplitExampleState();

  final String documentPath;
}

class _PspdfkitSplitExampleState extends State<PspdfkitSplitExample> {

  @override
  void initState() {
    super.initState();
    _loadAndSplit();
  }

  @override
  Widget build(BuildContext context) {
    final documentPath = this.splitBlobPath;
    return Scaffold(
      extendBodyBehindAppBar: PlatformUtils.isAndroid(),
      // Do not resize the the document view on Android or
      // it won't be rendered correctly when filling forms.
      resizeToAvoidBottomInset: PlatformUtils.isIOS(),
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: PlatformUtils.isAndroid()
              ? const EdgeInsets.only(top: kToolbarHeight)
              : null,
          child: Builder(
            builder: (_) {
              if (documentPath == null) {
                return const SizedBox.shrink();
              }
              return PspdfkitWidget(
                documentPath: documentPath,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _loadAndSplit() async {
    final instance = await PSPDFKitWeb.load(
      widget.documentPath,
      null,
      PdfConfiguration(
        webConfiguration: PdfWebConfiguration(
          headless: true,
        ),
      ),
    );
    final pageOneBytes = await instance.exportPdfWithOperations(
      const PspdfkitWebKeepPagesOperation(pageIndexes: {1,},),
    );
    final pdfBlob = html.Blob(pageOneBytes, 'application/pdf',);
    setState(
      () {
        splitBlobPath = html.Url.createObjectUrlFromBlob(pdfBlob,);
      },
    );
  }

  String? splitBlobPath;
}