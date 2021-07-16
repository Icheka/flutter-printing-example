import 'package:plateaumed_printing_research/models/template_model.dart';

class PrescriptionModel extends TemplateModel {
  PrescriptionModel({
    this.age,
    this.dateAndTimeOfRequest,
    this.dateAndTimeOfSampleCollection,
    this.doctorSignature,
    this.gender,
    this.hospitalName,
    this.hospitalNumber,
    this.patientName,
    this.requestingDoctor,
    this.testType,
    this.unit,
    this.urgency,
    this.diagnosis,
    this.specimenType,
    this.medications,
  });

  final String hospitalName;
  final String testType;
  final String patientName;
  final int age;
  final String gender;
  final String hospitalNumber;
  final String requestingDoctor;
  final String unit;
  final String dateAndTimeOfRequest;
  final String dateAndTimeOfSampleCollection;
  final String urgency;
  final String doctorSignature;
  final String diagnosis;
  final String specimenType;
  final List<Medication> medications;

  void generatePage1() {
    final String template = '''
$hospitalName	Test type: $testType
$patientName 	$age 		$gender		$hospitalNumber
$requestingDoctor $unit
$dateAndTimeOfRequest
$dateAndTimeOfSampleCollection



Clinical Diagnosis:
$diagnosis


Specimen type: 
$specimenType


Tests: Timeline: $urgency


Doctor Signature:
$doctorSignature

''';
    pages.add(template);
  }

  void generatePage2() {
    final String template = '''
$hospitalName
$patientName 	   $age years 		$gender	  	$hospitalNumber
$dateAndTimeOfRequest

Medication 		         Dosage
${_getMedicationsAsString()}


Doctor Signature:
$doctorSignature

''';
    pages.add(template);
  }

  String _getMedicationsAsString() {
    return medications
        .map(
          (Medication m) {
            return '${m.medication} 		         ${m.dosage}';
          },
        )
        .toList()
        .join('\n');
  }
}

class Medication {
  const Medication({
    this.dosage,
    this.medication,
  });

  final String medication;
  final String dosage;
}
