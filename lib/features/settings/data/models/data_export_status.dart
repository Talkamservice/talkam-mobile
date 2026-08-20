/// `POST /user/data-export` and `GET /user/data-export/latest` (v2) share
/// this shape. [downloadUrl]/[expiresAt] are only populated once ready.
class DataExportStatus {
  const DataExportStatus({
    required this.id,
    required this.status,
    this.expiresAt,
    this.downloadUrl,
  });

  final int id;
  final String status;
  final String? expiresAt;
  final String? downloadUrl;

  bool get isReady => status.toLowerCase() == 'ready' || downloadUrl != null;
  bool get isPending => status.toLowerCase() == 'pending';

  factory DataExportStatus.fromJson(Map<String, dynamic> json) =>
      DataExportStatus(
        id: json['id'],
        status: json['status'] ?? 'Pending',
        expiresAt: json['expires_at'],
        downloadUrl: json['download_url'],
      );
}
