import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/model/livescore/NewsModel.dart';
import 'package:huit_score/res/components/ImageWithDes.dart';
import 'package:huit_score/res/extensions/PrimitiveDTExtension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/colors.dart';

class DetailsNewsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailsNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Text(
                          'Publish at: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: onSurfaceBlack8,
                            fontFamily: 'Inter_400',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          news.publishedAt?.toString().parseDateTime() ?? 'N/a',
                          style: const TextStyle(
                            fontSize: 14,
                            color: onSurfaceBlack8,
                            fontFamily: 'Inter_400',
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: <Widget>[
                        const Text(
                          'Authors:',
                          style: TextStyle(
                            fontSize: 14,
                            color: onSurfaceBlack8,
                            fontFamily: 'Inter_400',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        if (news.authorsList?.isNotEmpty == true) ...[
                          for (int i = 0; i < news.authorsList!.length; i++)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: primary,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Text(
                                news.authorsList?[i].name ?? 'N/a',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: surface,
                                  fontFamily: 'Inter_600',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${news.title}",
              style: const TextStyle(
                fontSize: 18,
                color: onSurfaceBlack12,
                fontFamily: 'Inter_700',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${news.subtitle}",
              style: const TextStyle(
                fontSize: 16,
                color: onSurfaceBlack10,
                fontFamily: 'Inter_400',
              ),
            ),
            const SizedBox(height: 8),
            ImageWithDes(
                imageUrl: "${news.image?.galleryUrl}",
                des: "${news.image?.des}"),
            const SizedBox(height: 8),
            if (news.bodiesList?.isNotEmpty == true) ...[
              for (int i = 0; i < news.bodiesList!.length; i++) ...[
                if (news.bodiesList![i].type == 'editor_block') ...[
                  Text(
                    news.bodiesList![i].editorBlockType?.content
                        ?.toString()
                        .removeHtmlTagsAndNbsp() ??
                        'N/a',
                    style: const TextStyle(
                      fontSize: 16,
                      color: onSurfaceBlack10,
                      fontFamily: 'Inter_400',
                    ),
                  ),
                ],
                if (news.bodiesList![i].type == 'image') ...[
                  ImageWithDes(
                      imageUrl: news.bodiesList![i].imageType?.galleryUrl ?? 'N/a',
                      des: news.bodiesList![i].imageType?.imageDes ?? 'N/a')
                ],
                if (news.bodiesList![i].type == 'link') ...[
                  Column(
                    children: [
                      Text(
                        news.bodiesList![i].linkType?.text
                            ?.toString()
                            .removeHtmlTagsAndNbsp() ??
                            'N/a',
                        style: const TextStyle(
                          fontSize: 16,
                          color: onSurfaceBlack10,
                          fontFamily: 'Inter_400',
                        ),
                      ),
                      WebLinkWidget(news.bodiesList![i].linkType?.link ?? 'N/a'),
                      Text(
                        news.bodiesList![i].linkType?.link
                            ?.toString()
                            .removeHtmlTagsAndNbsp() ??
                            'N/a',
                        style: const TextStyle(
                          fontSize: 16,
                          color: onSurfaceBlack10,
                          fontFamily: 'Inter_400',
                        ),
                      ),
                    ],
                  )
                ],
                const SizedBox(height: 8)
              ]
            ]
          ],
        ),
      ),
    );
  }
}

class WebLinkWidget extends StatelessWidget {
  final String url;

  WebLinkWidget(this.url);

  _launchURL() async {
    String formattedUrl = url;
    if (!formattedUrl.startsWith('http://') && !formattedUrl.startsWith('https://')) {
      formattedUrl = 'http://$formattedUrl';
    }
    if (await canLaunch(formattedUrl)) {
      await launch(formattedUrl);
    } else {
      throw 'Could not launch $formattedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL();
      },
      child: Text(
        'Link',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}