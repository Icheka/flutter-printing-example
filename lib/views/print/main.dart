import 'package:flutter/material.dart';
import 'package:plateaumed_printing_research/widgets/text_input.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:plateaumed_printing_research/services/print/main.dart';
import 'package:printing/printing.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  TextEditingController docTitle = TextEditingController();
  TextEditingController docBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'Mighty Docs Grow From Little Forms',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Document Title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
              TextInput(
                text: docTitle,
                width: MediaQuery.of(context).size.width - 40.0,
                hint: "Title (defaults to 'PlateauMed')",
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Document Body',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
              TextInput(
                text: docBody,
                width: MediaQuery.of(context).size.width - 40.0,
                hint: 'Body',
                lines: 8,
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade700),
              ),
              child: const SizedBox(
                width: 150.0,
                height: 40.0,
                child: Center(child: Text('Back to previous page')),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _handlePrint();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const SizedBox(
                width: 80.0,
                height: 40.0,
                child: Center(child: Text('Print')),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }

  // print action handler
  Future<void> _handlePrint() async {
    final pw.Document pdf = await PrinterService.generatePDF(
      title: docTitle.text,
      body: docBody.text,
      format: PdfPageFormat.a4, // use A4 page dimensions and formatting
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      dynamicLayout: true,
    );
  }
}
