import 'package:image_picker/image_picker.dart';

enum UploadStatusEnum {
  init,
  uploading,
  done,
  failed,
}

class UploadFileItem {
  UploadFileItem({
    this.file,
    this.url,
    this.status,
  });
  XFile? file;
  String? url;
  UploadStatusEnum? status = UploadStatusEnum.init;
}
