import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/model/foot/TeamPlayersModel.dart';
import 'package:huit_score/res/extensions/PrimitiveDTExtension.dart';
import 'package:huit_score/view_model/ListTeamPlayersViewModel.dart';
import 'package:huit_score/view_model/TeamDetailsViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../data/response/Status.dart';
import '../../../model/foot/ImageUrlModel.dart';
import '../../../model/foot/TournamentModel.dart';
import '../../../model/foot/VenueModel.dart';
import '../../../res/components/AppTabBar.dart';
import '../../../res/components/NetworkImage.dart';
import '../../../theme/colors.dart';
import '../../../view_model/ListImageUrlViewModel.dart';

class DetailsTeamScreen extends StatefulWidget {
  final int teamId;

  const DetailsTeamScreen({Key? key, required this.teamId}) : super(key: key);

  @override
  _DetailsTeamScreenState createState() => _DetailsTeamScreenState();
}

class _DetailsTeamScreenState extends State<DetailsTeamScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int teamId;
  late TeamDetailsViewModel _teamDetailsViewModel;
  late ListTeamPlayersViewModel _listTeamPlayersViewModel;
  late ListImageUrlViewModel _listImageUrlViewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    teamId = widget.teamId;
    _teamDetailsViewModel = TeamDetailsViewModel(teamId);
    _listTeamPlayersViewModel = ListTeamPlayersViewModel(teamId);
    _listImageUrlViewModel = ListImageUrlViewModel();

    _teamDetailsViewModel.fetchTeamDetailsApi();
    _listTeamPlayersViewModel.fetchTeamPlayersApi();
    _listImageUrlViewModel.fetchImageUrls();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Overview', 'Players'];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeamDetailsViewModel>(
            create: (BuildContext context) => _teamDetailsViewModel),
        ChangeNotifierProvider<ListTeamPlayersViewModel>(
            create: (BuildContext context) => _listTeamPlayersViewModel),
        ChangeNotifierProvider<ListImageUrlViewModel>(
            create: (BuildContext context) => _listImageUrlViewModel),
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
        body: Consumer3<TeamDetailsViewModel, ListTeamPlayersViewModel,
            ListImageUrlViewModel>(
          builder: (context, teamDetailsViewModel, listTeamPlayersViewModel,
              listImageUrlViewModel, child) {
            if (teamDetailsViewModel.teamDetails.status == Status.ERROR &&
                listTeamPlayersViewModel.listTeamPlayers.status ==
                    Status.ERROR) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: background,
                child: Column(
                  children: [
                    Text(
                        'teamDetailsViewModel: ${teamDetailsViewModel.teamDetails.message}'),
                    Text(
                        'listTeamPlayersViewModel: ${listTeamPlayersViewModel.listTeamPlayers.message}'),
                  ],
                ),
              );
            } else if (teamDetailsViewModel.teamDetails.status ==
                    Status.LOADING ||
                listTeamPlayersViewModel.listTeamPlayers.status ==
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
                    HeaderOfDetailsTeamScreen(
                      teamDetailsViewModel: teamDetailsViewModel,
                      listImageUrlViewModel: listImageUrlViewModel,
                    ),
                    AppTabBar(tabController: _tabController, tabs: tabs),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          OverviewTab(
                              teamDetailsViewModel: teamDetailsViewModel,
                              listImageUrlViewModel: listImageUrlViewModel),
                          PlayersTab(
                              listTeamPlayersViewModel:
                                  listTeamPlayersViewModel,
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

class PlayersTab extends StatelessWidget {
  final ListTeamPlayersViewModel listTeamPlayersViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  const PlayersTab(
      {super.key,
      required this.listTeamPlayersViewModel,
      required this.listImageUrlViewModel});

  @override
  Widget build(BuildContext context) {
    List<TeamPlayerModel> teamPlayersList =
        listTeamPlayersViewModel.listTeamPlayers.data ?? [];

    teamPlayersList
        .sort((a, b) => (a.shirtNumber ?? 0).compareTo(b.shirtNumber ?? 0));
    teamPlayersList.removeWhere((player) => player.shirtNumber! <= 0);

    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 24),
        child: Column(
          children: teamPlayersList
              .map((player) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      color: surface,
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                      child: ListTile(
                        title: Text(
                          player.name ?? 'N/a',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter_700',
                            color: onSurfaceBlack12,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Position: ${player.position ?? 'N/a'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter_400',
                                    color: onSurfaceBlack12,
                                  ),
                                ),
                                Text(
                                  'Shirt Number: ${player.shirtNumber != null ? player.shirtNumber.toString() : 'N/a'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter_400',
                                    color: onSurfaceBlack12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Height: ${player.height ?? 'N/a'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter_400',
                                color: onSurfaceBlack12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Preferred Foot: ${player.preferredFoot ?? 'N/a'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter_400',
                                color: onSurfaceBlack12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'DOB: ${player.dateOfBirthTimestamp?.parseToDateDMY()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter_400',
                                color: onSurfaceBlack12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Contract: ${player.contractUntilTimestamp?.parseToDateDMY() ?? 'N/a'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter_400',
                                color: onSurfaceBlack12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Market Value: ${player.proposedMarketValue ?? 'N/a'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter_400',
                                color: onSurfaceBlack12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  final TeamDetailsViewModel teamDetailsViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  const OverviewTab(
      {super.key,
      required this.teamDetailsViewModel,
      required this.listImageUrlViewModel});

  @override
  Widget build(BuildContext context) {
    String gender = 'N/a';
    if ((teamDetailsViewModel.teamDetails.data?.gender ?? 'N/a') == 'M') {
      gender = 'Male';
    } else if ((teamDetailsViewModel.teamDetails.data?.gender ?? 'N/a') ==
        'F') {
      gender = 'Female';
    }
    String shortName =
        teamDetailsViewModel.teamDetails.data?.shortName ?? 'N/a';
    String managerName =
        teamDetailsViewModel.teamDetails.data?.managerName ?? 'N/a';
    String cityName =
        teamDetailsViewModel.teamDetails.data?.venue?.cityName ?? 'N/a';
    String stadiumName =
        teamDetailsViewModel.teamDetails.data?.venue?.stadiumName ?? 'N/a';
    String countryStadiumName =
        teamDetailsViewModel.teamDetails.data?.venue?.countryName ?? 'N/a';
    int capacity = teamDetailsViewModel.teamDetails.data?.venue?.capacity ?? -1;

    int foundationDateTimestamp =
        teamDetailsViewModel.teamDetails.data?.foundationDateTimestamp ?? -1;

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
                  children: [
                    const Text(
                      'TEAM INFORMATION',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter_700',
                        color: onSurfaceBlack8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RowInformation("Short Name", shortName),
                    const SizedBox(height: 8),
                    RowInformation("Manager", managerName),
                    const SizedBox(height: 8),
                    RowInformation("Football Gender", gender),
                    const SizedBox(height: 8),
                    RowInformation(
                        "Foundation", foundationDateTimestamp.parseToDateDMY()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'STADIUM',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter_700',
                        color: onSurfaceBlack8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RowInformation("Stadium Name", stadiumName),
                    const SizedBox(height: 8),
                    RowInformation("City Name", cityName),
                    const SizedBox(height: 8),
                    RowInformation("Country Name", countryStadiumName),
                    const SizedBox(height: 8),
                    RowInformation("Capacity", capacity.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RowInformation(String label, String info) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$label:',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Inter_400',
              color: onSurfaceBlack12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            info,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Inter_700',
              color: onSurfaceBlack12,
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderOfDetailsTeamScreen extends StatelessWidget {
  final TeamDetailsViewModel teamDetailsViewModel;
  final ListImageUrlViewModel listImageUrlViewModel;

  const HeaderOfDetailsTeamScreen(
      {super.key,
      required this.teamDetailsViewModel,
      required this.listImageUrlViewModel});

  @override
  Widget build(BuildContext context) {
    String teamImageUrl = listImageUrlViewModel.imageUrls
            .firstWhere(
                (item) =>
                    item.id ==
                    teamDetailsViewModel.teamDetails.data?.id.toString(),
                orElse: () => ImageUrlModel())
            .url ??
        'N/a';
    String fullTeamName =
        teamDetailsViewModel.teamDetails.data?.fullTeamName ?? 'N/a';
    'N/a';
    String countryTeamName = teamDetailsViewModel
            .teamDetails.data?.tournament?.category?.categoryName ??
        'N/a';
    return Container(
      width: double.infinity,
      color: surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AppNetworkImage(url: teamImageUrl, size: 90),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullTeamName,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter_700',
                    color: onSurfaceBlack12,
                  ),
                ),
                Text(
                  countryTeamName,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter_400',
                    color: onSurfaceBlack10,
                  ),
                ),
                // Text(
                //   'Foundation: ${foundationDateTimestamp.parseToDateDMY()}',
                //   textAlign: TextAlign.start,
                //   style: const TextStyle(
                //     fontSize: 12,
                //     fontFamily: 'Inter_400',
                //     color: onSurfaceBlack10,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
