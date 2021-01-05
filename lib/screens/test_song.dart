import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumotionplayer/widgets/sized_icon_button.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_sdk/models/library_state.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:logger/logger.dart';

class TestSong extends StatefulWidget {
  @override
  _TestSongState createState() => _TestSongState();
}

class _TestSongState extends State<TestSong> {
  final Logger _logger = Logger();
  bool _loading = false;
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sampleFlowWidget(context),
    );
  }
  Widget _sampleFlowWidget(BuildContext context2) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: connectToSpotifyRemote,
                    child:Container(
                      child: Text('Remote'),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 0.0,
                            color: Theme.of(context).accentColor),
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.blue,
                  ),
                  FlatButton(
                    onPressed:disconnect,
                    child:Container(
                      child: Text('Disconnect'),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 0.0,
                            color: Theme.of(context).accentColor),
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.blue,

                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedIconButton(
                    width: 50,
                    icon: Icons.skip_previous,
                    onPressed: skipPrevious,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.play_arrow,
                    onPressed: resume,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.pause,
                    onPressed: pause,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.skip_next,
                    onPressed: skipNext,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedIconButton(
                  //   width: 50,
                  //   icon: Icons.queue_music,
                  //   onPressed: queue,
                  // ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.play_circle_filled,
                    onPressed: play,
                  ),
                  // SizedIconButton(
                  //   width: 50,
                  //   icon: Icons.repeat,
                  //   onPressed: toggleRepeat,
                  // ),
                  // SizedIconButton(
                  //   width: 50,
                  //   icon: Icons.shuffle,
                  //   onPressed: toggleShuffle,
                  // ),
                ],
              ),
              // FlatButton(
              //     child: const Icon(Icons.favorite), onPressed: addToLibrary),
              // Row(
              //   children: <Widget>[
              //     FlatButton(child: const Text('seek to'), onPressed: seekTo),
              //     FlatButton(
              //         child: const Text('seek to relative'),
              //         onPressed: seekToRelative),
              //   ],
              // ),
              // const Divider(),
              // const Text(
              //   'Crossfade State',
              //   style: TextStyle(
              //     fontSize: 16,
              //   ),
              // ),
              // FlatButton(
              //     child: const Text('getCrossfadeState'),
              //     onPressed: getCrossfadeState),
              // // ignore: prefer_single_quotes
              // Text("Is enabled: ${crossfadeState?.isEnabled}"),
              // // ignore: prefer_single_quotes
              // Text("Duration: ${crossfadeState?.duration}"),
              // const Divider(),
              // _connected
              //     ? spotifyImageWidget()
              //     : const Text('Connect to see an image...'),
              FlatButton(
                onPressed: getAlbum,
                child: Text('library'),
                color: Colors.blue,
              )
            ],
          ),
          _loading
              ? Container(
              color: Colors.black12,
              child: const Center(child: CircularProgressIndicator()))
              : const SizedBox(),
        ],
      ),
    );
  }


  void setStatus(String code, {String message = ''}) {
    var text = message.isEmpty ? '' : ' : $message';
    print('$code$text');
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId:'b03453cc8eef42e5addab055ccf37105',//b03453cc8eef42e5addab055ccf37105
          redirectUrl: 'http://com.example.mumotionplayer/callback'); //http://com.example.mumotionplayer/callback
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> disconnect() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.disconnect();
      setStatus(result ? 'disconnect successful' : 'disconnect failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:44z3FoAoo7yvn4ZIvvsQIm');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }
  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }
  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void getAlbum() async{
    final credentials = SpotifyApiCredentials('b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = SpotifyApi(credentials);
    var album = await spotify.albums.get('2G7JyChJHrZYCBb0jL2N5t');
    print(album.tracks.first.uri);
  }


}
