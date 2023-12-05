import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/view_model/HomeViewModel.dart';
import 'package:huit_score/view_model/ListImageUrlViewModel.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/ImageResModel.dart';
import '../../model/MatchScheduleModel.dart';
import '../../theme/colors.dart';
import 'MatchItem.dart';

class ContainerByLeague extends StatelessWidget {
  final List<MatchScheduleModel> list;
  final ListImageUrlViewModel listImageUrlViewModel;

  const ContainerByLeague(
      {super.key, required this.list, required this.listImageUrlViewModel});

  @override
  Widget build(BuildContext context) {
    String? resStringFound = mockImageResData
        .firstWhere((model) => model.id == list[0].tournament?.tournamentId)
        .resString;
    return Card(
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset(
                    resStringFound ?? 'assets/solid_white.png',
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[0].tournament?.tournamentName ?? 'N/a',
                        style: const TextStyle(
                          fontSize: 12,
                          color: onSurfaceBlack12,
                          fontFamily: 'Inter_700',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        list[0].tournament?.category?.name ?? 'N/a',
                        style: const TextStyle(
                          fontSize: 12,
                          color: onSurfaceBlack12,
                          fontFamily: 'Inter_700',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return MatchItem(
                      model: list[index],
                      homeTeamImageUrl: "",
                      awayTeamImageUrl: "");
                }),
          ],
        ));
  }
}
