class StatusMatchModel {
  int? code; //0: notstarted, 100: finished, 7: inprogress (2nd-half)
  String? description;
  String? type;

  StatusMatchModel({this.code, this.description, this.type});
}
