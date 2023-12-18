import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huit_score/model/foot/MatchScheduleModel.dart';
import 'package:huit_score/res/extensions/NavigatorExtension.dart';

import '../../theme/colors.dart';
import '../../view/screens/details/InformationMatchScreen.dart';
import 'NetworkImage.dart';

class LiveMatchItem extends StatelessWidget {
  final MatchScheduleModel model;
  final String homeTeamImageUrl;
  final String awayTeamImageUrl;
  final String resStringFound;

  const LiveMatchItem({
    super.key,
    required this.model,
    required this.homeTeamImageUrl,
    required this.awayTeamImageUrl,
    required this.resStringFound,
  });

  @override
  Widget build(BuildContext context) {
    // (((model.matchTimestamp ?? 0) + ((model.extra ?? 0) * 2)) - (model.matchTimestamp ?? 0))/60
    String matchTime = ((((model.matchTimestamp ?? 0).toDouble() +
                    ((model.extra ?? 0).toDouble() * 2)) -
                (model.startTimestamp ?? 0).toDouble()) /
            60)
        .round()
        .toString();
    return GestureDetector(
      onTap: () => {
        context.pushReplacementWithSlideTransition(
          InformationMatchScreen(matchId: model.id ?? -1),
        )
      },
      child: SizedBox(
        width: 274,
        child: Card(
          color: surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset(
                      resStringFound,
                      height: 35,
                      width: 35,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/solid_white.png',
                            height: 35, width: 35);
                      },
                    ),
                    const Spacer(),
                    Text(
                      "$matchTime’",
                      style: const TextStyle(
                        fontSize: 14,
                        color: onSurfaceBlue8,
                        fontFamily: 'SpaceGrotesk_700',
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          AppNetworkImage(url: homeTeamImageUrl, size: 36),
                          const SizedBox(width: 8),
                          Text(
                            model.homeTeam?.shortName ?? 'N/a',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Inter_400',
                              color: onSurfaceBlack12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${model.homeScore} - ${model.awayScore}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'SpaceGrotesk_700',
                            color: onSurfaceBlue8,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 88,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          AppNetworkImage(url: awayTeamImageUrl, size: 36),
                          const SizedBox(width: 8),
                          Text(
                            model.awayTeam?.shortName ?? 'N/a',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Inter_400',
                              color: onSurfaceBlack12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
