import 'package:image_picker/image_picker.dart';

class FilesServices {
  Future<XFile?>? pickImage({bool fromCamera = false}) async {
    if (fromCamera) {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
      return xfile;
    } else {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
      return xfile;
    }
  }
}
