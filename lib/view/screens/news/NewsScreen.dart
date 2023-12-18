import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/data/response/Status.dart';
import 'package:huit_score/model/livescore/NewsModel.dart';
import 'package:huit_score/res/components/ImageWithDes.dart';
import 'package:huit_score/res/components/NotFoundMatches.dart';
import 'package:huit_score/res/extensions/NavigatorExtension.dart';
import 'package:huit_score/res/extensions/PrimitiveDTExtension.dart';
import 'package:huit_score/view/screens/details/DetailsNewsScreen.dart';
import 'package:huit_score/view_model/ListImageUrlViewModel.dart';
import 'package:huit_score/view_model/NewsViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsViewModel _newsViewModel;
  bool _apiCallMade = false;

  @override
  void initState() {
    super.initState();
    _newsViewModel = NewsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsViewModel>(
            create: (BuildContext context) => _newsViewModel),
      ],
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: background,
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result == ConnectivityResult.wifi ||
                  result == ConnectivityResult.mobile) {
                if (!_apiCallMade) {
                  log('co call lai');
                  _newsViewModel.fetchNewsListApi();
                  _apiCallMade = true;
                }
                return connected();
              } else {
                return noInternet();
              }
            } else {
              return noInternet();
            }
          },
        ),
      ),
    );
  }

  Widget connected() {
    return RefreshIndicator(
      onRefresh: () {
        return _newsViewModel.refresh();
      },
      child: Consumer<NewsViewModel>(
        builder: (context, model, _) {
          switch (model.newsList.status) {
            case Status.LOADING:
              return Center(
                child: Lottie.asset('assets/page_loading.json',
                    height: 150, width: 150),
              );
            case Status.ERROR:
              return Center(child: Text(model.newsList.message.toString()));
            case Status.SUCCESS:
              List<NewsModel> newsList = model.newsList.data ?? [];
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    for (var index = 0; index < newsList.length; index++)
                      GestureDetector(
                        onTap: () =>
                        {
                          context.pushReplacementWithSlideTransition(
                              DetailsNewsScreen(news: newsList[index])
                          )
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Material(
                            elevation: 2,
                            color: surface,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${newsList[index].title}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: onSurfaceBlack12,
                                      fontFamily: 'Inter_700',
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  ImageWithDes(
                                      imageUrl: "${newsList[index].image
                                          ?.galleryUrl}",
                                      des: "${newsList[index].image?.des}"),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${newsList[index].subtitle}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: onSurfaceBlack10,
                                      fontFamily: 'Inter_400',
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      newsList[index]
                                          .publishedAt
                                          ?.toString()
                                          .parseDateTime() ??
                                          'N/a',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: onSurfaceBlack8,
                                        fontFamily: 'Inter_400',
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget noInternet() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () {
          return _newsViewModel.refresh();
        },
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/no_connection.json'),
                  const Text(
                    'No internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter_700',
                      color: onSurfaceBlack12,
                    ),
                  ),
                  const Text(
                    'Check your connection, then refresh the page',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter_400',
                      color: onSurfaceBlack12,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
