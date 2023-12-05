import 'package:flutter/material.dart';
import 'package:huit_score/model/MatchScheduleModel.dart';
import 'package:huit_score/res/components/ContainerByLeague.dart';
import 'package:huit_score/view_model/ListImageUrlViewModel.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/response/Status.dart';
import 'package:provider/provider.dart';

import '../../../res/components/ContentsContainer.dart';
import '../../../res/components/HeaderWithSeeAll.dart';
import '../../../res/components/HomeTopShimmer.dart';
import '../../../res/components/MatchItem.dart';
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

  @override
  void initState() {
    _homeViewModel.fetchMoviesListApi();
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
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContentsContainer(
                  title: HeaderWithSeeAll(
                    title: 'Live Now',
                    isShowSeeAllButton: true,
                    onSeeAllClicked: () {},
                  ),
                  content: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    height: 200, // Adjust the height as needed
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) =>
                          const VerticalDivider(
                        width: 8,
                        thickness: 0,
                        color: background,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 200,
                          height: double.infinity,
                          color: Colors.blue,
                          child: Column(
                            children: [
                              Text('Item $index'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ContentsContainer(
                  title: HeaderWithSeeAll(
                    title: 'Top',
                    isShowSeeAllButton: true,
                    onSeeAllClicked: () {},
                  ),
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
                            return Text(
                                model.matchSchedules.message.toString());
                          case Status.SUCCESS:
                            return Column(
                              children: [
                                if (model.premierLeagueMatches.isNotEmpty) ...[
                                  ContainerByLeague(
                                      list: model.premierLeagueMatches,
                                      listImageUrlViewModel:
                                          _imageUrlViewModel),
                                  const SizedBox(height: 14)
                                ],
                                if (model.laligaMatches.isNotEmpty) ...[
                                  ContainerByLeague(
                                      list: model.premierLeagueMatches,
                                      listImageUrlViewModel:
                                          _imageUrlViewModel),
                                  const SizedBox(height: 14)
                                ],
                                if (model.seriaAMatches.isNotEmpty) ...[
                                  ContainerByLeague(
                                      list: model.premierLeagueMatches,
                                      listImageUrlViewModel:
                                          _imageUrlViewModel),
                                  const SizedBox(height: 14)
                                ],
                                if (model.ligue1Matches.isNotEmpty) ...[
                                  ContainerByLeague(
                                      list: model.premierLeagueMatches,
                                      listImageUrlViewModel:
                                          _imageUrlViewModel),
                                  const SizedBox(height: 14)
                                ],
                                if (model.bundesligaMatches.isNotEmpty) ...[
                                  ContainerByLeague(
                                      list: model.premierLeagueMatches,
                                      listImageUrlViewModel:
                                          _imageUrlViewModel),
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
      ),
    );
  }
}
