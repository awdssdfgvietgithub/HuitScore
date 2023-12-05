class ImageResModel {
  int? id;
  String? resString;

  ImageResModel({this.id, this.resString});
}

List<ImageResModel> mockImageResData = [
  ImageResModel(id: 1, resString: 'assets/premier_league.png'),
  ImageResModel(id: 36, resString: 'assets/laliga.png'),
  ImageResModel(id: 33, resString: 'assets/seria_a.png'),
  ImageResModel(id: 4, resString: 'assets/ligue_1.png'),
  ImageResModel(id: 42, resString: 'assets/bundesliga.png'),
];
