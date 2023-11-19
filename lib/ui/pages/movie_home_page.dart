part of 'pages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int _index = 1;
  final List<String> _genre = [
    'Drama',
    'Thriller',
    'Comedy',
    'Fantasy',
    'Romance',
    'Sci-fi',
    'Adventure',
    'Sports',
    'Action',
    'Western',
    'Horror',
    'Musical'
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height - 130;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const HomeAppbarTitle(),
        backgroundColor: const Color(0xFFFFDF00),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.only(top: 25, bottom: 5),
            child: const HomeTitle(
              text: "Now Playing",
              size: 16.0,
            ),
          ),
          FutureBuilder(
            future: Api.futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Data is still loading
                return Container(
                  margin: EdgeInsets.only(left: width / 3, right: width / 3),
                  child: const CircularProgressIndicator(
                    color: Color(0xFFFFDF00),
                  ),
                );
              } else if (snapshot.hasError) {
                // Error occurred
                debugPrint("API failed: ${snapshot.error}");
                return Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Failed to load data. Please try again later.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                // No data available
                return Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'No movies available.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              } else {
                // Data is available
                List<Film> films = snapshot.data as List<Film>;
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: width,
                  height: height * 2 / 8,
                  color: Colors.transparent,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: films.length,
                    itemBuilder: (BuildContext context, int index) {
                      Film film = films[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return MovieDetailPage(
                                film: film,
                              );
                            },
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(left: 12.5, right: 12.5),
                          width: (height * 2 / 8 - 45) / 1.1,
                          height: height * 2 / 8 - 45,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: NetworkImage(film.thumbnailUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          Container(
            width: width,
            margin: const EdgeInsets.only(top: 25, bottom: 5),
            child: const HomeTitle(
              text: "Movie Category",
              size: 16.0,
            ),
          ),
          Container(
            width: width,
            height: height * 3 / 8,
            color: Colors.transparent,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
                crossAxisCount: 2,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: (height * 3 / 16 - 20) / 1.4,
                      height: height * 3 / 16 - 20,
                      margin: const EdgeInsets.only(top: 5, left: 5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFDF00),
                          border: Border.all(color: Colors.white, width: 1)),
                    ),
                    AnimatedContainer(
                      width: (height * 3 / 16 - 20) / 1.4,
                      height: height * 3 / 16 - 20,
                      duration: const Duration(milliseconds: 750),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Material(
                        color: const Color(0xFF393E46),
                        child: InkWell(
                          onTap: () {},
                          splashColor: const Color(0xFFDAA520),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.heart_broken_outlined,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  _genre[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Raleway",
                                      fontSize: 10,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            width: width,
            margin: const EdgeInsets.only(top: 25, bottom: 5),
            child: const HomeTitle(
              text: "Coming Soon",
              size: 16.0,
            ),
          ),
          Container(
            width: width,
            height: height * 3 / 8,
            color: Colors.transparent,
            child: FutureBuilder<List<Film>>(
              future: Api.futureDataSoon,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While data is being fetched, show a loading indicator
                  return Container(
                    margin: EdgeInsets.only(left: width / 3, right: width / 3),
                    child: const CircularProgressIndicator(
                      color: Color(0xFFFFDF00),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // If there is an error, display an error message
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is successfully fetched, build the UI with the film information
                  List<Film> films = snapshot.data ?? [];

                  return RawScrollbar(
                    controller: _scrollController,
                    thumbColor: const Color(0xFFFFDF00),
                    thumbVisibility: true,
                    trackVisibility: false,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: films.length,
                      itemBuilder: (BuildContext context, int index) {
                        Film film = films[index];
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 10, 5, 25),
                          width: width * 6 / 8,
                          height: height * 3 / 8 - 35,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: NetworkImage(film.backdropUrl ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 6 / 8,
                                height: (height * 3 / 8 - 35) * 6 / 8,
                              ),
                              Container(
                                width: width * 6 / 8,
                                height: (height * 3 / 8 - 35) * 2 / 8,
                                padding: EdgeInsets.all(
                                    ((height * 2 / 8) * 2 / 8) / 4),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  color: Color(0xFFFFDF00),
                                ),
                                child: Text(
                                  film.title ?? '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            width: width,
            height: width * 9 / 16,
            color: Colors.transparent,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  width: width,
                  height: width * 9 / 16,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/picture$index.png.jpg"),
                          fit: BoxFit.cover)),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(index: _index),
    );
  }
}
