import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:logger/logger.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _loggedIn = false;
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xff44d0cc)),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Container(
              child: SizedBox(
                width: 180,
                child: FlatButton(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Sign In With Spotify",
                        style: TextStyle(
                          fontSize: 14.0
                        ),),
                      ),
                      Icon(Icons.music_note_outlined),
                    ],
                  ),
                  onPressed: (){
                    getAuthenticationToken();
                  },
                  color: Color(0xffe85c91),
                  textColor: Colors.white,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.0,
                          color: Theme.of(context).accentColor),
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  void setStatus(String code, {String message = ''}) {
    var text = message.isEmpty ? '' : ' : $message';
    _logger.d('$code$text');
  }
  Future<String> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: 'b03453cc8eef42e5addab055ccf37105', //DotEnv().env['CLIENT_ID'].toString()
          redirectUrl: 'http://com.example.mumotionplayer/callback', //DotEnv().env['REDIRECT_URL'].toString()
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
       setStatus('Got a token: $authenticationToken');
      Navigator.pushReplacementNamed(context, '/testSong');
      return authenticationToken;
    } on PlatformException catch (e) {
      print("platformException");
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      print("MissingPluginException");
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

}
