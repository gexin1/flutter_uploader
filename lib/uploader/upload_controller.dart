import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/upload_file_item.dart';

class UploadController extends ChangeNotifier {
  int maxCount;

  UploadController({this.maxCount = 9});
  List<UploadFileItem> _fileList = [];

  List<UploadFileItem> get data => _fileList;

  bool get isDone =>
      _fileList.every((el) => el.status == UploadStatusEnum.done);

  List<String> get urls => _fileList
      .map((el) => el.url)
      .where((element) => element != null)
      .map((element) => element!)
      .toList();

  int get count => _fileList.length;
  bool get isFull => count >= maxCount;

  changeStatus(int idx, UploadStatusEnum status) {
    _fileList[idx].status = status;
    notifyListeners();
  }

  changeUrl(int idx, String url) {
    _fileList[idx].url = url;
    notifyListeners();
  }

  addFileItem(UploadFileItem fileItem) {
    _fileList.add(fileItem);
    notifyListeners();
  }

  removeFileItem(int idx) {
    _fileList.removeAt(idx);
    notifyListeners();
  }

  addInitialUrls(List<String> urls) {
    var datas = urls.map((urlItem) => UploadFileItem(url: urlItem));
    _fileList.addAll(datas);
    notifyListeners();
  }

  @override
  void dispose() {
    _fileList = [];
    super.dispose();
  }
}
