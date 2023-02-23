import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();
  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort!.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/I1.jpg"), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${progress}',
                  style: TextStyle(fontSize: 40, color: Colors.yellowAccent),
                ),
                SizedBox(
                  height: 60,
                ),
                FloatingActionButton(
                    onPressed: () async {
                      final status = await Permission.storage.request();

                      if (status.isGranted) {
                        final externalDir = await getExternalStorageDirectory();
                        final id = await FlutterDownloader.enqueue(
                            url:
                                'https://download.samplelib.com/mp4/sample-10s.mp4',
                            savedDir: externalDir!.path,
                            fileName: "downloding file",
                            showNotification: true,
                            openFileFromNotification: true);
                      } else {
                        print('permission is denined');
                      }
                    },
                    child: Icon(Icons.download)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
