import 'dart:ui';

class PromotionStatusModel {
  String? text = "";
  int? id = -1;
  Color? color = const Color(0xFFFFFFFF);

  PromotionStatusModel({this.text, this.id, this.color});
}

List<PromotionStatusModel> mockPromotionStatus = [
  PromotionStatusModel(
      text: 'Champions League', id: 804, color: const Color(0xFF3766CF)),
  PromotionStatusModel(
      text: 'UEFA Europa League', id: 808, color: const Color(0xFFFF6900)),
  PromotionStatusModel(
      text: 'Relegation', id: 3, color: const Color(0xFFE24E4E)),
  PromotionStatusModel(
      text: 'UEFA Conference League Qualification',
      id: 1349,
      color: const Color(0xFF16B427)),
  PromotionStatusModel(
      text: 'Champions League Qualification',
      id: 24,
      color: const Color(0xFFEF7515)),
  PromotionStatusModel(
      text: 'Relegation Playoffs', id: 45, color: const Color(0xFFEFB405)),
];
