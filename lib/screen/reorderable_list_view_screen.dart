import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'reorderableListviewScreen',
      body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return renderContainer(
              color: rainbowColors[numbers[index] % rainbowColors.length],
              index: numbers[index]);
          },
          itemCount: numbers.length,
          onReorder: (oldIndex, newIndex) {
            try {
              setState(() {
                // oldIndex와 newIndex모두 이동이 되기 전에 산정한다.
                // [red,orange,yellow]
                // [0,1,2]
                // red를 yellow다음으로 옮기고 싶다.
                // red : 0 oldIndex-> 3 newIndex
                // [orange,yellow,red]
                // [red,orange,yellow]
                // yellow를 red전으로 옮기고 싶다
                // yellow : 2 oldIndex -> 0 newIndex
                // [yellow,red,orange]
                /**
                 * 왕중요 올드인덱스가 새로 옮겨질 인덱스보다 작으면, 새로운 인덱스에 1빼줘야함.
                 * 그리고 키가 반드시 있어야 함.
                 */
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }

                final item = numbers.removeAt(oldIndex);
                numbers.insert(newIndex, item);
              });
            } catch (e, s) {
              print(s);
            }
          },
      ),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList(),
      onReorder: (oldIndex, newIndex) {
        try {
          setState(() {
            // oldIndex와 newIndex모두 이동이 되기 전에 산정한다.
            // [red,orange,yellow]
            // [0,1,2]
            // red를 yellow다음으로 옮기고 싶다.
            // red : 0 oldIndex-> 3 newIndex
            // [orange,yellow,red]
            // [red,orange,yellow]
            // yellow를 red전으로 옮기고 싶다
            // yellow : 2 oldIndex -> 0 newIndex
            // [yellow,red,orange]
            /**
             * 왕중요 올드인덱스가 새로 옮겨질 인덱스보다 작으면, 새로운 인덱스에 1빼줘야함.
             * 그리고 키가 반드시 있어야 함.
             */
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        } catch (e, s) {
          print(s);
        }
      },
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
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
