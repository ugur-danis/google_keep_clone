import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart' as share_plus;

abstract class IShareUtils {
  Future<ShareResult> shareWithResult(ShareData shareData);
}

class ShareData {
  late final String text;
  late final String? subject;
  late final Rect? sharePositionOrigin;

  ShareData(this.text, {this.subject, this.sharePositionOrigin});
}

class ShareResult {
  final String raw;
  final ShareResultStatus status;

  ShareResult(this.raw, this.status);

  ShareResult.fromSharePlus(share_plus.ShareResult sharePlusResult)
      : raw = sharePlusResult.raw,
        status = sharePlusResult.status.fromSharePlus;
}

enum ShareResultStatus {
  /// The user has selected an action
  success,

  /// The user dismissed the share-sheet
  dismissed,

  /// The status can not be determined
  unavailable,
}

extension SharePlusShareResultStatusExtension on share_plus.ShareResultStatus {
  ShareResultStatus get fromSharePlus {
    switch (this) {
      case share_plus.ShareResultStatus.success:
        return ShareResultStatus.success;
      case share_plus.ShareResultStatus.dismissed:
        return ShareResultStatus.dismissed;
      default:
        return ShareResultStatus.unavailable;
    }
  }
}

class ShareUtils implements IShareUtils {
  @override
  Future<ShareResult> shareWithResult(ShareData shareData) async {
    try {
      if (shareData.text.isEmpty) {
        throw ('Empty messages cannot be sent');
      }
      final share_plus.ShareResult result =
          await share_plus.Share.shareWithResult(
        shareData.text,
        subject: shareData.subject,
        sharePositionOrigin: shareData.sharePositionOrigin,
      );

      return ShareResult.fromSharePlus(result);
    } catch (e) {
      return ShareResult(e.toString(), ShareResultStatus.dismissed);
    }
  }
}
