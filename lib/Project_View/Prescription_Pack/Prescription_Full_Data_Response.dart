class Prescription_Full_Data_Response {

  List<CashesheetSummary>? cashesheetSummary;
  String? status;


  Prescription_Full_Data_Response({this.cashesheetSummary, this.status});

  Prescription_Full_Data_Response.fromJson(Map<String, dynamic> json) {
  if ( (json['CashesheetSummary'] != null)||(json['CashesheetSummary'] != "")) {
  cashesheetSummary= <CashesheetSummary>[];
  json['CashesheetSummary'].forEach((v) {
  cashesheetSummary!.add(new CashesheetSummary.fromJson(v));
  });
  }
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.cashesheetSummary != null) {
  data['CashesheetSummary'] =
  this.cashesheetSummary!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  return data;
  }
  }

  class CashesheetSummary {
  String? status;
  String? allergyStatus;
  String? chiefComplainStatus;
  String? diagnosisStatus;
  String? progressNotesStatus;
  String? patientReferralHistoryStatus;
  String? eMRPatientOrdersStatus;
  String? patientMedicationStatus;
  String? vitalStatus;
  String? templateStatus;
  String? fieldStatus;
  String? groupDate;
  List<Allergy>? allergy;
  List<ChiefComplain>? chiefComplain;
  List<Diagnosis>? diagnosis;
  List<ProgressNotes>? progressNotes;
  List<PatientReferralHistory>? patientReferralHistory;
  List<EMRPatientOrders>? eMRPatientOrders;
  List<PatientMedication>? patientMedication;
  List<Vital>? vital;
  List<Template>? template;
  String? field;

  CashesheetSummary(
  {this.status,
  this.allergyStatus,
  this.chiefComplainStatus,
  this.diagnosisStatus,
  this.progressNotesStatus,
  this.patientReferralHistoryStatus,
  this.eMRPatientOrdersStatus,
  this.patientMedicationStatus,
  this.vitalStatus,
  this.templateStatus,
  this.fieldStatus,
  this.groupDate,
  this.allergy,
  this.chiefComplain,
  this.diagnosis,
  this.progressNotes,
  this.patientReferralHistory,
  this.eMRPatientOrders,
  this.patientMedication,
  this.vital,
  this.template,
  this.field});

  CashesheetSummary.fromJson(Map<String, dynamic> json) {
  status = json['Status'];
  allergyStatus = json['AllergyStatus'];
  chiefComplainStatus = json['ChiefComplainStatus'];
  diagnosisStatus = json['DiagnosisStatus'];
  progressNotesStatus = json['ProgressNotesStatus'];
  patientReferralHistoryStatus = json['PatientReferralHistoryStatus'];
  eMRPatientOrdersStatus = json['EMRPatientOrdersStatus'];
  patientMedicationStatus = json['PatientMedicationStatus'];
  vitalStatus = json['VitalStatus'];
  templateStatus = json['TemplateStatus'];
  fieldStatus = json['FieldStatus'];
  groupDate = json['GroupDate'];
  if ((json['Allergy'] != null)||(json['Allergy'] != "")) {
  allergy= <Allergy>[];
  json['Allergy'].forEach((v) {
  allergy!.add(new Allergy.fromJson(v));
  });
  }
  if( (json['ChiefComplain'] != null)||(json['ChiefComplain'] != "") ){
  chiefComplain= <ChiefComplain>[];
  json['ChiefComplain'].forEach((v) {
  chiefComplain!.add(new ChiefComplain.fromJson(v));
  });
  }
  if ((json['Diagnosis'] != null) ||((json['Diagnosis'] != ""))){
  diagnosis= <Diagnosis>[];
  json['Diagnosis'].forEach((v) {
  diagnosis!.add(new Diagnosis.fromJson(v));
  });
  }
  if ((json['ProgressNotes'] != null)||(json['ProgressNotes'] != "")) {
  progressNotes= <ProgressNotes>[];
  json['ProgressNotes'].forEach((v) {
  progressNotes!.add(new ProgressNotes.fromJson(v));
  });
  }
  if ((json['PatientReferralHistory'] != null)||(json['PatientReferralHistory'] != "")) {
  patientReferralHistory= <PatientReferralHistory>[];
  json['PatientReferralHistory'].forEach((v) {
  patientReferralHistory!.add(new PatientReferralHistory.fromJson(v));
  });
  }
  if ((json['EMRPatientOrders'] != null)||(json['EMRPatientOrders'] != "")) {
  eMRPatientOrders= <EMRPatientOrders>[];
  json['EMRPatientOrders'].forEach((v) {
  eMRPatientOrders!.add(new EMRPatientOrders.fromJson(v));
  });
  }
  if ((json['PatientMedication'] != null)||(json['PatientMedication'] != "") ){
  patientMedication= <PatientMedication>[];
  json['PatientMedication'].forEach((v) {
  patientMedication!.add(new PatientMedication.fromJson(v));
  });
  }
  if ((json['Vital'] != null)||(json['Vital'] != "")) {
  vital= <Vital>[];
  json['Vital'].forEach((v) {
  vital!.add(new Vital.fromJson(v));
  });
  }
  if ((json['Template'] != null)||(json['Template'] != "") ){
  template= <Template>[];
  json['Template'].forEach((v) {
  template!.add(new Template.fromJson(v));
  });
  }
  field = json['Field'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Status'] = this.status;
  data['AllergyStatus'] = this.allergyStatus;
  data['ChiefComplainStatus'] = this.chiefComplainStatus;
  data['DiagnosisStatus'] = this.diagnosisStatus;
  data['ProgressNotesStatus'] = this.progressNotesStatus;
  data['PatientReferralHistoryStatus'] = this.patientReferralHistoryStatus;
  data['EMRPatientOrdersStatus'] = this.eMRPatientOrdersStatus;
  data['PatientMedicationStatus'] = this.patientMedicationStatus;
  data['VitalStatus'] = this.vitalStatus;
  data['TemplateStatus'] = this.templateStatus;
  data['FieldStatus'] = this.fieldStatus;
  data['GroupDate'] = this.groupDate;
  if (this.allergy != null) {
  data['Allergy'] = this.allergy!.map((v) => v.toJson()).toList();
  }
  if (this.chiefComplain != null) {
  data['ChiefComplain'] =
  this.chiefComplain!.map((v) => v.toJson()).toList();
  }
  if (this.diagnosis != null) {
  data['Diagnosis'] = this.diagnosis!.map((v) => v.toJson()).toList();
  }
  if (this.progressNotes != null) {
  data['ProgressNotes'] =
  this.progressNotes!.map((v) => v.toJson()).toList();
  }
  if (this.patientReferralHistory != null) {
  data['PatientReferralHistory'] =
  this.patientReferralHistory!.map((v) => v.toJson()).toList();
  }
  if (this.eMRPatientOrders != null) {
  data['EMRPatientOrders'] =
  this.eMRPatientOrders!.map((v) => v.toJson()).toList();
  }
  if (this.patientMedication != null) {
  data['PatientMedication'] =
  this.patientMedication!.map((v) => v.toJson()).toList();
  }
  if (this.vital != null) {
  data['Vital'] = this.vital!.map((v) => v.toJson()).toList();
  }
  if (this.template != null) {
  data['Template'] = this.template!.map((v) => v.toJson()).toList();
  }
  data['Field'] = this.field;
  return data;
  }
  }

  class Allergy {
  String? allergyName;
  String? allergyDate;
  String? remarks;
  String? status;

  Allergy({this.allergyName, this.allergyDate, this.remarks, this.status});

  Allergy.fromJson(Map<String, dynamic> json) {
  allergyName = json['AllergyName'];
  allergyDate = json['AllergyDate'];
  remarks = json['Remarks'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['AllergyName'] = this.allergyName;
  data['AllergyDate'] = this.allergyDate;
  data['Remarks'] = this.remarks;
  data['Status'] = this.status;
  return data;
  }
  }

  class ChiefComplain {
  String? problemDescription;
  String? location;
  String? duration;
  String? encodedDate;
  String? status;

  ChiefComplain(
  {this.problemDescription,
  this.location,
  this.duration,
  this.encodedDate,
  this.status});

  ChiefComplain.fromJson(Map<String, dynamic> json) {
  problemDescription = json['ProblemDescription'];
  location = json['Location'];
  duration = json['Duration'];
  encodedDate = json['EncodedDate'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ProblemDescription'] = this.problemDescription;
  data['Location'] = this.location;
  data['Duration'] = this.duration;
  data['EncodedDate'] = this.encodedDate;
  data['Status'] = this.status;
  return data;
  }
  }

  class Diagnosis {
  String? iCDCode;
  String? iCDDescription;
  String? primaryDiagnosis;
  String? remarks;
  String? onsetDate;
  String? encodedDate;
  String? status;

  Diagnosis(
  {this.iCDCode,
  this.iCDDescription,
  this.primaryDiagnosis,
  this.remarks,
  this.onsetDate,
  this.encodedDate,
  this.status});

  Diagnosis.fromJson(Map<String, dynamic> json) {
  iCDCode = json['ICDCode'];
  iCDDescription = json['ICDDescription'];
  primaryDiagnosis = json['PrimaryDiagnosis'];
  remarks = json['Remarks'];
  onsetDate = json['OnsetDate'];
  encodedDate = json['EncodedDate'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ICDCode'] = this.iCDCode;
  data['ICDDescription'] = this.iCDDescription;
  data['PrimaryDiagnosis'] = this.primaryDiagnosis;
  data['Remarks'] = this.remarks;
  data['OnsetDate'] = this.onsetDate;
  data['EncodedDate'] = this.encodedDate;
  data['Status'] = this.status;
  return data;
  }
  }

  class ProgressNotes {
  String? doctorName;
  String? progressNote;
  String? encodedDate;
  String? enteredby;
  String? status;

  ProgressNotes(
  {this.doctorName,
  this.progressNote,
  this.encodedDate,
  this.enteredby,
  this.status});

  ProgressNotes.fromJson(Map<String, dynamic> json) {
  doctorName = json['DoctorName'];
  progressNote = json['ProgressNote'];
  encodedDate = json['EncodedDate'];
  enteredby = json['Enteredby'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['DoctorName'] = this.doctorName;
  data['ProgressNote'] = this.progressNote;
  data['EncodedDate'] = this.encodedDate;
  data['Enteredby'] = this.enteredby;
  data['Status'] = this.status;
  return data;
  }
  }

  class PatientReferralHistory {
  String? referralDoctorId;
  String? referralDoctor;
  String? referralDate;
  String? reasonforReferral;
  String? referralReply;
  String? toDoctorId;
  String? toDoctorName;
  String? referralReplyBy;
  String? referralReplyReplyDate;
  String? status;

  PatientReferralHistory(
  {this.referralDoctorId,
  this.referralDoctor,
  this.referralDate,
  this.reasonforReferral,
  this.referralReply,
  this.toDoctorId,
  this.toDoctorName,
  this.referralReplyBy,
  this.referralReplyReplyDate,
  this.status});

  PatientReferralHistory.fromJson(Map<String, dynamic> json) {
  referralDoctorId = json['ReferralDoctorId'];
  referralDoctor = json['ReferralDoctor'];
  referralDate = json['ReferralDate'];
  reasonforReferral = json['ReasonforReferral'];
  referralReply = json['ReferralReply'];
  toDoctorId = json['ToDoctorId'];
  toDoctorName = json['ToDoctorName'];
  referralReplyBy = json['ReferralReplyBy'];
  referralReplyReplyDate = json['ReferralReplyReplyDate'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ReferralDoctorId'] = this.referralDoctorId;
  data['ReferralDoctor'] = this.referralDoctor;
  data['ReferralDate'] = this.referralDate;
  data['ReasonforReferral'] = this.reasonforReferral;
  data['ReferralReply'] = this.referralReply;
  data['ToDoctorId'] = this.toDoctorId;
  data['ToDoctorName'] = this.toDoctorName;
  data['ReferralReplyBy'] = this.referralReplyBy;
  data['ReferralReplyReplyDate'] = this.referralReplyReplyDate;
  data['Status'] = this.status;
  return data;
  }
  }

  class EMRPatientOrders {
  String? subDepartment;
  String? status;
  List<SubEMRPatientOrders>? subEMRPatientOrders;

  EMRPatientOrders({this.subDepartment, this.status, this.subEMRPatientOrders});

  EMRPatientOrders.fromJson(Map<String, dynamic> json) {
  subDepartment = json['SubDepartment'];
  status = json['Status'];
  if (json['SubEMRPatientOrders'] != null) {
  subEMRPatientOrders= <SubEMRPatientOrders>[];
  json['SubEMRPatientOrders'].forEach((v) {
  subEMRPatientOrders!.add(new SubEMRPatientOrders.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['SubDepartment'] = this.subDepartment;
  data['Status'] = this.status;
  if (this.subEMRPatientOrders != null) {
  data['SubEMRPatientOrders'] =
  this.subEMRPatientOrders!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class SubEMRPatientOrders {
  String? orders;
  String? date;
  String? cPTCode;
  String? subDepartment;
  String? doctorName;
  String? labStatus;
  String? status;
  String? enteredby;

  SubEMRPatientOrders(
  {this.orders,
  this.date,
  this.cPTCode,
  this.subDepartment,
  this.doctorName,
  this.labStatus,
  this.status,
  this.enteredby});

  SubEMRPatientOrders.fromJson(Map<String, dynamic> json) {
  orders = json['Orders'];
  date = json['Date'];
  cPTCode = json['CPTCode'];
  subDepartment = json['SubDepartment'];
  doctorName = json['DoctorName'];
  labStatus = json['LabStatus'];
  status = json['Status'];
  enteredby = json['Enteredby'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Orders'] = this.orders;
  data['Date'] = this.date;
  data['CPTCode'] = this.cPTCode;
  data['SubDepartment'] = this.subDepartment;
  data['DoctorName'] = this.doctorName;
  data['LabStatus'] = this.labStatus;
  data['Status'] = this.status;
  data['Enteredby'] = this.enteredby;
  return data;
  }
  }

  class PatientMedication {
  String? itemName;
  String? indentDate;
  String? prescriptionDetails;
  String? indendBy;
  String? enteredby;
  String? instructions;
  String? qty;
  String? status;

  PatientMedication(
  {this.itemName,
  this.indentDate,
  this.prescriptionDetails,
  this.indendBy,
  this.enteredby,
  this.instructions,
  this.qty,
  this.status});

  PatientMedication.fromJson(Map<String, dynamic> json) {
  itemName = json['ItemName'];
  indentDate = json['IndentDate'];
  prescriptionDetails = json['PrescriptionDetails'];
  indendBy = json['IndendBy'];
  enteredby = json['Enteredby'];
  instructions = json['Instructions'];
  qty = json['Qty'];
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ItemName'] = this.itemName;
  data['IndentDate'] = this.indentDate;
  data['PrescriptionDetails'] = this.prescriptionDetails;
  data['IndendBy'] = this.indendBy;
  data['Enteredby'] = this.enteredby;
  data['Instructions'] = this.instructions;
  data['Qty'] = this.qty;
  data['Status'] = this.status;
  return data;
  }
  }

  class Vital {
  String? vitalDate;
  String? height;
  String? weight;
  String? respiration;
  String? pulse;
  String? temperature;
  String? bMI;
  String? bSA;
  String? bPSystolic;
  String? bPDiastolic;
  String? painScore;
  String? status;
  String? headCircumference;
  String? sPO2;
  String? mAC;
  String? enteredby;
  String? gRBS;
  String? unstandable;
  String? critical;

  Vital(
  {this.vitalDate,
  this.height,
  this.weight,
  this.respiration,
  this.pulse,
  this.temperature,
  this.bMI,
  this.bSA,
  this.bPSystolic,
  this.bPDiastolic,
  this.painScore,
  this.status,
  this.headCircumference,
  this.sPO2,
  this.mAC,
  this.enteredby,
  this.gRBS,
  this.unstandable,
  this.critical});

  Vital.fromJson(Map<String, dynamic> json) {
  vitalDate = json['VitalDate'];
  height = json['Height'];
  weight = json['Weight'];
  respiration = json['Respiration'];
  pulse = json['Pulse'];
  temperature = json['Temperature'];
  bMI = json['BMI'];
  bSA = json['BSA'];
  bPSystolic = json['BPSystolic'];
  bPDiastolic = json['BPDiastolic'];
  painScore = json['PainScore'];
  status = json['Status'];
  headCircumference = json['HeadCircumference'];
  sPO2 = json['SPO2'];
  mAC = json['MAC'];
  enteredby = json['Enteredby'];
  gRBS = json['GRBS'];
  unstandable = json['Unstandable'];
  critical = json['Critical'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['VitalDate'] = this.vitalDate;
  data['Height'] = this.height;
  data['Weight'] = this.weight;
  data['Respiration'] = this.respiration;
  data['Pulse'] = this.pulse;
  data['Temperature'] = this.temperature;
  data['BMI'] = this.bMI;
  data['BSA'] = this.bSA;
  data['BPSystolic'] = this.bPSystolic;
  data['BPDiastolic'] = this.bPDiastolic;
  data['PainScore'] = this.painScore;
  data['Status'] = this.status;
  data['HeadCircumference'] = this.headCircumference;
  data['SPO2'] = this.sPO2;
  data['MAC'] = this.mAC;
  data['Enteredby'] = this.enteredby;
  data['GRBS'] = this.gRBS;
  data['Unstandable'] = this.unstandable;
  data['Critical'] = this.critical;
  return data;
  }
  }

  class Template {
  String? templateId;
  String? templateName;
  List<Section>? section;
  String? status;

  Template({this.templateId, this.templateName, this.section, this.status});

  Template.fromJson(Map<String, dynamic> json) {
  templateId = json['TemplateId'];
  templateName = json['TemplateName'];
  if ((json['Section'] != null)||(json['Section'] != "") ){
  section= <Section>[];
  json['Section'].forEach((v) {
  section!.add(new Section.fromJson(v));
  });
  }
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['TemplateId'] = this.templateId;
  data['TemplateName'] = this.templateName;
  if ( (this.section != null)||(this.section != "") ){
  data['Section'] = this.section!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  return data;
  }
  }

  class Section {
  String? sectionId;
  String? sectionName;
  List<FieldData>? field;
  String? status;

  Section({this.sectionId, this.sectionName, this.field, this.status});

  Section.fromJson(Map<String, dynamic> json) {
  sectionId = json['SectionId'];
  sectionName = json['SectionName'];
  if ((json['Field'] != null) ||(json['Field'] != "")){
  field= <FieldData>[];
  json['Field'].forEach((v) {
  field!.add(new FieldData.fromJson(v));
  });
  }
  status = json['Status'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['SectionId'] = this.sectionId;
  data['SectionName'] = this.sectionName;
  if (this.field != null) {
  data['Field'] = this.field!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  return data;
  }
  }

  class FieldData {
  String? fieldId;
  String? fieldName;
  String? value;
  String? textValue;
  String? mainText;
  String? enterBy;
  String? groupDate;

  FieldData(
  {this.fieldId,
  this.fieldName,
  this.value,
  this.textValue,
  this.mainText,
  this.enterBy,
  this.groupDate});

  FieldData.fromJson(Map<String, dynamic> json) {
  fieldId = json['FieldId'];
  fieldName = json['FieldName'];
  value = json['Value'];
  textValue = json['TextValue'];
  mainText = json['MainText'];
  enterBy = json['EnterBy'];
  groupDate = json['GroupDate'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['FieldId'] = this.fieldId;
  data['FieldName'] = this.fieldName;
  data['Value'] = this.value;
  data['TextValue'] = this.textValue;
  data['MainText'] = this.mainText;
  data['EnterBy'] = this.enterBy;
  data['GroupDate'] = this.groupDate;
  return data;
  }
  }