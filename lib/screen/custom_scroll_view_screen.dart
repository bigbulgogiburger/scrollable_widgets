import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        renderSliverAppBar(),
        renderSliverGridBuilder(),
      ],
    ));
  }


  SliverAppBar renderSliverAppBar(){
    return SliverAppBar(
      // 스크롤 했을 때에 리스트의 중간에도 Appbar가 내려오게 할 수 있음
      floating: true,
      // 앱바 고정.
      pinned: false,
      // snap 자석처럼 살짝만 움직여도 앱바가 날아가거나 생김(끝과 끝만 존재),
      // floating이 true인 경우에만 쓸 수 있음.
      snap: false,
      // android에서는 기본적으로 되는기능(physics bouncing으로 바꾸면됨). ios인 경우 앱바를 스크롤 했을 때에 따라옴.
      stretch: true,
      //최대 사이즈
      expandedHeight: 200,
      // 최소 사이즈
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpace',style: TextStyle(
          color: Colors.black
        ),),
      ),
      title: Text("CustomScrollViewScreen"),
    );
  }
  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    if (index != null) {
      print(index);
    }
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  //ListView 기본 생성자와 유사함.
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
    );
  }

  //ListView.builder 생성자와 유사함
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  //GridView.coun와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
  // GridView.builder와 유사함
  SliverGrid renderSliverGridBuilder(){
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index);
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }
}
