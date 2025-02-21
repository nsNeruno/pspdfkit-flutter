///  Copyright © 2024 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///
///

import 'dart:ui';

import 'package:pspdfkit_flutter/src/events/nutrient_events_extension.dart';
import 'package:pspdfkit_flutter/src/web/pspdfkit_web_instance.dart';
import '../../pspdfkit.dart';
import '../web/pspdfkit_web.dart';

/// A controller for a PSPDFKit widget for Web.
class PspdfkitWidgetControllerWeb extends PspdfkitWidgetController {
  final PspdfkitWebInstance pspdfkitInstance;

  PspdfkitWidgetControllerWeb(this.pspdfkitInstance);

  @override
  Future<dynamic> getAnnotations(int pageIndex, String type) async {
    return pspdfkitInstance.getAnnotations(pageIndex);
  }

  @override
  Future<bool?> addAnnotation(Map<String, dynamic> jsonAnnotation) async {
    await pspdfkitInstance.addAnnotation(jsonAnnotation);
    return Future.value(true);
  }

  @override
  Future<bool?> applyInstantJson(String annotationsJson) async {
    await pspdfkitInstance.applyInstantJson(annotationsJson);
    return Future.value(true);
  }

  @override
  Future<String?> exportInstantJson() {
    return pspdfkitInstance.exportInstantJson();
  }

  @override
  Future<bool?> exportXfdf(String xfdfPath) async {
    await pspdfkitInstance.exportXfdf(xfdfPath);
    return Future.value(true);
  }

  @override
  Future<dynamic> getAllUnsavedAnnotations() {
    return pspdfkitInstance.getAllAnnotations();
  }

  @override
  Future<String?> getFormFieldValue(String fullyQualifiedName) {
    return pspdfkitInstance.getFormFieldValue(fullyQualifiedName);
  }

  @override
  Future<bool?> importXfdf(String xfdfPath) async {
    await pspdfkitInstance.importXfdf(xfdfPath);
    return Future.value(true);
  }

  @override
  Future<bool?> processAnnotations(
      AnnotationType type,
      AnnotationProcessingMode processingMode,
      String destinationPath,
      ) {
    throw UnimplementedError('This method is not supported on the web!');
  }

  @override
  Future<bool?> removeAnnotation(jsonAnnotation) async {
    await pspdfkitInstance.removeAnnotation(jsonAnnotation);
    return Future.value(true);
  }

  @override
  Future<bool?> save() async {
    await pspdfkitInstance.save();
    return Future.value(true);
  }

  @override
  Future<bool?> setAnnotationConfigurations(
      Map<AnnotationTool, AnnotationConfiguration> configurations) async {
    throw UnimplementedError('This method is not supported on the web!');
  }

  @override
  Future<bool?> setFormFieldValue(
      String value, String fullyQualifiedName) async {
    await pspdfkitInstance.setFormFieldValue(value, fullyQualifiedName);
    return Future.value(true);
  }

  void dispose() {
    PSPDFKitWeb.unload(pspdfkitInstance.jsObject);
  }

  @override
  Future<void> addEventListener(
      NutrientEvent event, Function(dynamic) callback) async {
    return pspdfkitInstance.addEventListener(event.webName, callback);
  }

  @override
  Future<void> removeEventListener(NutrientEvent event) {
    throw UnimplementedError('This method is not supported on the web!');
  }

  @override
  Future<Rect> getVisibleRect(int pageIndex) {
    // This method is not supported on the web.
    throw UnimplementedError('This method is not supported yet on web!');
  }

  @override
  Future<void> zoomToRect(int pageIndex, Rect rect) {
    return pspdfkitInstance.zoomToRect(pageIndex, rect);
  }

  @override
  Future<double> getZoomScale(int pageIndex) {
    return pspdfkitInstance.getZoomScale(pageIndex);
  }

  @override
  Future<bool> canUndo() {
    return pspdfkitInstance.canUndo();
  }

  @override
  Future<void> undo() async {
    await pspdfkitInstance.undo();
  }

  @override
  Future<bool> canRedo() {
    return pspdfkitInstance.canRedo();
  }

  @override
  Future<void> redo() async {
    await pspdfkitInstance.redo();
  }

  @override
  Future<Map?> getAnnotationState() async {
    return {
      'state': pspdfkitInstance.viewState['interactionMode'],
      // 'variant': null,
    };
  }

  @override
  Future<void> toggleInkAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('ink',);
    await pspdfkitInstance.setInteractionMode('INK',);
  }

  @override
  Future<void> toggleInkHighlightAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('highlighter',);
    await pspdfkitInstance.setInteractionMode('INK',);
  }

  @override
  Future<void> toggleLineAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('line',);
    await pspdfkitInstance.setInteractionMode('SHAPE_LINE',);
  }

  @override
  Future<void> toggleArrowAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('arrow',);
    await pspdfkitInstance.setInteractionMode('SHAPE_LINE',);
  }

  @override
  Future<void> toggleSquareAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('rectangle',);
    await pspdfkitInstance.setInteractionMode('SHAPE_RECTANGLE',);
  }

  @override
  Future<void> toggleCircleAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('ellipse',);
    await pspdfkitInstance.setInteractionMode('SHAPE_ELLIPSE',);
  }

  @override
  Future<void> toggleCloudAnnotation() async {
    await pspdfkitInstance.setCurrentAnnotationPreset('cloudy-polygon',);
    await pspdfkitInstance.setInteractionMode('SHAPE_POLYGON',);
  }

  @override
  Future<void> toggleCalloutAnnotation() async {
    await pspdfkitInstance.setInteractionMode('CALLOUT',);
  }

  @override
  Future<void> toggleFreeTextAnnotation() async {
    await pspdfkitInstance.setInteractionMode('TEXT',);
  }
}
