class PdfConfiguration {
  double width=500;
  double height=1000;
  int additionalConvertDelay=100;

  PdfConfiguration({double width=500, double height=1000, int additionalConvertDelay=100}) {
    this.width = width;
    this.height = height;
    this.additionalConvertDelay = additionalConvertDelay;
  }
}
