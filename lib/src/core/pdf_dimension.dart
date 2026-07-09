enum PdfUnit {
  px('px'),
  inch('in'),
  cm('cm'),
  mm('mm');

  final String value;
  const PdfUnit(this.value);
}

class PdfDimension {
  final String value;

  const PdfDimension.string(this.value);
  PdfDimension.number(num value) : value = value.toString();
  PdfDimension.withUnit(num value, PdfUnit unit)
    : value = '$value${unit.value}';

  @override
  String toString() => value;
}
