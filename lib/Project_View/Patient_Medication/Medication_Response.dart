class Medication_Response {
  List<CurrentPatientMedicationArray>? currentPatientMedicationArray;
  String? status;
  String? msg;

  Medication_Response({this.currentPatientMedicationArray, this.status, this.msg});

  Medication_Response.fromJson(Map<String, dynamic> json) {
    if (json['CurrentPatientMedicationArray'] != null) {
      currentPatientMedicationArray= <CurrentPatientMedicationArray>[];
      json['CurrentPatientMedicationArray'].forEach((v) {
        currentPatientMedicationArray
            !.add(new CurrentPatientMedicationArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentPatientMedicationArray != null) {
      data['CurrentPatientMedicationArray'] =
          this.currentPatientMedicationArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class CurrentPatientMedicationArray {
  String? detailsId;
  String? itemId;
  String? indentId;
  String? customMedication;
  String? frequencyName;
  String? frequency;
  String? dose;
  String? duration;
  String? durationText;
  String? instructions;
  String? unitName;
  String? type;
  String? startDate;
  String? endDate;
  String? encodedDate;
  String? encodedBy;
  String? isInfusion;
  String? referanceItemName;
  String? doseTypeName;
  String? foodRelationship;
  String? groupDate;
  String? routeName;
  String? formulationName;
  String? itemName;
  String? unitId;
  String? foodRelationshipId;
  String? frequencyId;
  String? mergedUniqueId;
  String? doseUnitNameMerge;

  CurrentPatientMedicationArray(
      {this.detailsId,
        this.itemId,
        this.indentId,
        this.customMedication,
        this.frequencyName,
        this.frequency,
        this.dose,
        this.duration,
        this.durationText,
        this.instructions,
        this.unitName,
        this.type,
        this.startDate,
        this.endDate,
        this.encodedDate,
        this.encodedBy,
        this.isInfusion,
        this.referanceItemName,
        this.doseTypeName,
        this.foodRelationship,
        this.groupDate,
        this.routeName,
        this.formulationName,
        this.itemName,
        this.unitId,
        this.foodRelationshipId,
        this.frequencyId,
        this.mergedUniqueId,
        this.doseUnitNameMerge});

  CurrentPatientMedicationArray.fromJson(Map<String, dynamic> json) {
    detailsId = json['DetailsId'];
    itemId = json['ItemId'];
    indentId = json['IndentId'];
    customMedication = json['CustomMedication'];
    frequencyName = json['FrequencyName'];
    frequency = json['Frequency'];
    dose = json['Dose'];
    duration = json['Duration'];
    durationText = json['DurationText'];
    instructions = json['Instructions'];
    unitName = json['UnitName'];
    type = json['Type'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    encodedDate = json['EncodedDate'];
    encodedBy = json['EncodedBy'];
    isInfusion = json['IsInfusion'];
    referanceItemName = json['ReferanceItemName'];
    doseTypeName = json['DoseTypeName'];
    foodRelationship = json['FoodRelationship'];
    groupDate = json['GroupDate'];
    routeName = json['RouteName'];
    formulationName = json['FormulationName'];
    itemName = json['ItemName'];
    unitId = json['UnitId'];
    foodRelationshipId = json['FoodRelationshipId'];
    frequencyId = json['FrequencyId'];
    mergedUniqueId = json['MergedUniqueId'];
    doseUnitNameMerge = json['DoseUnitNameMerge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DetailsId'] = this.detailsId;
    data['ItemId'] = this.itemId;
    data['IndentId'] = this.indentId;
    data['CustomMedication'] = this.customMedication;
    data['FrequencyName'] = this.frequencyName;
    data['Frequency'] = this.frequency;
    data['Dose'] = this.dose;
    data['Duration'] = this.duration;
    data['DurationText'] = this.durationText;
    data['Instructions'] = this.instructions;
    data['UnitName'] = this.unitName;
    data['Type'] = this.type;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['EncodedDate'] = this.encodedDate;
    data['EncodedBy'] = this.encodedBy;
    data['IsInfusion'] = this.isInfusion;
    data['ReferanceItemName'] = this.referanceItemName;
    data['DoseTypeName'] = this.doseTypeName;
    data['FoodRelationship'] = this.foodRelationship;
    data['GroupDate'] = this.groupDate;
    data['RouteName'] = this.routeName;
    data['FormulationName'] = this.formulationName;
    data['ItemName'] = this.itemName;
    data['UnitId'] = this.unitId;
    data['FoodRelationshipId'] = this.foodRelationshipId;
    data['FrequencyId'] = this.frequencyId;
    data['MergedUniqueId'] = this.mergedUniqueId;
    data['DoseUnitNameMerge'] = this.doseUnitNameMerge;
    return data;
  }
}