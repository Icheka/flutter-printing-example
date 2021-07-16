import 'package:flutter/material.dart';
import 'package:plateaumed_printing_research/models/prescription_model.dart';
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
  TextEditingController hospitalName = TextEditingController();
  TextEditingController testType = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController hospitalNumber = TextEditingController();
  TextEditingController requestingDoctor = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController dateOfRequest = TextEditingController();
  TextEditingController dateOfCollection = TextEditingController();
  TextEditingController urgency = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController signature = TextEditingController();
  TextEditingController specimenType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: ListView(
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
                  hint: "Title (defaults to 'Laboratory Result')",
                ),
              ],
            ),
          ),
          TextGroup(
            controller: hospitalName,
            hint: 'Hospital name',
            label: 'Hospital Name',
          ),
          TextGroup(
            controller: age,
            hint: 'Patient age',
            label: 'Age',
          ),
          TextGroup(
            controller: dateOfCollection,
            hint: 'Date of Collection',
            label: 'Date of Collection',
          ),
          TextGroup(
            controller: dateOfRequest,
            hint: 'Date of Request',
            label: 'Date of Request',
          ),
          TextGroup(
            controller: diagnosis,
            hint: 'Diagnosis',
            label: 'Diagnosis',
          ),
          TextGroup(
            controller: gender,
            hint: 'Gender',
            label: 'Gender',
          ),
          TextGroup(
            controller: patientName,
            hint: 'Patient name',
            label: 'Patient Name',
          ),
          TextGroup(
            controller: requestingDoctor,
            hint: 'Requesting Doctor',
            label: 'Requesting Doctor',
          ),
          TextGroup(
            controller: signature,
            hint: 'Signature',
            label: 'Signature',
          ),
          TextGroup(
            controller: specimenType,
            hint: 'Specimen type',
            label: 'Specimen Type',
          ),
          TextGroup(
            controller: testType,
            hint: 'Clinical Pathology | Microbiology | etc',
            label: 'Test Type',
          ),
          TextGroup(
            controller: unit,
            hint: 'Unit',
            label: 'Unit',
          ),
          TextGroup(
            controller: urgency,
            hint: 'Urgent | Normal | As-slowly-as-possible',
            label: 'Urgency',
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
      ),
    );
  }

  // print action handler
  Future<void> _handlePrint() async {
    // final pw.Document pdf = await PrinterService.generatePDF(
    //   title: docTitle.text,

    //   format: PdfPageFormat.a4, // use A4 page dimensions and formatting
    // );

    try {
      int.parse(age.text);
    } catch (e) {
      age.text = '10';
    }

    final PrescriptionModel pm = PrescriptionModel(
      age: int.parse(age.text),
      dateAndTimeOfRequest: dateOfRequest.text,
      dateAndTimeOfSampleCollection: dateOfCollection.text,
      diagnosis: diagnosis.text,
      doctorSignature: signature.text,
      hospitalName: hospitalName.text,
      gender: gender.text,
      hospitalNumber: hospitalNumber.text,
      medications: <Medication>[
        const Medication(
            dosage: '3 tabs, 3 times daily', medication: 'Panadol Extra'),
        const Medication(
            dosage: '3 tabs, 3 times daily', medication: 'Cefazolin'),
        const Medication(
            dosage: '3 tabs, 3 times daily', medication: 'Flucloxacillin'),
      ],
      patientName: patientName.text,
      requestingDoctor: requestingDoctor.text,
      specimenType: specimenType.text,
      testType: testType.text,
      unit: unit.text,
      urgency: urgency.text,
    );

    pm.title = 'Laboratory Result for ${patientName.text}';
    pm.generatePage1();

    pm.title = 'Medication Prescription for ${patientName.text}';
    pm.generatePage2();

    final pw.Document pdf = pm.generateDocument();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      dynamicLayout: true,
      name: 'Laboratory Result for ${patientName.text}',
    );
  }
}

class TextGroup extends StatelessWidget {
  const TextGroup({
    Key key,
    @required this.controller,
    this.hint,
    this.label,
    this.lines = 1,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String hint;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextInput(
            text: controller,
            width: MediaQuery.of(context).size.width - 40.0,
            hint: hint ?? '',
            lines: lines,
          ),
        ],
      ),
    );
  }
}
