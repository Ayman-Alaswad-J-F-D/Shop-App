import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final imageUrl =
      'https://cdni.iconscout.com/illustration/premium/thumb/sign-up-page-1886582-1598253.png';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application"),
      ),
      body: Builder(
        builder: (ctx) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(offset: Offset(5, 5), blurRadius: 1.0, spreadRadius: 1.0)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.network(
                      imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                          color: Colors.redAccent,
                          textColor: Colors.white,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                          color: Colors.redAccent,
                          textColor: Colors.white,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          child: const Text(
                            'not now',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Texting3(),
                              ),
                            );
                          },
                          padding: const EdgeInsets.only(bottom: 20.0),
                          color: Colors.white,
                          textColor: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Texting3 extends StatelessWidget {
  const Texting3({Key? key}) : super(key: key);

  Widget makeItem(String url, String title) {
    return Card(
      child: Container(
        alignment: Alignment.bottomRight,
        height: 200,
        child: Text(
          title,
          style: const TextStyle(fontSize: 32, color: Colors.redAccent),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        )),
      ),
    );
  }

  final img1 =
      "http://i.huffpost.com/gen/1633005/images/o-FASHION-MODELS-facebook.jpg";
  final img2 =
      "https://picjumbo.com/wp-content/uploads/christmas-shopping-mania-free-photo-1080x720.jpg";
  final img3 =
      "https://www.bergerpaints.com/colour-magazine/Upload/Posting/Image/colours-fashion-banner-feb15.jpg";
  final img4 =
      "https://www.pixelstalk.net/wp-content/uploads/2016/06/Girl-Fashion-Dress-Red-Background-HD-Wallpaper.jpg";

  @override
  Widget build(BuildContext context) {
    var children = [
      makeItem(img1, "CASSUCCI"),
      makeItem(img2, "GAUDI"),
      makeItem(img3, "KEEP-OUT"),
      makeItem(img4, "MAJILA")
    ];
    var listView = ListView(children: children);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
            width: 300,
            height: 30,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.redAccent, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(
              Icons.search,
              color: Colors.red,
            ),
            alignment: Alignment.centerLeft,
          )),
      body: listView,
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomePageTest extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePageTest> {
//   final controller = PageController(viewportFraction: 0.8, keepPage: true);

//   @override
//   Widget build(BuildContext context) {
//     final pages = List.generate(
//         6,
//         (index) => Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.grey.shade300,
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               child: Container(
//                 height: 280,
//                 child: Center(
//                     child: Text(
//                   "Page $index",
//                   style: const TextStyle(color: Colors.indigo),
//                 )),
//               ),
//             ));
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 240,
//                 child: PageView.builder(
//                   controller: controller,
//                   // itemCount: pages.length,
//                   itemBuilder: (_, index) {
//                     return pages[index % pages.length];
//                   },
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 24, bottom: 12),
//                 child: Text(
//                   'Worm',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
              // SmoothPageIndicator(
              //   controller: controller,
              //   count: pages.length,
              //   effect: const WormEffect(
              //     dotHeight: 15,
              //     dotWidth: 25,
              //     type: WormType.thin,
              //     // strokeWidth: 50,
              //   ),
              // ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 8),
//                 child: Text(
//                   'Jumping Dot',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//               Container(
//                 child: SmoothPageIndicator(
//                   controller: controller,
//                   count: pages.length,
//                   effect: const JumpingDotEffect(
//                     dotHeight: 16,
//                     dotWidth: 16,
//                     jumpScale: .7,
//                     verticalOffset: 15,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 8),
//                 child: Text(
//                   'Swap',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//               Container(
//                 child: SmoothPageIndicator(
//                   controller: controller,
//                   count: pages.length,
//                   effect: const SwapEffect(
//                     dotHeight: 16,
//                     dotWidth: 16,
//                     type: SwapType.yRotation,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 12),
//                 child: Text(
//                   'Scrolling Dots',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//               SmoothPageIndicator(
//                   controller: controller,
//                   count: pages.length,
//                   effect: const ScrollingDotsEffect(
//                     activeStrokeWidth: 2.6,
//                     activeDotScale: 1.3,
//                     maxVisibleDots: 5,
//                     radius: 8,
//                     spacing: 10,
//                     dotHeight: 12,
//                     dotWidth: 12,
//                   )),
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 16),
//                 child: Text(
//                   'Customizable Effect',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//               Container(
//                 // color: Colors.red.withOpacity(.4),
//                 child: SmoothPageIndicator(
//                   controller: controller,
//                   count: pages.length,
//                   effect: CustomizableEffect(
//                     activeDotDecoration: DotDecoration(
//                       width: 32,
//                       height: 12,
//                       color: Colors.indigo,
//                       rotationAngle: 180,
//                       verticalOffset: -10,
//                       borderRadius: BorderRadius.circular(24),
//                       // dotBorder: DotBorder(
//                       //   padding: 2,
//                       //   width: 2,
//                       //   color: Colors.indigo,
//                       // ),
//                     ),
//                     dotDecoration: DotDecoration(
//                       width: 24,
//                       height: 12,
//                       color: Colors.grey,
//                       // dotBorder: DotBorder(
//                       //   padding: 2,
//                       //   width: 2,
//                       //   color: Colors.grey,
//                       // ),
//                       // borderRadius: BorderRadius.only(
//                       //     topLeft: Radius.circular(2),
//                       //     topRight: Radius.circular(16),
//                       //     bottomLeft: Radius.circular(16),
//                       //     bottomRight: Radius.circular(2)),
//                       borderRadius: BorderRadius.circular(16),
//                       verticalOffset: 0,
//                     ),
//                     spacing: 6.0,
//                     // activeColorOverride: (i) => colors[i],
//                     inActiveColorOverride: (i) => colors[i],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// final colors = [
//   Colors.red,
//   Colors.green,
//   Colors.greenAccent,
//   Colors.amberAccent,
//   Colors.blue,
//   Colors.amber,
// ];
