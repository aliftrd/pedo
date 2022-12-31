import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/animal_provider.dart';
import 'package:pedo/views/widgets/animal_card.dart';
import 'package:pedo/views/widgets/animal_skeleton_card.dart';
import 'package:pedo/views/widgets/errors.dart';
import 'package:provider/provider.dart';

class AnimalPage extends StatelessWidget {
  static String route = '/animals';
  const AnimalPage({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider = Provider.of<AnimalProvider>(context);

    Widget buildAnimalCard() {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: List.generate(
              animalProvider.animals.length,
              (index) => AnimalCard(
                animalId: animalProvider.animals[index].id,
                margin: index == animalProvider.animals.length - 1
                    ? EdgeInsets.only(bottom: defaultMargin)
                    : null,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => animalProvider.getAnimals(isRefresh: true),
          child: CustomScrollView(
            controller: animalProvider.onScrollEvent(),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                backgroundColor: background,
                elevation: 0,
                title: Text(
                  'Hewan',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: IconButton(
                    onPressed: () {
                      animalProvider.getAnimals();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: colorDark,
                    ),
                  ),
                ),
              ),
              animalProvider.isLoading
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: List.generate(
                            3,
                            (index) => AnimalSkeletonCard(
                              margin: index.bitLength == 2
                                  ? EdgeInsets.only(bottom: defaultMargin)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    )
                  : animalProvider.animals.isEmpty
                      ? SliverFillRemaining(
                          child: Errors.noDataFound(),
                        )
                      : buildAnimalCard()
            ],
          ),
        ),
      ),
    );
  }
}
