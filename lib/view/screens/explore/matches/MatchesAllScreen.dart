import 'package:flutter/material.dart';
import 'package:huit_score/data/local/mock/PromotionStatus.dart';
import 'package:huit_score/model/foot/ImageUrlModel.dart';
import 'package:huit_score/res/components/ExplainColorStandingDialog.dart';
import 'package:huit_score/theme/colors.dart';
import 'package:huit_score/view_model/ListLeagueEventsByRoundViewModel.dart';
import 'package:huit_score/view_model/ListLeagueRoundsViewModel.dart';
import 'package:huit_score/view_model/ListTeamsOnStandingViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/Status.dart';
import '../../../../data/local/mock/ImageResModel.dart';
import '../../../../res/components/MatchItem.dart';
import '../../../../res/components/NetworkImage.dart';
import '../../../../view_model/ListImageUrlViewModel.dart';

class MatchesAllScreen extends StatefulWidget {
  final int tournamentId;
  final int seasonId;

  const MatchesAllScreen(
      {Key? key, required this.tournamentId, required this.seasonId})
      : super(key: key);

  @override
  _MatchesAllScreen createState() => _MatchesAllScreen();
}

class _MatchesAllScreen extends State<MatchesAllScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedRoundId = '';
  late int tournamentId;
  late int seasonId;
  late ListLeagueRoundsViewModel _leagueRoundsViewModel;
  late ListLeagueEventsByRoundViewModel _leagueEventsByRoundViewModel;
  late ListImageUrlViewModel _listImageUrlViewModel;
  late ListTeamsOnStandingViewModel _listTeamsOnStandingViewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    tournamentId = widget.tournamentId;
    seasonId = widget.seasonId;
    _leagueRoundsViewModel = ListLeagueRoundsViewModel(tournamentId, seasonId);
    _leagueEventsByRoundViewModel = ListLeagueEventsByRoundViewModel();
    _listImageUrlViewModel = ListImageUrlViewModel();
    _listTeamsOnStandingViewModel =
        ListTeamsOnStandingViewModel(tournamentId, seasonId);

    _leagueRoundsViewModel.fetchLeagueRoundsApi();
    _leagueEventsByRoundViewModel.fetchMatchSchedules(
        tournamentId, seasonId, 1);
    _listImageUrlViewModel.fetchImageUrls();
    _listTeamsOnStandingViewModel.fetchTeamsOnStandingApi();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateMatchSchedules(int selectedRoundId) {
    _leagueEventsByRoundViewModel.fetchMatchSchedules(
        tournamentId, seasonId, selectedRoundId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListLeagueRoundsViewModel>(
            create: (BuildContext context) => _leagueRoundsViewModel),
        ChangeNotifierProvider<ListLeagueEventsByRoundViewModel>(
            create: (BuildContext context) => _leagueEventsByRoundViewModel),
        ChangeNotifierProvider<ListImageUrlViewModel>(
            create: (BuildContext context) => _listImageUrlViewModel),
        ChangeNotifierProvider<ListTeamsOnStandingViewModel>(
            create: (BuildContext context) => _listTeamsOnStandingViewModel),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.question_mark, color: primary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ExplainColorStandingDialog();
                  },
                );
              },
            ),
          ],
        ),
        body: Consumer<ListLeagueEventsByRoundViewModel>(
            builder: (context, listLeagueEventsByRoundViewModel, child) {
          if (listLeagueEventsByRoundViewModel.matchSchedules.status ==
                  Status.SUCCESS &&
              listLeagueEventsByRoundViewModel.matchSchedules.data != null) {
            return Container(
                height: double.infinity,
                width: double.infinity,
                color: background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: surface,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, left: 16, right: 16, bottom: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 68,
                              width: 68,
                              child: Image.asset(
                                mockImageResData
                                        .firstWhere(
                                            (item) =>
                                                item.id ==
                                                listLeagueEventsByRoundViewModel
                                                    .matchSchedules
                                                    .data
                                                    ?.first
                                                    .tournament
                                                    ?.tournamentId,
                                            orElse: () => ImageResModel())
                                        .resString ??
                                    '',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listLeagueEventsByRoundViewModel
                                          .matchSchedules
                                          .data
                                          ?.first
                                          .tournament
                                          ?.tournamentName ??
                                      'N/a',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter_700',
                                    color: onBackground,
                                  ),
                                ),
                                Text(
                                  listLeagueEventsByRoundViewModel
                                          .matchSchedules
                                          .data
                                          ?.first
                                          .tournament
                                          ?.category
                                          ?.categoryName ??
                                      'N/a',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter_400',
                                    color: onSurfaceBlack10,
                                  ),
                                ),
                                const Text(
                                  "2023/2024",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter_400',
                                    color: onSurfaceBlack8,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: surface,
                      child: TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Matches'),
                          Tab(text: 'Standing'),
                        ],
                        labelColor: primary,
                        unselectedLabelColor: onSecondary,
                        labelStyle: const TextStyle(
                          fontFamily: 'Inter_700',
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: 'Inter_700',
                          fontSize: 14,
                        ),
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(width: 3, color: primary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 24, right: 24),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Weeks",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter_700',
                                            color: onBackground,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Consumer<ListLeagueRoundsViewModel>(
                                          builder: (context,
                                              listLeagueRoundsViewModel,
                                              child) {
                                            if (listLeagueRoundsViewModel
                                                        .leagueRounds.status ==
                                                    Status.SUCCESS &&
                                                listLeagueRoundsViewModel
                                                        .leagueRounds.data !=
                                                    null) {
                                              return DropdownButton<int>(
                                                value: int.tryParse(
                                                        _selectedRoundId) ??
                                                    listLeagueRoundsViewModel
                                                        .leagueRounds
                                                        .data!
                                                        .rounds!
                                                        .first,
                                                onChanged: (int? newValue) {
                                                  setState(() {
                                                    _selectedRoundId =
                                                        newValue.toString();
                                                  });
                                                  updateMatchSchedules(
                                                      newValue!);
                                                },
                                                items: listLeagueRoundsViewModel
                                                    .leagueRounds.data!.rounds!
                                                    .map<DropdownMenuItem<int>>(
                                                        (int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text(
                                                      value.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Inter_700',
                                                        color: onBackground,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              );
                                            } else {
                                              return const Text(
                                                "Loading...",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Inter_700',
                                                  color: onBackground,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: surface,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Column(
                                        children: List.generate(
                                          listLeagueEventsByRoundViewModel
                                                  .matchSchedules
                                                  .data
                                                  ?.length ??
                                              0,
                                          (index) {
                                            return Column(
                                              children: [
                                                MatchItem(
                                                  model:
                                                      listLeagueEventsByRoundViewModel
                                                          .matchSchedules
                                                          .data![index],
                                                  homeTeamImageUrl: _listImageUrlViewModel
                                                          .imageUrls
                                                          .firstWhere(
                                                              (item) =>
                                                                  item.id ==
                                                                  listLeagueEventsByRoundViewModel
                                                                      .matchSchedules
                                                                      .data![
                                                                          index]
                                                                      .homeTeam
                                                                      ?.id
                                                                      .toString(),
                                                              orElse: () =>
                                                                  ImageUrlModel())
                                                          .url ??
                                                      '',
                                                  awayTeamImageUrl: _listImageUrlViewModel
                                                          .imageUrls
                                                          .firstWhere(
                                                              (item) =>
                                                                  item.id ==
                                                                  listLeagueEventsByRoundViewModel
                                                                      .matchSchedules
                                                                      .data![
                                                                          index]
                                                                      .awayTeam
                                                                      ?.id
                                                                      .toString(),
                                                              orElse: () =>
                                                                  ImageUrlModel())
                                                          .url ??
                                                      '',
                                                ),
                                                if (index <
                                                    listLeagueEventsByRoundViewModel
                                                            .matchSchedules
                                                            .data!
                                                            .length -
                                                        1)
                                                  const Divider(
                                                    color: background,
                                                    thickness: 1.0,
                                                    indent: 16.0,
                                                    endIndent: 16.0,
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Consumer<ListTeamsOnStandingViewModel>(builder:
                              (context, listTeamsOnStandingViewModel, child) {
                            if (listTeamsOnStandingViewModel
                                        .teamsOnStanding.status ==
                                    Status.SUCCESS &&
                                listTeamsOnStandingViewModel
                                        .teamsOnStanding.data !=
                                    null) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: surface,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 12, bottom: 48),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const HeaderStanding(),
                                          Column(
                                            children: List.generate(
                                              listTeamsOnStandingViewModel
                                                      .teamsOnStanding
                                                      .data
                                                      ?.length ??
                                                  0,
                                              (index) {
                                                return Column(
                                                  children: [
                                                    RowContentStanding(
                                                      position:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .position ??
                                                              -1,
                                                      shortName:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .team
                                                                  ?.shortName ??
                                                              'N/a',
                                                      matches:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .matches ??
                                                              -1,
                                                      wins: listTeamsOnStandingViewModel
                                                              .teamsOnStanding
                                                              .data?[index]
                                                              .wins ??
                                                          -1,
                                                      draws:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .draws ??
                                                              -1,
                                                      losses:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .losses ??
                                                              -1,
                                                      scoresFor:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .scoresFor ??
                                                              -1,
                                                      scoresAgainst:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .scoresAgainst ??
                                                              -1,
                                                      points:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .points ??
                                                              -1,
                                                      teamLogo: _listImageUrlViewModel
                                                              .imageUrls
                                                              .firstWhere(
                                                                  (item) =>
                                                                      item.id ==
                                                                      (listTeamsOnStandingViewModel
                                                                              .teamsOnStanding
                                                                              .data?[
                                                                                  index]
                                                                              .team
                                                                              ?.id)
                                                                          .toString(),
                                                                  orElse: () =>
                                                                      ImageUrlModel())
                                                              .url ??
                                                          '',
                                                      promotionId:
                                                          listTeamsOnStandingViewModel
                                                                  .teamsOnStanding
                                                                  .data?[index]
                                                                  .promotionId ??
                                                              -1,
                                                    ),
                                                    if (index <
                                                        listTeamsOnStandingViewModel
                                                                .teamsOnStanding
                                                                .data!
                                                                .length -
                                                            1)
                                                      const Divider(
                                                        color: background,
                                                        thickness: 1.0,
                                                        indent: 16.0,
                                                        endIndent: 16.0,
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            }
                            if (listTeamsOnStandingViewModel
                                    .teamsOnStanding.status ==
                                Status.ERROR) {
                              return Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: background,
                                child: Column(
                                  children: [
                                    Text(
                                        'detailsMatchViewModel: ${listTeamsOnStandingViewModel.teamsOnStanding.message}'),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: Lottie.asset('assets/page_loading.json',
                                    height: 150, width: 150),
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(
              child: Lottie.asset('assets/page_loading.json',
                  height: 150, width: 150),
            );
          }
        }),
      ),
    );
  }
}

class HeaderStanding extends StatelessWidget {
  const HeaderStanding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              "#",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 122,
            child: Text(
              "Team",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 20,
            child: Text(
              "M",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 20,
            child: Text(
              "W",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 20,
            child: Text(
              "D",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 20,
            child: Text(
              "L",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 40,
            child: Text(
              "G",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_400',
                color: Color(0xFF34363D),
              ),
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 25,
            child: Text(
              "PTS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter_700',
                color: Color(0xFF34363D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowContentStanding extends StatelessWidget {
  final int position;
  final String shortName;
  final int matches;
  final int wins;
  final int draws;
  final int losses;
  final int scoresFor;
  final int scoresAgainst;
  final int points;
  final String teamLogo;
  final int promotionId;

  const RowContentStanding(
      {super.key,
      required this.position,
      required this.shortName,
      required this.matches,
      required this.wins,
      required this.draws,
      required this.losses,
      required this.scoresFor,
      required this.scoresAgainst,
      required this.points,
      required this.teamLogo,
      required this.promotionId});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 36,
        width: 4,
        color: mockPromotionStatus
            .firstWhere((element) => element.id == promotionId,
                orElse: () => PromotionStatusModel())
            .color, // background color
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Text(
                position.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                AppNetworkImage(url: teamLogo, size: 20),
                const SizedBox(width: 8),
                SizedBox(
                  width: 94,
                  child: Text(
                    shortName,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Inter_400',
                      color: Color(0xFF34363D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 20,
              child: Text(
                matches.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 20,
              child: Text(
                wins.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 20,
              child: Text(
                draws.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 20,
              child: Text(
                losses.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 40,
              child: Text(
                "$scoresFor:$scoresAgainst",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_400',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 25,
              child: Text(
                points.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Inter_700',
                  color: Color(0xFF34363D),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
