import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrinterService {
  static Future<pw.Document> generatePDF({
    PdfPageFormat format,
    String title,
    String body,
  }) async {
    final pw.Document pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );
    final pw.Font font = await PdfGoogleFonts.nunitoBold();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
            children: <pw.Widget>[
              pw.SizedBox(
                width: double.infinity,
                child: pw.Center(
                  child: pw.Text(
                    title == null || title == '' ? 'PlateauMed' : title,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 21.0,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColors.amber,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Text(
                body,
                style: pw.TextStyle(
                  font: font,
                ),
              )
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
