import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TemplateModel {
  TemplateModel({
    this.automaticOverflow = true,
    this.documentFormat = PdfPageFormat.a4,
    this.title,
  });

  pw.Document pdf;

  /// A list of text to be converted into pw.Page's
  final List<String> pages = <String>[];

  /// Specifies whether page content should be allowed to 'flow' into a new page if it is too large to fit in one.
  /// If false, the developer would need to add pw.Page's to the pages list manually. This offers greater control.
  /// As a rule of thumb, if you need to print only one page, but aren't sure it wouldn't overflow, set this to 'true'.
  /// Defaults to 'true'.
  final bool automaticOverflow;

  /// The format (page dimension, margin, aspect ratio, etc) to be used for each page of the document. Defaults to the popular A4 print document format.
  final PdfPageFormat documentFormat;

  /// A title for this document. Will be displayed as a header of HTML class <Header1>
  String title;

  pw.Document generateDocument() {
    pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      author: 'PlateauMed Nigeria Limited',
      title: title,
    );

    if (automaticOverflow) {
      for (final String page in pages) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Center(
                    child: pw.Text(
                      title,
                      style: const pw.TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    height: 12.0,
                  ),
                  pw.Text(page)
                ],
              );
            },
          ),
        );
      }
    } else {
      for (final String page in pages) {
        pdf.addPage(
          pw.MultiPage(
            build: (pw.Context context) => <pw.Widget>[
              pw.Center(
                child: pw.Text(page),
              ),
            ],
          ),
        );
      }
    }

    return pdf;
  }
}
