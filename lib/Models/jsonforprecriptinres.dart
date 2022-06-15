class responsemoster {
  List<PrescriptionRoute>? prescriptionRoute;
  List<PrescriptionMedicationUnit>? prescriptionMedicationUnit;
  List<PrescriptionFrequency>? prescriptionFrequency;
  List<PrescriptionStatusMaster>? prescriptionStatusMaster;
  List<DurationUnit>? durationUnit;
  List<Route>? route;
  String?  status;
  String?  msg;

  responsemoster(
      {this.prescriptionRoute,
        this.prescriptionMedicationUnit,
        this.prescriptionFrequency,
        this.prescriptionStatusMaster,
        this.durationUnit,
        this.route,
        this.status,
        this.msg});

  responsemoster.fromJson(Map<String, dynamic> json) {
    if (json['PrescriptionRoute'] != null) {
      prescriptionRoute= <PrescriptionRoute>[];
      json['PrescriptionRoute'].forEach((v) {
        prescriptionRoute!.add(new PrescriptionRoute.fromJson(v));
      });
    }
    if (json['PrescriptionMedicationUnit'] != null) {
      prescriptionMedicationUnit= <PrescriptionMedicationUnit>[];
      json['PrescriptionMedicationUnit'].forEach((v) {
        prescriptionMedicationUnit
            !.add(new PrescriptionMedicationUnit.fromJson(v));
      });
    }
    if (json['PrescriptionFrequency'] != null) {
      prescriptionFrequency= <PrescriptionFrequency>[];
      json['PrescriptionFrequency'].forEach((v) {
        prescriptionFrequency!.add(new PrescriptionFrequency.fromJson(v));
      });
    }
    if (json['PrescriptionStatusMaster'] != null) {
      prescriptionStatusMaster= <PrescriptionStatusMaster>[];
      json['PrescriptionStatusMaster'].forEach((v) {
        prescriptionStatusMaster!.add(new PrescriptionStatusMaster.fromJson(v));
      });
    }
    if (json['DurationUnit'] != null) {
      durationUnit= <DurationUnit>[];
      json['DurationUnit'].forEach((v) {
        durationUnit!.add(new DurationUnit.fromJson(v));
      });
    }
    if (json['Route'] != null) {
      route= <Route>[];
      json['Route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prescriptionRoute != null) {
      data['PrescriptionRoute'] =
          this.prescriptionRoute!.map((v) => v.toJson()).toList();
    }
    if (this.prescriptionMedicationUnit != null) {
      data['PrescriptionMedicationUnit'] =
          this.prescriptionMedicationUnit!.map((v) => v.toJson()).toList();
    }
    if (this.prescriptionFrequency != null) {
      data['PrescriptionFrequency'] =
          this.prescriptionFrequency!.map((v) => v.toJson()).toList();
    }
    if (this.prescriptionStatusMaster != null) {
      data['PrescriptionStatusMaster'] =
          this.prescriptionStatusMaster!.map((v) => v.toJson()).toList();
    }
    if (this.durationUnit != null) {
      data['DurationUnit'] = this.durationUnit!.map((v) => v.toJson()).toList();
    }
    if (this.route != null) {
      data['Route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class PrescriptionRoute {
  int? iD;
  String?  routeName;

  PrescriptionRoute({this.iD, this.routeName});

  PrescriptionRoute.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    routeName = json['RouteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RouteName'] = this.routeName;
    return data;
  }
}

class PrescriptionMedicationUnit {
  int? iD;
  String?  unitName;
  String?  sequenceno;
  String?  isUnitCalculationRequired;

  PrescriptionMedicationUnit(
      {this.iD,
        this.unitName,
        this.sequenceno,
        this.isUnitCalculationRequired});

  PrescriptionMedicationUnit.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    unitName = json['UnitName'];
    sequenceno = json['sequenceno'];
    isUnitCalculationRequired = json['IsUnitCalculationRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['UnitName'] = this.unitName;
    data['sequenceno'] = this.sequenceno;
    data['IsUnitCalculationRequired'] = this.isUnitCalculationRequired;
    return data;
  }
}

class PrescriptionFrequency {
  int? id;
  String?  description;
  String?  frequency;

  PrescriptionFrequency({this.id, this.description, this.frequency});

  PrescriptionFrequency.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    frequency = json['Frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Frequency'] = this.frequency;
    return data;
  }
}

class PrescriptionStatusMaster {
  int? statusId;
  String?  status;

  PrescriptionStatusMaster({this.statusId, this.status});

  PrescriptionStatusMaster.fromJson(Map<String, dynamic> json) {
    statusId = json['StatusId'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusId'] = this.statusId;
    data['Status'] = this.status;
    return data;
  }
}

class DurationUnit {
  String?  durationUnitId;
  String?  durationUnit;

  DurationUnit({this.durationUnitId, this.durationUnit});

  DurationUnit.fromJson(Map<String, dynamic> json) {
    durationUnitId = json['DurationUnitId'];
    durationUnit = json['DurationUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DurationUnitId'] = this.durationUnitId;
    data['DurationUnit'] = this.durationUnit;
    return data;
  }
}

class Route {
  String?  routeId;
  String?  routeName;

  Route({this.routeId, this.routeName});

  Route.fromJson(Map<String, dynamic> json) {
    routeId = json['RouteId'];
    routeName = json['RouteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RouteId'] = this.routeId;
    data['RouteName'] = this.routeName;
    return data;
  }
}
