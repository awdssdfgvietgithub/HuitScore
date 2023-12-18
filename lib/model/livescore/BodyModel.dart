import 'package:huit_score/model/livescore/BodyDataModel.dart';
import 'package:huit_score/model/livescore/bodytype/EditorBlockTypeModel.dart';
import 'package:huit_score/model/livescore/bodytype/ImageTypeModel.dart';
import 'package:huit_score/model/livescore/bodytype/LinkTypeModel.dart';

class   BodyModel {
  String? id;
  EditorBlockTypeModel? editorBlockType;
  ImageTypeModel? imageType;
  LinkTypeModel? linkType;
  String? type;

  BodyModel(
      {this.id,
      this.editorBlockType,
      this.imageType,
      this.linkType,
      this.type});
}
