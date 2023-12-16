import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/data/local/mock/ImageResModel.dart';
import 'package:huit_score/res/extensions/NavigatorExtension.dart';
import 'package:huit_score/theme/colors.dart';
import 'package:huit_score/view/screens/explore/matches/MatchesAllScreen.dart';

import '../../../utils/Utils.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ImageResModel> imageRes = mockImageResData;
    return Container(
      alignment: AlignmentDirectional.topStart,
      height: double.infinity,
      width: double.infinity,
      color: background,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Top Leagues",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF212121),
                  fontFamily: 'Inter_700',
                )),
            const SizedBox(height: 28),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 28.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushReplacementWithSlideTransition(
                        MatchesAllScreen(
                            tournamentId: imageRes[index].id ?? -1,
                            seasonId: imageRes[index].seasonId ?? -1),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: surface,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            imageRes[index].resString ??
                                'assets/solid_white.png',
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: imageRes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
