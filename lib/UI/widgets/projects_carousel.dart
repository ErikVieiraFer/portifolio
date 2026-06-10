import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/UI/widgets/holographic_card.dart';
import 'package:portfolio_flutter/core/constants/projects_list.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class ProjectsCarousel extends StatefulWidget {
  const ProjectsCarousel({super.key});

  @override
  State<ProjectsCarousel> createState() => _ProjectsCarouselState();
}

class _ProjectsCarouselState extends State<ProjectsCarousel> {
  int _currentIndex = 0;
  double _currentScrollValue = 0.0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.currentTheme.colors;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      children: [
        Container(
          height: 700,
          margin: const EdgeInsets.symmetric(vertical: 40),
          clipBehavior: Clip.none,
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: projectsList.length,
            itemBuilder: (context, index, realIndex) {
              final project = projectsList[index];
              final isCenter = _currentIndex == index;

              final double rotationY = (index - _currentScrollValue).abs() > 0.5 ? (index - _currentScrollValue) * -0.2 : 0;

              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationY.clamp(-0.3, 0.3));

              return OverflowBox(
                maxWidth: 350,
                maxHeight: 700,
                child: Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child: HolographicCard(
                    project: project,
                    isCenter: isCenter,
                    onTap: isCenter ? null : () {
                      _carouselController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 650,
              viewportFraction: isMobile ? 0.85 : 0.35,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              clipBehavior: Clip.none,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onScrolled: (value) {
                if (value != null) {
                  setState(() {
                    _currentScrollValue = value;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: colors.primary),
              onPressed: () => _carouselController.previousPage(),
            ),
            ...List.generate(projectsList.length, (index) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? colors.primary : colors.secondary.withValues(alpha: 0.5),
                  ),
                ),
              );
            }),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: colors.primary),
              onPressed: () => _carouselController.nextPage(),
            ),
          ],
        ),
      ],
    );
  }
}
