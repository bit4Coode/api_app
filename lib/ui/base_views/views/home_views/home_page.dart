import 'package:api_app/ui/base_views/models/model.dart';
import 'package:api_app/ui/base_views/vm/app_provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../constant/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchDataModel model = FetchDataModel(data: []);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var p = Provider.of<AppProvider>(context, listen: false);
    try {
      //if (p.fetchDataModel.info?.previousPage != null) {
      await p.getData("https://api.disneyapi.dev/character", false);
      //}
      _refreshController.refreshCompleted();

      setState(() {});
    } catch (e) {
      _refreshController.refreshCompleted();
      setState(() {});
    }
  }

  void _onLoading() async {
    var p = Provider.of<AppProvider>(context, listen: false);
    try {
      if (p.fetchDataModel.info?.nextPage != null) {
        await p.getData(p.fetchDataModel.info!.nextPage!, false);
      } else {
        Fluttertoast.showToast(msg: "Has No More Data");
      }
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    } catch (e) {
      _refreshController.loadComplete();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appPro, _) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.cyan,
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.8,
                width: Get.width,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const MaterialClassicHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.list,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            const Text(
                              "End of search",
                            ),
                          ],
                        );
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return SizedBox(
                        height: Get.height * 0.4,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                          vertical: Get.height * 0.02),
                      itemCount: appPro.fetchDataModel.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        ItemData fetchData = appPro.fetchDataModel.data![index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: Get.height * 0.005),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02,
                              vertical: Get.height * 0.02),
                          height: Get.height * 0.13,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: CircularProfileAvatar(
                                  "",
                                  radius: 35,
                                  child: Image.network(
                                    "${fetchData.imageUrl}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              w3(),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${fetchData.name}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.height * 0.022,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    h1(),
                                    Text(
                                      "${fetchData.updatedAt}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.height * 0.016,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ));
    });
  }
}
