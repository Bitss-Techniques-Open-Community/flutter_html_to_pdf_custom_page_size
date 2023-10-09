import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/file_utils.dart';
import 'package:flutter_html_to_pdf/pdf_configuration.dart';

class FlutterHtmlToPdf {
  static const MethodChannel _channel =
      const MethodChannel('flutter_html_to_pdf');

static Future<File> convertFromHtmlContent(String htmlContent, String targetDirectory, String targetName, {PdfConfiguration configuration}) async {
    var temporaryCreatedHtmlFile = await FileUtils.createFileWithStringContent(htmlContent, "$targetDirectory/$targetName.html");
    var generatedPdfFilePath = await _convertFromHtmlFilePath(temporaryCreatedHtmlFile.path, configuration);
    var generatedPdfFile = FileUtils.copyAndDeleteOriginalFile(generatedPdfFilePath, targetDirectory, targetName);
    temporaryCreatedHtmlFile.delete();

    return generatedPdfFile;
  }

  static Future<File> convertFromHtmlFile(File htmlFile, String targetDirectory, String targetName, {PdfConfiguration configuration}) async {
    var generatedPdfFilePath = await _convertFromHtmlFilePath(htmlFile.path, configuration);
    var generatedPdfFile = FileUtils.copyAndDeleteOriginalFile(generatedPdfFilePath, targetDirectory, targetName);

    return generatedPdfFile;
  }

  static Future<File> convertFromHtmlFilePath(String htmlFilePath, String targetDirectory, String targetName, {PdfConfiguration configuration}) async {
    var generatedPdfFilePath = await _convertFromHtmlFilePath(htmlFilePath, configuration);
    var generatedPdfFile = FileUtils.copyAndDeleteOriginalFile(generatedPdfFilePath, targetDirectory, targetName);

    return generatedPdfFile;
  }

    static Future<String> _convertFromHtmlFilePath(String htmlFilePath, PdfConfiguration configuration) async {
    return await _channel.invokeMethod('convertHtmlToPdf', <String, dynamic>{
   htmlFilePath': htmlFilePath,
      'delay': configuration?.additionalConvertDelay,
      'width': configuration?.width,
      'height': configuration?.height
    });
  }
}
