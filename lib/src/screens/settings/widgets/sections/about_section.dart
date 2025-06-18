import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
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
      title: "Over",
      children: [
        ListTile(
          title: const Text("Statistieken"),
          leading: const Icon(Icons.bar_chart),
          onTap: () => _openStatsPopup(context),
        ),
        ListTile(
          title: const Text("Beoordeel ons"),
          subtitle: const Text("Geef de app een beoordeling"),
          leading: const Icon(Icons.star_rate),
          onTap: () => InAppReview.instance.openStoreListing(),
        ),
        ListTile(
          title: const Text("Github"),
          leading: const GithubIcon(),
          subtitle: const Text("Bekijk de broncode van de app"),
          onTap: () => launchUrlString("https://github.com/reneax/statiescan"),
        ),
      ],
    );
  }
}
