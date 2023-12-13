class ImageResModel {
  int? id = -1;
  String? resString = 'assets/solid_white.png';
  int? seasonId = -1;

  ImageResModel({this.id, this.resString, this.seasonId});
}

List<ImageResModel> mockImageResData = [
  ImageResModel(
      id: 17, resString: 'assets/premier_league.png', seasonId: 52186),
  ImageResModel(id: 8, resString: 'assets/laliga.png', seasonId: 52376),
  ImageResModel(id: 23, resString: 'assets/seria_a.png', seasonId: 52760),
  ImageResModel(id: 34, resString: 'assets/ligue_1.png', seasonId: 52571),
  ImageResModel(id: 35, resString: 'assets/bundesliga.png', seasonId: 52608),
];
