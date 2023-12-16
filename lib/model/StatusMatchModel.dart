class StatusMatchModel {
  int? code = -1; //0: notstarted, 100: finished, 7: inprogress (2nd-half)
  String? description = 'N/a';
  String? type = 'N/a';

  StatusMatchModel({this.code, this.description, this.type});
}
