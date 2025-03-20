/// See [PSPDFKit.DocumentOperation.html](https://www.nutrient.io/api/web/PSPDFKit.DocumentOperation.html)
abstract class PspdfkitWebDocumentOperation {

  const PspdfkitWebDocumentOperation._({
    required this.type,
    this.pageIndexes = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      if (pageIndexes.isNotEmpty)
        'pageIndexes': pageIndexes.toList(),
    };
  }

  final String type;
  final Set<int> pageIndexes;
}

// TODO: Define AddPage Operation

class PspdfkitWebKeepPagesOperation extends PspdfkitWebDocumentOperation {

  const PspdfkitWebKeepPagesOperation({
    required super.pageIndexes,
  }): super._(type: 'keepPages',);
}

class PspdfkitWebDuplicatePagesOperation extends PspdfkitWebDocumentOperation {

  const PspdfkitWebDuplicatePagesOperation({
    required super.pageIndexes,
  }): super._(type: 'duplicatePages',);
}

class PspdfkitWebMovePagesOperation extends PspdfkitWebDocumentOperation {

  const PspdfkitWebMovePagesOperation({
    required super.pageIndexes,
    required this.targetPageIndex,
    this.insertAfter = true,
  }): super._(type: 'movePages',);

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    if (insertAfter)
      'afterPageIndex': targetPageIndex
    else
      'beforePageIndex': targetPageIndex,
  };

  final int targetPageIndex;
  final bool insertAfter;
}

enum PspdfkitWebRotateDegree {
  degree0(0,),
  degree90(90,),
  degree180(180,),
  degree270(270,);

  const PspdfkitWebRotateDegree(this.value,);

  final int value;
}

class PspdfkitWebRotatePagesOperation extends PspdfkitWebDocumentOperation {

  PspdfkitWebRotatePagesOperation({
    required super.pageIndexes,
    required this.rotateBy,
  }): super._(type: 'rotatePages',);

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    'rotateBy': rotateBy.value,
  };

  final PspdfkitWebRotateDegree rotateBy;
}

class PspdfkitWebRemovePagesOperation extends PspdfkitWebDocumentOperation {

  const PspdfkitWebRemovePagesOperation({
    required super.pageIndexes,
  }): super._(type: 'removePages',);
}

// TOOD: Define ImportDocument operation