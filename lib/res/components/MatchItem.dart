import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huit_score/model/foot/MatchScheduleModel.dart';
import 'package:huit_score/res/enums/AppEnums.dart';
import 'package:huit_score/res/extensions/NavigatorExtension.dart';
import 'package:huit_score/res/extensions/PrimitiveDTExtension.dart';
import 'package:intl/intl.dart';

import '../../theme/colors.dart';
import '../../view/screens/details/InformationMatchScreen.dart';
import 'NetworkImage.dart';

class MatchItem extends StatelessWidget {
  final MatchScheduleModel model;
  final String homeTeamImageUrl;
  final String awayTeamImageUrl;

  const MatchItem({
    super.key,
    required this.model,
    required this.homeTeamImageUrl,
    required this.awayTeamImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        context.pushReplacementWithSlideTransition(
          InformationMatchScreen(matchId: model.id ?? -1),
        )
      },
      child: Container(
        color: surface,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppNetworkImage(url: homeTeamImageUrl, size: 17),
                      const SizedBox(width: 12),
                      Text(
                        model.homeTeam?.shortName ?? "N/a",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter_400',
                          color: onSurfaceBlack12,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      AppNetworkImage(url: awayTeamImageUrl, size: 17),
                      const SizedBox(width: 12),
                      Text(
                        model.awayTeam?.shortName ?? "N/a",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter_400',
                          color: onSurfaceBlack12,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              if (model.statusMatch?.type == 'inprogress') ...[
                MatchInProgress(
                    homeScore: model.homeScore ?? -1,
                    awayScore: model.awayScore ?? -1,
                    startTimestamp: model.startTimestamp ?? -1,
                    matchTimestamp: model.matchTimestamp ?? -1,
                    extra: model.extra ?? 780),
              ] else if (model.statusMatch?.code == 100) ...[
                MatchFinished(
                    homeScore: model.homeScore ?? -1,
                    awayScore: model.awayScore ?? -1),
              ] else ...[
                MatchPrepared(startTimestamp: model.startTimestamp ?? -1)
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MatchInProgress extends StatelessWidget {
  final int homeScore;
  final int awayScore;
  final int startTimestamp;
  final int matchTimestamp;
  final int extra;

  const MatchInProgress(
      {super.key,
      required this.homeScore,
      required this.awayScore,
      required this.startTimestamp,
      required this.matchTimestamp,
      required this.extra});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${((matchTimestamp + extra * 2 - startTimestamp) / 60).round()}'",
          style: const TextStyle(
            fontSize: 12,
            color: onSurfaceBlue8,
            fontFamily: 'SpaceGrotesk_700',
          ),
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            Text(
              homeScore.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: onSurfaceBlue8,
                fontFamily: 'SpaceGrotesk_700',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              awayScore.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: onSurfaceBlue8,
                fontFamily: 'SpaceGrotesk_700',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MatchFinished extends StatelessWidget {
  final int homeScore;
  final int awayScore;

  const MatchFinished(
      {super.key, required this.homeScore, required this.awayScore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          homeScore.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: onSurfaceBlack10,
            fontFamily: 'SpaceGrotesk_700',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          awayScore.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: onSurfaceBlack10,
            fontFamily: 'SpaceGrotesk_700',
          ),
        ),
      ],
    );
  }
}

class MatchPrepared extends StatefulWidget {
  final int startTimestamp;

  const MatchPrepared({Key? key, required this.startTimestamp})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MatchPreparedState();
}

class _MatchPreparedState extends State<MatchPrepared> {
  String result = 'N/a';

  // @override
  // void initState() {
  //   super.initState();
  //   checkDate(widget.startTimestamp.parseToDate()).then((value) => {
  //         setState(() {
  //           result = value;
  //         })
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${DateFormat('dd/MM/yyyy').format(widget.startTimestamp.parseToDate())}\n${widget.startTimestamp.parseToDateHM()}',
          style: const TextStyle(
            fontSize: 12,
            color: onSurfaceBlack8,
            fontFamily: 'SpaceGrotesk_700',
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

Future<String> checkDate(DateTime inputDate) async {
  return await Future<String>(() {
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));

    String inputDateFormatted = DateFormat('dd/MM/yyyy').format(inputDate);
    String nowFormatted = DateFormat('dd/MM/yyyy').format(now);

    log('inputDateFormatted: $inputDateFormatted');
    log('nowFormatted: $nowFormatted');

    if (inputDateFormatted == nowFormatted) {
      return Future.value(DateStatus.TODAY.name);
    } else if (inputDate.isAfter(now)) {
      return Future.value(DateStatus.NEXT_DAY.name);
    } else {
      return Future.value(DateStatus.PAST_DAY.name);
    }
  });
}
