import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/screens/settings/widgets/github_icon.dart';
import 'package:statiescan/src/screens/settings/widgets/settings_section.dart';
import 'package:statiescan/src/screens/settings/widgets/show_statistics_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  void _openStatsPopup(BuildContext context) {
    showDialog(context: context, builder: (context) => ShowStatisticsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.aboutSection,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.statisticsOption),
          leading: const Icon(Icons.bar_chart),
          onTap: () => _openStatsPopup(context),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.reviewUsOption),
          subtitle: Text(AppLocalizations.of(context)!.reviewUsDescription),
          leading: const Icon(Icons.star_rate),
          onTap: () => InAppReview.instance.openStoreListing(),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.githubOption),
          leading: const GithubIcon(),
          subtitle: Text(AppLocalizations.of(context)!.githubDescription),
          onTap: () => launchUrlString("https://github.com/reneax/statiescan"),
        ),
      ],
    );
  }
}
