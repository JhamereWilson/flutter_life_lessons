class ProfilePhotoReference {
  ProfilePhotoReference(this.downloadUrl);
  final String downloadUrl;

  factory ProfilePhotoReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String downloadUrl = data['downloadUrl'];
    if (downloadUrl == null) {
      return null;
    }
    return ProfilePhotoReference(downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}