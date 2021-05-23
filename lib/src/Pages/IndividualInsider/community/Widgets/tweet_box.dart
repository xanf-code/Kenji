import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:tothemoon/src/Models/community_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';
import 'preview_box.dart';

class TweetBox extends StatelessWidget {
  const TweetBox({
    Key key,
    @required this.community,
  }) : super(key: key);

  final Messages community;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        top: 12,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    backgroundImage: ExtendedNetworkImageProvider(
                      community.user.avatarUrl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            community.user.name,
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          if (community.user.official == true)
                            ExtendedImage.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Google_Verified_Badge.svg/836px-Google_Verified_Badge.svg.png",
                              height: 15,
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        tago.format(
                          DateTime.parse(community.createdAt),
                        ),
                        style: GoogleFonts.dmSans(
                          color: Colors.white54,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SmartText(
            text: parse(community.body).documentElement.text,
            onOpen: (url) {
              HapticFeedback.mediumImpact();
              launch(url);
            },
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            linkStyle: GoogleFonts.dmSans(
              color: const Color(0xff3979d7),
              fontWeight: FontWeight.w100,
            ),
            tagStyle: GoogleFonts.dmSans(
              color: const Color(0xff3979d7),
              fontWeight: FontWeight.w100,
            ),
            dollarStyle: GoogleFonts.dmSans(
              color: Colors.blue,
              fontWeight: FontWeight.w100,
            ),
          ),
          if (community.links == null)
            const SizedBox.shrink()
          else
            community.links[0].image == null
                ? const SizedBox.shrink()
                : LinkPreviewBox(community: community),
        ],
      ),
    );
  }
}
