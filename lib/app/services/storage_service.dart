import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'supabase_service.dart';
import '../utils/app_logger.dart';
import '../constants/app_constants.dart';

/// Storage service for handling file uploads and downloads
class StorageService extends GetxService {
  late final SupabaseClient _supabase;

  @override
  void onInit() {
    super.onInit();
    _supabase = SupabaseService.client;
  }

  /// Upload file to Supabase storage
  Future<String?> uploadFile({
    required String bucket,
    required String fileName,
    required File file,
    String? folder,
    Map<String, String>? metadata,
  }) async {
    try {
      final String filePath = folder != null ? '$folder/$fileName' : fileName;

      final response = await _supabase.storage.from(bucket).upload(
            filePath,
            file,
            fileOptions: FileOptions(
              cacheControl: '3600',
              upsert: false,
              metadata: metadata,
            ),
          );

      if (response.isNotEmpty) {
        final String publicUrl =
            _supabase.storage.from(bucket).getPublicUrl(filePath);
        AppLogger.success('File uploaded successfully: $filePath');
        return publicUrl;
      } else {
        AppLogger.error('Failed to upload file: Empty response');
        return null;
      }
    } catch (e) {
      AppLogger.error('Error uploading file: $e');
      return null;
    }
  }

  /// Upload file from bytes
  Future<String?> uploadBytes({
    required String bucket,
    required String fileName,
    required Uint8List bytes,
    String? folder,
    String? mimeType,
    Map<String, String>? metadata,
  }) async {
    try {
      final String filePath = folder != null ? '$folder/$fileName' : fileName;

      final response = await _supabase.storage.from(bucket).uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              contentType: mimeType,
              cacheControl: '3600',
              upsert: false,
              metadata: metadata,
            ),
          );

      if (response.isNotEmpty) {
        final String publicUrl =
            _supabase.storage.from(bucket).getPublicUrl(filePath);
        AppLogger.success('Bytes uploaded successfully: $filePath');
        return publicUrl;
      } else {
        AppLogger.error('Failed to upload bytes: Empty response');
        return null;
      }
    } catch (e) {
      AppLogger.error('Error uploading bytes: $e');
      return null;
    }
  }

  /// Upload profile image
  Future<String?> uploadProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    final String fileName =
        '${userId}_${DateTime.now().millisecondsSinceEpoch}.${path.extension(imageFile.path)}';

    return uploadFile(
      bucket: AppConstants.profileBucket,
      fileName: fileName,
      file: imageFile,
      folder: 'avatars',
      metadata: {
        'user_id': userId,
        'type': 'profile_image',
      },
    );
  }

  /// Upload post images
  Future<List<String>> uploadPostImages({
    required String userId,
    required List<File> imageFiles,
  }) async {
    final List<String> uploadedUrls = [];

    for (int i = 0; i < imageFiles.length; i++) {
      final File imageFile = imageFiles[i];
      final String fileName =
          '${userId}_${DateTime.now().millisecondsSinceEpoch}_$i.${path.extension(imageFile.path)}';

      final String? url = await uploadFile(
        bucket: AppConstants.postsBucket,
        fileName: fileName,
        file: imageFile,
        folder: 'images',
        metadata: {
          'user_id': userId,
          'type': 'post_image',
        },
      );

      if (url != null) {
        uploadedUrls.add(url);
      }
    }

    AppLogger.success('Uploaded ${uploadedUrls.length} post images');
    return uploadedUrls;
  }

  /// Upload post video
  Future<String?> uploadPostVideo({
    required String userId,
    required File videoFile,
  }) async {
    final String fileName =
        '${userId}_${DateTime.now().millisecondsSinceEpoch}.${path.extension(videoFile.path)}';

    return uploadFile(
      bucket: AppConstants.postsBucket,
      fileName: fileName,
      file: videoFile,
      folder: 'videos',
      metadata: {
        'user_id': userId,
        'type': 'post_video',
      },
    );
  }

  /// Upload story image
  Future<String?> uploadStoryImage({
    required String userId,
    required File imageFile,
  }) async {
    final String fileName =
        '${userId}_${DateTime.now().millisecondsSinceEpoch}.${path.extension(imageFile.path)}';

    return uploadFile(
      bucket: AppConstants.storiesBucket,
      fileName: fileName,
      file: imageFile,
      folder: 'images',
      metadata: {
        'user_id': userId,
        'type': 'story_image',
        'expires_at':
            DateTime.now().add(AppConstants.storyDuration).toIso8601String(),
      },
    );
  }

  /// Upload story video
  Future<String?> uploadStoryVideo({
    required String userId,
    required File videoFile,
  }) async {
    final String fileName =
        '${userId}_${DateTime.now().millisecondsSinceEpoch}.${path.extension(videoFile.path)}';

    return uploadFile(
      bucket: AppConstants.storiesBucket,
      fileName: fileName,
      file: videoFile,
      folder: 'videos',
      metadata: {
        'user_id': userId,
        'type': 'story_video',
        'expires_at':
            DateTime.now().add(AppConstants.storyDuration).toIso8601String(),
      },
    );
  }

  /// Upload message attachment
  Future<String?> uploadMessageAttachment({
    required String userId,
    required File file,
    required String messageId,
  }) async {
    final String fileName =
        '${messageId}_${DateTime.now().millisecondsSinceEpoch}.${path.extension(file.path)}';

    return uploadFile(
      bucket: AppConstants.messagesBucket,
      fileName: fileName,
      file: file,
      folder: 'attachments',
      metadata: {
        'user_id': userId,
        'message_id': messageId,
        'type': 'message_attachment',
      },
    );
  }

  /// Delete file from storage
  Future<bool> deleteFile({
    required String bucket,
    required String filePath,
  }) async {
    try {
      await _supabase.storage.from(bucket).remove([filePath]);
      AppLogger.success('File deleted successfully: $filePath');
      return true;
    } catch (e) {
      AppLogger.error('Error deleting file: $e');
      return false;
    }
  }

  /// Delete multiple files from storage
  Future<bool> deleteFiles({
    required String bucket,
    required List<String> filePaths,
  }) async {
    try {
      await _supabase.storage.from(bucket).remove(filePaths);
      AppLogger.success('${filePaths.length} files deleted successfully');
      return true;
    } catch (e) {
      AppLogger.error('Error deleting files: $e');
      return false;
    }
  }

  /// Get file metadata
  Future<Map<String, dynamic>?> getFileMetadata({
    required String bucket,
    required String filePath,
  }) async {
    try {
      final response = await _supabase.storage.from(bucket).info(filePath);
      AppLogger.info('File metadata retrieved: $filePath');
      return {
        'name': response.name,
        'size': response.size,
        'created_at': response.createdAt,
        'updated_at': response.updatedAt,
        'last_accessed_at': response.lastAccessedAt,
        'metadata': response.metadata,
      };
    } catch (e) {
      AppLogger.error('Error getting file metadata: $e');
      return null;
    }
  }

  /// Get public URL for a file
  String getPublicUrl({
    required String bucket,
    required String filePath,
    Map<String, String>? transform,
  }) {
    try {
      if (transform != null) {
        return _supabase.storage.from(bucket).getPublicUrl(
              filePath,
              transform: TransformOptions(
                width: int.tryParse(transform['width'] ?? ''),
                height: int.tryParse(transform['height'] ?? ''),
                resize: ResizeMode.values.firstWhere(
                  (mode) => mode.name == transform['resize'],
                  orElse: () => ResizeMode.cover,
                ),
                quality: int.tryParse(transform['quality'] ?? '80'),
              ),
            );
      } else {
        return _supabase.storage.from(bucket).getPublicUrl(filePath);
      }
    } catch (e) {
      AppLogger.error('Error getting public URL: $e');
      return '';
    }
  }

  /// Create signed URL for private files
  Future<String?> createSignedUrl({
    required String bucket,
    required String filePath,
    int expiresInSeconds = 3600,
    Map<String, String>? transform,
  }) async {
    try {
      final response = await _supabase.storage.from(bucket).createSignedUrl(
            filePath,
            expiresInSeconds,
            transform: transform != null
                ? TransformOptions(
                    width: int.tryParse(transform['width'] ?? ''),
                    height: int.tryParse(transform['height'] ?? ''),
                    resize: ResizeMode.values.firstWhere(
                      (mode) => mode.name == transform['resize'],
                      orElse: () => ResizeMode.cover,
                    ),
                    quality: int.tryParse(transform['quality'] ?? '80'),
                  )
                : null,
          );

      AppLogger.info('Signed URL created for: $filePath');
      return response;
    } catch (e) {
      AppLogger.error('Error creating signed URL: $e');
      return null;
    }
  }

  /// List files in a bucket
  Future<List<FileObject>?> listFiles({
    required String bucket,
    String? folder,
    int limit = 100,
    int offset = 0,
  }) async {
    try {
      final response = await _supabase.storage.from(bucket).list(
            path: folder,
            searchOptions: SearchOptions(
              limit: limit,
              offset: offset,
              sortBy: SortBy(
                column: 'created_at',
                order: 'desc',
              ),
            ),
          );

      AppLogger.info('Listed ${response.length} files from $bucket');
      return response;
    } catch (e) {
      AppLogger.error('Error listing files: $e');
      return null;
    }
  }

  /// Check if file exists
  Future<bool> fileExists({
    required String bucket,
    required String filePath,
  }) async {
    try {
      await _supabase.storage.from(bucket).info(filePath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  Future<int?> getFileSize({
    required String bucket,
    required String filePath,
  }) async {
    try {
      final metadata =
          await getFileMetadata(bucket: bucket, filePath: filePath);
      return metadata?['size'] as int?;
    } catch (e) {
      AppLogger.error('Error getting file size: $e');
      return null;
    }
  }

  /// Generate optimized image URL
  String getOptimizedImageUrl({
    required String bucket,
    required String filePath,
    int? width,
    int? height,
    int quality = 80,
    ResizeMode resize = ResizeMode.cover,
  }) {
    return getPublicUrl(
      bucket: bucket,
      filePath: filePath,
      transform: {
        if (width != null) 'width': width.toString(),
        if (height != null) 'height': height.toString(),
        'quality': quality.toString(),
        'resize': resize.name,
      },
    );
  }

  /// Clean up expired story files
  Future<void> cleanupExpiredStories() async {
    try {
      final files = await listFiles(bucket: AppConstants.storiesBucket);
      if (files == null) return;

      final expiredFiles = <String>[];
      final now = DateTime.now();

      for (final file in files) {
        final metadata = await getFileMetadata(
          bucket: AppConstants.storiesBucket,
          filePath: file.name,
        );

        if (metadata != null && metadata['expires_at'] != null) {
          final expiresAt = DateTime.parse(metadata['expires_at']);
          if (now.isAfter(expiresAt)) {
            expiredFiles.add(file.name);
          }
        }
      }

      if (expiredFiles.isNotEmpty) {
        await deleteFiles(
          bucket: AppConstants.storiesBucket,
          filePaths: expiredFiles,
        );
        AppLogger.success(
            'Cleaned up ${expiredFiles.length} expired story files');
      }
    } catch (e) {
      AppLogger.error('Error cleaning up expired stories: $e');
    }
  }
}
