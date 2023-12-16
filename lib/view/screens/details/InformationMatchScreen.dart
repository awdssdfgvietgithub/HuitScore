import 'package:flutter/material.dart';
import 'package:huit_score/data/response/Status.dart';
import 'package:huit_score/model/ImageUrlModel.dart';
import 'package:huit_score/model/PeriodModel.dart';
import 'package:huit_score/model/PlayerModel.dart';
import 'package:huit_score/model/StatisticsItemsModel.dart';
import 'package:huit_score/model/StatusMatchModel.dart';
import 'package:huit_score/res/components/NotFoundMatches.dart';
import 'package:huit_score/res/extensions/PrimitiveDTExtension.dart';
import 'package:huit_score/theme/colors.dart';
import 'package:huit_score/view_model/DetailsMatchViewModel.dart';
import 'package:huit_score/view_model/LineupsMatchViewModel.dart';
import 'package:huit_score/view_model/ListImageUrlViewModel.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../res/components/AppTabBar.dart';
import '../../../res/components/NetworkImage.dart';
import '../../../view_model/ListStatisticsMathViewModel.dart';

class InformationMatchScreen extends StatefulWidget {
  final int matchId;

  const InformationMatchScreen({Key? key, required this.matchId})
      : super(key: key);

  @override
  _InformationMatchScreen createState() => _InformationMatchScreen();
}

class _InformationMatchScreen extends State<InformationMatchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int matchId;
  late DetailsMatchViewModel _detailsMatchViewModel;
  late LineupsMatchViewModel _lineupsMatchViewModel;
  late ListStatisticsMatchViewModel _listStatisticsMatchViewModel;
  late ListImageUrlViewModel _listImageUrlViewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    matchId = widget.matchId;
    _detailsMatchViewModel = DetailsMatchViewModel(matchId);
    _lineupsMatchViewModel = LineupsMatchViewModel(matchId);
    _listStatisticsMatchViewModel = ListStatisticsMatchViewModel(matchId);
    _listImageUrlViewModel = ListImageUrlViewModel();

    _detailsMatchViewModel.fetchDetailsMatchApi();
    _lineupsMatchViewModel.fetchLineupsMatchApi();
    _listStatisticsMatchViewModel.fetchStatisticsListApi();
    _listImageUrlViewModel.fetchImageUrls();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Lineup', 'Statistics'];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailsMatchViewModel>(
            create: (BuildContext context) => _detailsMatchViewModel),
        ChangeNotifierProvider<LineupsMatchViewModel>(
            create: (BuildContext context) => _lineupsMatchViewModel),
        ChangeNotifierProvider<ListImageUrlViewModel>(
            create: (BuildContext context) => _listImageUrlViewModel),
        ChangeNotifierProvider<ListStatisticsMatchViewModel>(
            create: (BuildContext context) => _listStatisticsMatchViewModel),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: surface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer4<DetailsMatchViewModel, LineupsMatchViewModel,
            ListImageUrlViewModel, ListStatisticsMatchViewModel>(
          builder: (context, detailsMatchViewModel, lineupsMatchViewModel,
              listImageUrlViewModel, listStatisticsMatchViewModel, child) {
            if (detailsMatchViewModel.detailsMatch.status == Status.ERROR &&
                lineupsMatchViewModel.lineupsMatch.status == Status.ERROR &&
                listStatisticsMatchViewModel.statisticsList.status ==
                    Status.ERROR) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: background,
                child: Column(
                  children: [
                    Text(
                        'detailsMatchViewModel: ${detailsMatchViewModel.detailsMatch.message}'),
                    Text(
                        'lineupsMatchViewModel: ${lineupsMatchViewModel.lineupsMatch.message}'),
                    Text(
                        'listStatisticsMatchViewModel: ${listStatisticsMatchViewModel.statisticsList.message}'),
                  ],
                ),
              );
            } else if (detailsMatchViewModel.detailsMatch.status ==
                    Status.LOADING ||
                lineupsMatchViewModel.lineupsMatch.status == Status.LOADING ||
                listStatisticsMatchViewModel.statisticsList.status ==
                    Status.LOADING) {
              return Center(
                child: Lottie.asset('assets/page_loading.json',
                    height: 150, width: 150),
              );
            } else {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: background,
                child: Column(
                  children: [
                    TopSubHeaderMatchScreen(
                        detailsMatchViewModel: detailsMatchViewModel),
                    HeaderOfInformationMatchScreen(
                      detailsMatchViewModel: detailsMatchViewModel,
                      lineupsMatchViewModel: lineupsMatchViewModel,
                      listImageUrlViewModel: listImageUrlViewModel,
                    ),
                    AppTabBar(tabController: _tabController, tabs: tabs),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          LineupTab(
                              detailsMatchViewModel: detailsMatchViewModel,
                              lineupsMatchViewModel: lineupsMatchViewModel,
                              listImageUrlViewModel: listImageUrlViewModel),
                          StatisticsTab(
                              detailsMatchViewModel: _detailsMatchViewModel,
                              listStatisticsMatchViewModel:
                                  listStatisticsMatchViewModel,
                              listImageUrlViewModel: listImageUrlViewModel),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TopSubHeaderMatchScreen extends StatelessWidget {
  final DetailsMatchViewModel detailsMatchViewModel;

  const TopSubHeaderMatchScreen(
      {super.key, required this.detailsMatchViewModel});

  @override
  Widget build(BuildContext context) {
    String country =
        detailsMatchViewModel.detailsMatch.data?.tournament?.category?.name ??
            'N/a';
    String league =
        detailsMatchViewModel.detailsMatch.data?.tournament?.tournamentName ??
            'N/a';
    String stadium =
        detailsMatchViewModel.detailsMatch.data?.venue?.stadiumName ?? '';
    return Container(
      color: surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Text(
              '$country • $league • $stadium',
              style: const TextStyle(
                fontSize: 12,
                color: onSurfaceBlack8,
                fontFamily: 'Inter_400',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineupTab extends StatelessWidget {
  final DetailsMatchViewModel detailsMatchViewModel;
  final LineupsMatchViewModel lineupsMatchViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  const LineupTab({
    Key? key,
    required this.detailsMatchViewModel,
    required this.lineupsMatchViewModel,
    required this.listImageUrlViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String homeTeamImageUrl = listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    detailsMatchViewModel.detailsMatch.data?.homeTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    String awayTeamImageUrl = listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    detailsMatchViewModel.detailsMatch.data?.awayTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    List<PlayerModel> homePlayers =
        lineupsMatchViewModel.lineupsMatch.data?.homePlayers ?? [];
    List<PlayerModel> awayPlayers =
        lineupsMatchViewModel.lineupsMatch.data?.awayPlayers ?? [];

    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppNetworkImage(url: homeTeamImageUrl, size: 17),
                        const Text(
                          'PLAYER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter_700',
                            color: onSurfaceBlack8,
                          ),
                        ),
                        AppNetworkImage(url: awayTeamImageUrl, size: 17),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (homePlayers.isNotEmpty && awayPlayers.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homePlayers.length,
                              itemBuilder: (context, index) {
                                return _buildPlayerItem(homePlayers[index],
                                    index: index, isHome: true);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: awayPlayers.length,
                              itemBuilder: (context, index) {
                                return _buildPlayerItem(awayPlayers[index],
                                    index: index, isHome: false);
                              },
                            ),
                          ),
                        ],
                      )
                    ] else ...[
                      const NotFoundMatches(
                        title: 'Sorry!',
                        subTitle:
                            'The lineups are not ready yet, please come back later.',
                      )
                    ]
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                decoration: const BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppNetworkImage(url: homeTeamImageUrl, size: 17),
                          const Text(
                            'COACH',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter_700',
                              color: onSurfaceBlack8,
                            ),
                          ),
                          AppNetworkImage(url: awayTeamImageUrl, size: 17),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            detailsMatchViewModel.detailsMatch.data?.homeTeam
                                    ?.shortNameManager ??
                                'N/a',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter_400',
                              color: onSurfaceBlack12,
                            ),
                          ),
                          Text(
                            detailsMatchViewModel.detailsMatch.data?.awayTeam
                                    ?.shortNameManager ??
                                'N/a',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter_400',
                              color: onSurfaceBlack12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerItem(PlayerModel player,
      {required int index, required bool isHome}) {
    return Column(
      children: [
        if (isHome) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (player.captain == true)
                const Text(
                  "C",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Inter_700',
                    color: Colors.red,
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                player.shortName.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: onSurfaceBlack12,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                player.shirtNumber.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'SpaceGrotesk_700',
                  color: onSurfaceBlack12,
                ),
              ),
            ],
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                player.shirtNumber.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'SpaceGrotesk_700',
                  color: onSurfaceBlack12,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                player.shortName.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: onSurfaceBlack12,
                ),
              ),
              const SizedBox(width: 10),
              if (player.captain == true)
                const Text(
                  "C",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Inter_700',
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ],
        if (index == 10) ...[
          const SizedBox(height: 5),
          const Divider(
            height: 1,
            thickness: 1,
            color: background,
          ),
          const SizedBox(height: 5)
        ]
      ],
    );
  }
}

class StatisticsTab extends StatefulWidget {
  final DetailsMatchViewModel detailsMatchViewModel;
  final ListStatisticsMatchViewModel listStatisticsMatchViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  StatisticsTab({
    Key? key,
    required this.listStatisticsMatchViewModel,
    required this.listImageUrlViewModel,
    required this.detailsMatchViewModel,
  }) : super(key: key);

  @override
  _StatisticsTabState createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  int _selectedIndex = 0;
  late List<GroupModel> allGroupsList = [];
  late List<GroupModel> oneSTGroupsList = [];
  late List<GroupModel> twoNDGroupsList = [];
  late List<GroupModel> selectedList = [];

  @override
  void initState() {
    super.initState();
    allGroupsList = widget.listStatisticsMatchViewModel.allGroupsList;
    oneSTGroupsList = widget.listStatisticsMatchViewModel.oneSTGroupsList;
    twoNDGroupsList = widget.listStatisticsMatchViewModel.twoNDGroupsList;
    if (widget.listStatisticsMatchViewModel.allGroupsList.isNotEmpty) {
      setState(() {
        selectedList = widget.listStatisticsMatchViewModel.allGroupsList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String homeTeamImageUrl = widget.listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    widget.detailsMatchViewModel.detailsMatch.data?.homeTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    String awayTeamImageUrl = widget.listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    widget.detailsMatchViewModel.detailsMatch.data?.awayTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';

    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 24),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                children: <Widget>[
                  if (allGroupsList.isNotEmpty) ...[
                    _buildChoiceChip(0, 'ALL', () {
                      setState(() {
                        _selectedIndex = 0;
                        selectedList = allGroupsList;
                      });
                    }),
                  ],
                  if (oneSTGroupsList.isNotEmpty) ...[
                    _buildChoiceChip(1, 'First half', () {
                      setState(() {
                        _selectedIndex = 1;
                        selectedList = oneSTGroupsList;
                      });
                    }),
                  ],
                  if (twoNDGroupsList.isNotEmpty) ...[
                    _buildChoiceChip(2, 'Second half', () {
                      setState(() {
                        _selectedIndex = 2;
                        selectedList = twoNDGroupsList;
                      });
                    }),
                  ]
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppNetworkImage(url: homeTeamImageUrl, size: 17),
                        const Text(
                          'TEAM STATS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter_700',
                            color: onSurfaceBlack8,
                          ),
                        ),
                        AppNetworkImage(url: awayTeamImageUrl, size: 17),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (allGroupsList.isNotEmpty ||
                        oneSTGroupsList.isNotEmpty ||
                        twoNDGroupsList.isNotEmpty) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedList.length,
                        itemBuilder: (context, groupIndex) {
                          return Column(
                            children: [
                              Card(
                                elevation: 0.8,
                                color: surface,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "${allGroupsList[groupIndex].groupName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Inter_600',
                                      color: onSurfaceBlack12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: selectedList[groupIndex]
                                              .statisticsItemList
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return _buildStatisticsItem(
                                            selectedList[groupIndex]
                                                .statisticsItemList![index],
                                            index: index,
                                            isHome: true);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: selectedList[groupIndex]
                                              .statisticsItemList
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          "${selectedList[groupIndex].statisticsItemList![index].name}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Inter_600',
                                            color: onSurfaceBlack12,
                                          ),
                                          maxLines: 1,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: selectedList[groupIndex]
                                              .statisticsItemList
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return _buildStatisticsItem(
                                            selectedList[groupIndex]
                                                .statisticsItemList![index],
                                            index: index,
                                            isHome: false);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ] else ...[
                      const NotFoundMatches(
                        title: 'Sorry!',
                        subTitle:
                            'The statistics are not ready yet, please come back later.',
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(
    int index,
    String label,
    VoidCallback onChipSelected,
  ) {
    return ChoiceChip(
      selectedColor: primary,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      selected: _selectedIndex == index,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Inter_700',
          color: _selectedIndex == index ? surface : onSecondary,
        ),
      ),
      onSelected: (selected) {
        if (selected) {
          onChipSelected(); // Move the call to onChipSelected inside the if condition
        }
      },
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.transparent), // No border
      ),
    );
  }

  Widget _buildStatisticsItem(StatisticsItemModel statisticsItem,
      {required int index, required bool isHome}) {
    return Column(
      children: [
        if (isHome) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                statisticsItem.home ?? 'N/a',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'SpaceGrotesk_400',
                  color: onSurfaceBlack12,
                ),
              ),
            ],
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                statisticsItem.away ?? 'N/a',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'SpaceGrotesk_400',
                  color: onSurfaceBlack12,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class HeaderOfInformationMatchScreen extends StatelessWidget {
  final DetailsMatchViewModel detailsMatchViewModel;
  final LineupsMatchViewModel lineupsMatchViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  const HeaderOfInformationMatchScreen(
      {super.key,
      required this.detailsMatchViewModel,
      required this.lineupsMatchViewModel,
      required this.listImageUrlViewModel});

  @override
  Widget build(BuildContext context) {
    String homeTeamImageUrl = listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    detailsMatchViewModel.detailsMatch.data?.homeTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    String awayTeamImageUrl = listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    detailsMatchViewModel.detailsMatch.data?.awayTeam?.id
                        .toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    String homeShortName =
        detailsMatchViewModel.detailsMatch.data?.homeTeam?.shortName ?? 'N/a';
    String awayShortName =
        detailsMatchViewModel.detailsMatch.data?.awayTeam?.shortName ?? 'N/a';
    String homeFormation =
        lineupsMatchViewModel.lineupsMatch.data?.homeFormation ?? 'N/a';
    String awayFormation =
        lineupsMatchViewModel.lineupsMatch.data?.awayFormation ?? 'N/a';
    String homeScore =
        detailsMatchViewModel.detailsMatch.data?.homeScore.toString() ?? '-1';
    String awayScore =
        detailsMatchViewModel.detailsMatch.data?.awayScore.toString() ?? '-1';
    int matchTimestamp =
        detailsMatchViewModel.detailsMatch.data?.matchTimestamp ?? -1;
    int startTimestamp =
        detailsMatchViewModel.detailsMatch.data?.startTimestamp ?? -1;
    int extra = detailsMatchViewModel.detailsMatch.data?.extra ?? 780;
    StatusMatchModel statusMatch =
        detailsMatchViewModel.detailsMatch.data?.statusMatch ??
            StatusMatchModel();
    return Container(
      width: double.infinity,
      color: surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 129,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TeamLogoAndName(
                teamImageUrl: homeTeamImageUrl,
                shortName: homeShortName,
                turnName: 'Home',
                formation: homeFormation,
              ),
              StatusMatch(
                homeScore: homeScore,
                awayScore: awayScore,
                matchTimestamp: matchTimestamp,
                startTimestamp: startTimestamp,
                statusMatch: statusMatch,
                extra: extra,
              ),
              TeamLogoAndName(
                teamImageUrl: awayTeamImageUrl,
                shortName: awayShortName,
                turnName: 'Away',
                formation: awayFormation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusMatch extends StatelessWidget {
  final String homeScore;
  final String awayScore;
  final int matchTimestamp;
  final int startTimestamp;
  final int extra;
  final StatusMatchModel statusMatch;

  const StatusMatch(
      {super.key,
      required this.homeScore,
      required this.awayScore,
      required this.matchTimestamp,
      required this.startTimestamp,
      required this.statusMatch,
      required this.extra});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (statusMatch.type == 'inprogress') ...[
            Text(
              "${((matchTimestamp + extra * 2 - startTimestamp) / 60).round()}'",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter_700',
                color: onSurfaceBlue8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '$homeScore - $awayScore',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'SpaceGrotesk_700',
                    color: onSurfaceBlue8,
                  ),
                ),
              ],
            )
          ] else if (statusMatch.code == 100) ...[
            Row(
              children: [
                Text(
                  '$homeScore - $awayScore',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'SpaceGrotesk_700',
                    color: onSurfaceBlack10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Finished',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Inter_400',
                color: onSurfaceBlack10,
              ),
            ),
          ] else ...[
            Text(
              startTimestamp.parseToDateHM(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter_700',
                color: onSurfaceBlack10,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              DateFormat('dd/MM/yyyy').format(startTimestamp.parseToDate()),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter_400',
                color: onSurfaceBlack10,
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class TeamLogoAndName extends StatelessWidget {
  final String teamImageUrl;
  final String shortName;
  final String turnName;
  final String formation;

  const TeamLogoAndName(
      {super.key,
      required this.teamImageUrl,
      required this.shortName,
      required this.turnName,
      required this.formation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      color: surface,
      child: Column(
        children: [
          AppNetworkImage(url: teamImageUrl, size: 52),
          const SizedBox(height: 12),
          Text(
            shortName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Inter_500',
              color: onSurfaceBlack12,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 4),
          Text(
            turnName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter_500',
              color: onSurfaceBlack8,
            ),
          ),
          const SizedBox(height: 4),
          if (formation != 'N/a') ...[
            Text(
              formation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Inter_400',
                color: onSurfaceBlack12,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ]
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
