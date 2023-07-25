import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Application/downloads/downloads_bloc.dart';
import 'package:netflix/Presentation/widgets/app_bar_widget.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final _widgetList = [
    const _SmartDownloads(),
    const Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: "Downloads",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 22,
                ),
            itemCount: _widgetList.length),
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    BlocProvider.of<DownloadsBloc>(context)
        .add(const DownloadsEvent.getDownloadsImages());

    // BlocProvider.of<DownloadsBloc>(context)
    //     .add(const DownloadsEvent.getDownloadsImages());

    return Column(children: [
      const Text(
        "Introducing Downloads for You",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      constHeight,
      const Text(
        "We'll download a personalised selection of\n movies and shows for you, so there's\n always something to watch on your\n device",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      BlocBuilder<DownloadsBloc, DownloadsState>(builder: (context, state) {
        return SizedBox(
          width: size.width,
          height: size.width,
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: size.width * 1 / 3,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    downloadsImageWidget(
                      imageUrl: '$imageBaseUrl${state.downloads[2].posterPath}',
                      margin: const EdgeInsets.only(left: 170, bottom: 10),
                      angle: 15,
                      height: size.width * 1 / 2,
                    ),
                    downloadsImageWidget(
                      imageUrl: '$imageBaseUrl${state.downloads[1].posterPath}',
                      margin: const EdgeInsets.only(right: 170, bottom: 10),
                      angle: -15,
                      height: size.width * 1 / 2,
                    ),
                    downloadsImageWidget(
                      imageUrl: '$imageBaseUrl${state.downloads[0].posterPath}',
                      margin: const EdgeInsets.only(left: 0, top: 10),
                      height: size.width,
                    )
                  ],
                ),
        );
      }),
    ]);
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {},
            color: buttomBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                'Set Up',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        constHeight,
        MaterialButton(
          onPressed: () {},
          color: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See What You Can Download',
              style: TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        constWidth,
        Icon(
          Icons.settings,
          color: whiteColor,
        ),
        constWidth,
        Text(
          "Smart Downloads",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class downloadsImageWidget extends StatelessWidget {
  const downloadsImageWidget(
      {Key? key,
      required this.imageUrl,
      this.angle = 0,
      required this.margin,
      required this.height})
      : super(key: key);

  final String imageUrl;
  final double angle;
  final EdgeInsets margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width * 0.36,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: imageUrl == null
              ? null
              : DecorationImage(
                  image: NetworkImage(imageUrl),
                ),
        ),
      ),
    );
  }
}
