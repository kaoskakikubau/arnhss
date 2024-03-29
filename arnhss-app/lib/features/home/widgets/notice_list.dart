import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 180,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: context.read<HomeViewModel>().noticeList.length,
        itemBuilder: (BuildContext context, index) {
          // if (context.read<HomeViewModel>().noticeList.length != index) {
          // if (index == 0) {
          return Row(
            children: [
              const SizedBox(width: 21),
              context.read<HomeViewModel>().noticeList[index],
            ],
          );
          // } else {
          //   return context.read<HomeViewModel>().noticeList[index];
          // }
          // } else {
          //   return Row(
          //     children: [
          //       const SizedBox(width: 24),
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.arrow_forward_outlined),
          //       ),
          //       const SizedBox(width: 24),
          //     ],
          //   );
          // }
        },
      ),
    );
  }
}
