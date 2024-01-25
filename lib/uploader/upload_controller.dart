import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/upload_file_item.dart';

class UploadController extends ChangeNotifier {
  int maxCount;

  UploadController({this.maxCount = 9});
  List<UploadFileItem> fileList = [];

  bool get isDone => fileList.every((el) => el.status == UploadStatusEnum.done);

  List<String> get urls => fileList
      .map((el) => el.url)
      .where((element) => element != null)
      .map((element) => element!)
      .toList();

  int get count => fileList.length;
  bool get isFull => count >= maxCount;

  changeStatus(int idx, UploadStatusEnum status) {
    fileList[idx].status = status;
    notifyListeners();
  }

  changeUrl(int idx, String url) {
    fileList[idx].url = url;
    notifyListeners();
  }

  addFileItem(UploadFileItem fileItem) {
    fileList.add(fileItem);
    notifyListeners();
  }

  removeFileItem(int idx) {
    fileList.removeAt(idx);
    notifyListeners();
  }

  addInitUrls(List<String> urls) {
    var datas = urls.map((urlItem) => UploadFileItem(url: urlItem));
    fileList.addAll(datas);
    notifyListeners();
  }

  @override
  void dispose() {
    fileList = [];
    super.dispose();
  }
}
