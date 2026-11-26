import 'package:image_picker/image_picker.dart';
import '../constant/api_constant.dart';
import '../models/article_model.dart';
import 'api_client.dart';

class ArticleService {
  final _api = ApiClient();

  // READ (list)
  Future<List<ArticleModel>> getAll() async {
    final body = await _api.request('GET', ApiConstant.articles);
    final list = body['data'] as List;
    return list.map((e) => ArticleModel.fromJson(e)).toList();
  }

  // CREATE (boleh dengan foto)
  Future<ArticleModel> create({
    required String title,
    required String content,
    XFile? image,
  }) async {
    final body = await _api.multipart(
      ApiConstant.articles,
      fields: {'title': title, 'content': content},
      file: image,
    );
    return ArticleModel.fromJson(body['data']);
  }

  // UPDATE (boleh ganti foto / hapus foto)
  Future<ArticleModel> update(
    int id, {
    required String title,
    required String content,
    XFile? image,
    bool removeImage = false,
  }) async {
    final body = await _api.multipart(
      '${ApiConstant.articles}/$id',
      fields: {
        '_method': 'PUT', // method spoofing, lihat bagian 1.9
        'title': title,
        'content': content,
        if (removeImage) 'remove_image': '1',
      },
      file: image,
    );
    return ArticleModel.fromJson(body['data']);
  }

  // DELETE
  Future<void> delete(int id) async {
    await _api.request('DELETE', '${ApiConstant.articles}/$id');
  }
}