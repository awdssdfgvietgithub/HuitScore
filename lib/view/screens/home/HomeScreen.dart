import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/model/ImageUrlModel.dart';
import 'package:huit_score/model/MatchScheduleModel.dart';
import 'package:huit_score/res/components/ContainerByLeague.dart';
import 'package:huit_score/res/components/LiveMatchItem.dart';
import 'package:huit_score/view_model/ListImageUrlViewModel.dart';
import 'package:lottie/lottie.dart';

import '../../../data/response/Status.dart';
import 'package:provider/provider.dart';

import '../../../data/local/mock/ImageResModel.dart';
import '../../../res/components/ContentsContainer.dart';
import '../../../res/components/HeaderWithSeeAll.dart';
import '../../../res/components/HomeTopShimmer.dart';
import '../../../res/components/NotFoundMatches.dart';
import '../../../theme/colors.dart';
import '../../../view_model/HomeViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  final ListImageUrlViewModel _imageUrlViewModel = ListImageUrlViewModel();

  bool isShowAllLiveMatches = false;
  bool _apiCallMade = false;

  @override
  void initState() {
    _imageUrlViewModel.fetchImageUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (BuildContext context) => _homeViewModel),
        ChangeNotifierProvider<ListImageUrlViewModel>(
            create: (BuildContext context) => _imageUrlViewModel),
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
                  _homeViewModel.fetchMoviesListApi();
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
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: RefreshIndicator(
        onRefresh: () {
          return _homeViewModel.refresh();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContentsContainer(
                title: HeaderWithSeeAll(
                    title: 'Live Now',
                    isShowSeeAllButton: true,
                    onSeeAllClicked: () {
                      setState(() {
                        isShowAllLiveMatches =
                            !isShowAllLiveMatches; // Update the flag to show all items
                      });
                    },
                    isShowAllMatches: isShowAllLiveMatches),
                content: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Consumer<HomeViewModel>(
                    builder: (context, model, _) {
                      switch (model.matchSchedules.status) {
                        case Status.LOADING:
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for(int index = 1; index <= 3; index++)
                                  const HomeTopShimmer2()
                              ],
                            ),
                          );
                        case Status.ERROR:
                          return Text(model.matchSchedules.message.toString());
                        case Status.SUCCESS:
                          List<MatchScheduleModel> liveMatches =
                              model.liveMatches;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int index = 0;
                                index < (isShowAllLiveMatches
                                    ? liveMatches.length
                                    : liveMatches.length.clamp(0, 3));
                                index++)
                                  LiveMatchItem(
                                    model: liveMatches[index],
                                    homeTeamImageUrl: _imageUrlViewModel.imageUrls
                                        .firstWhere(
                                          (item) =>
                                      item.id ==
                                          (liveMatches[index].homeTeam?.id)
                                              .toString(),
                                      orElse: () => ImageUrlModel(),
                                    )
                                        .url ??
                                        '',
                                    awayTeamImageUrl: _imageUrlViewModel.imageUrls
                                        .firstWhere(
                                          (item) =>
                                      item.id ==
                                          (liveMatches[index].awayTeam?.id)
                                              .toString(),
                                      orElse: () => ImageUrlModel(),
                                    )
                                        .url ??
                                        '',
                                    resStringFound: mockImageResData
                                        .firstWhere(
                                          (item) => item.id ==
                                          liveMatches[index].tournament?.tournamentId,
                                      orElse: () => ImageResModel(),
                                    )
                                        .resString ??
                                        '',
                                  ),
                              ],
                            ),
                          );
                        case null:
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ContentsContainer(
                title: HeaderWithSeeAll(
                    title: 'Top',
                    isShowSeeAllButton: false,
                    onSeeAllClicked: () {},
                    isShowAllMatches: isShowAllLiveMatches),
                content: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Consumer<HomeViewModel>(
                    builder: (context, model, _) {
                      switch (model.matchSchedules.status) {
                        case Status.LOADING:
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return const HomeTopShimmer();
                              });
                        case Status.ERROR:
                          return Text(model.matchSchedules.message.toString());
                        case Status.SUCCESS:
                          return Column(
                            children: [
                              if (model.premierLeagueMatches.isEmpty &&
                                  model.laligaMatches.isEmpty &&
                                  model.seriaAMatches.isEmpty &&
                                  model.ligue1Matches.isEmpty &&
                                  model.bundesligaMatches.isEmpty) ...[
                                const NotFoundMatches(
                                  title: 'So Sad!',
                                  subTitle: 'There are currently no matches.',
                                )
                              ],
                              if (model.premierLeagueMatches.isNotEmpty) ...[
                                ContainerByLeague(
                                    list: model.premierLeagueMatches,
                                    listImageUrlViewModel: _imageUrlViewModel),
                                const SizedBox(height: 14)
                              ],
                              if (model.laligaMatches.isNotEmpty) ...[
                                ContainerByLeague(
                                    list: model.laligaMatches,
                                    listImageUrlViewModel: _imageUrlViewModel),
                                const SizedBox(height: 14)
                              ],
                              if (model.seriaAMatches.isNotEmpty) ...[
                                ContainerByLeague(
                                    list: model.seriaAMatches,
                                    listImageUrlViewModel: _imageUrlViewModel),
                                const SizedBox(height: 14)
                              ],
                              if (model.ligue1Matches.isNotEmpty) ...[
                                ContainerByLeague(
                                    list: model.ligue1Matches,
                                    listImageUrlViewModel: _imageUrlViewModel),
                                const SizedBox(height: 14)
                              ],
                              if (model.bundesligaMatches.isNotEmpty) ...[
                                ContainerByLeague(
                                    list: model.bundesligaMatches,
                                    listImageUrlViewModel: _imageUrlViewModel),
                                const SizedBox(height: 14)
                              ],
                            ],
                          );
                        case null:
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 48)
            ],
          ),
        ),
      ),
    );
  }

  Widget noInternet() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () {
          return _homeViewModel.refresh();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
