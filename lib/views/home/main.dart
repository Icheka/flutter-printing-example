import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:plateaumed_printing_research/services/print/main.dart';
import 'package:plateaumed_printing_research/widgets/document_text.dart';
import 'package:printing/printing.dart';

class HomeScreen extends StatelessWidget {
  final String textToPrint =
      // ignore: prefer_single_quotes
      """
Twinkle twinkle little star

How I wonder what you are

Up above the world so high

Like a diamond in the sky


I have a dream....
""";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'Home screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
        Divider(
          color: Colors.lightBlue[50],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: DocumentText(
            text: textToPrint,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Navigator.of(context).pushNamed('/print');

                final pw.Document pdf = await PrinterService.generatePDF(
                  title: 'PlateauMed Corporate Anthem',
                  body: textToPrint,
                  format: const PdfPageFormat(400.0, 250.0),
                );
                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => pdf.save(),
                  dynamicLayout: true,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const SizedBox(
                width: 70.0,
                height: 40.0,
                child: Center(
                  child: Text(
                    'Print!',
                  ),
                ),
              ),
            ),
            Text(
              'or',
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 14.0,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/print');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[300]),
              ),
              child: const SizedBox(
                width: 140.0,
                height: 40.0,
                child: Center(
                  child: Text(
                    'Print from a form',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
