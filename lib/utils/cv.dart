// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Triggers a browser download of the CV that ships in `web/`.
void downloadCV() {
  final anchor = html.AnchorElement(href: 'Krystler_John_Tabinas_CV.pdf')
    ..setAttribute('download', 'Krystler_John_Tabinas_CV.pdf')
    ..style.display = 'none';
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
