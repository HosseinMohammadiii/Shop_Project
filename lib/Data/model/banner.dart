class Banners {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? categoryId;
  Banners(this.id, this.collectionId, this.thumbnail, this.categoryId);
  factory Banners.fromJson(Map<String, dynamic> jsonObject) {
    return Banners(
      jsonObject['id'],
      jsonObject['collectionId'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['categoryId'],
    );
  }
}
