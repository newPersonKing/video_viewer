import 'package:flutter/material.dart';

import 'package:video_viewer/data/repositories/video.dart';
import 'package:video_viewer/domain/entities/subtitle.dart';
import 'package:video_viewer/domain/entities/video_source.dart';

import 'package:video_viewer/ui/settings_menu/widgets/secondary_menu.dart';
import 'package:video_viewer/ui/widgets/helpers.dart';

class CaptionMenu extends StatelessWidget {
  const CaptionMenu({Key? key}) : super(key: key);

  void onTap(
    BuildContext context,
    VideoViewerSubtitle? subtitle,
    String subtitleName,
  ) async {
    final query = VideoQuery();
    final video = query.video(context);
    video.closeAllSecondarySettingsMenus();
    await video.changeSubtitle(subtitle: subtitle, subtitleName: subtitleName);
  }

  @override
  Widget build(BuildContext context) {
    final query = VideoQuery();
    final video = query.video(context, listen: true);
    final metadata = query.videoMetadata(context, listen: true);

    final activeSource = video.activeSource;
    final activeCaption = video.activeCaption;
    final none = metadata.language.captionNone;

    return SecondaryMenu(
      children: [
        CustomInkWell(
          onTap: () => onTap(context, null, none),
          child: CustomText(
            text: none,
            selected: activeCaption == none || activeCaption == null,
          ),
        ),
        for (MapEntry<String, VideoSource> entry in video.source!.entries)
          if (entry.key == activeSource && entry.value.subtitle != null)
            for (MapEntry<String, VideoViewerSubtitle> subtitle
                in entry.value.subtitle!.entries)
              CustomInkWell(
                onTap: () {
                  onTap(
                    context,
                    subtitle.value,
                    subtitle.key,
                  );
                },
                child: CustomText(
                  text: subtitle.key,
                  selected: subtitle.key == activeCaption,
                ),
              ),
      ],
    );
  }
}
