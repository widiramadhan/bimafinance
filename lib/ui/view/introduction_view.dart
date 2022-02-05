import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/index_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro', true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => IndexView()),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Pengajuan Kredit",
          body:
          "Ajukan kredit anda, dan nikmati layanan Bima Finance untuk segala kebutuhan anda.",
          image: _buildImage('intro_one.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kredit Instan",
          body:
          "Cara pintar dan pasti untuk pengajuan kredit berbagai produk di Bima Finance.",
          image: _buildImage('intro_two.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Simulasi Kredit",
          body:
          "Rencanakan kebutuhan kredit atau pinjaman sesuai dengan kebutuhan anda.",
          image: _buildImage('intro_three.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Lewati', style: TextStyle(color: colorPrimary),),
      next: const Icon(Icons.arrow_forward, color: colorPrimary),
      done: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.w600, color: colorPrimary)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: EdgeInsets.all(12.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: colorPrimary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}