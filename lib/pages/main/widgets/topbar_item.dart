import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/state/navigation_state.dart';

class TopBarItem extends ConsumerStatefulWidget {
  const TopBarItem(this.title, this.index, this.destination, {super.key});
  final String title;
  final int index;
  final PageRouteInfo? destination;

  @override
  ConsumerState<TopBarItem> createState() => _TopBarItemState();
}

class _TopBarItemState extends ConsumerState<TopBarItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ref.read(mainHomePageProvider.notifier).state = widget.index;
          AutoRouter.of(context).push(widget.destination!);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
             color:  Colors.transparent,
              border:
                  Border(bottom: BorderSide(color: ref.watch(mainHomePageProvider) == widget.index
                    ? Colors.white:Colors.transparent, width: 2))),
          child: Text(
            widget.title,
            style: TextStyle(
                fontWeight: ref.watch(mainHomePageProvider) == widget.index
                    ? FontWeight.bold
                    : FontWeight.w400,
                color: ref.watch(mainHomePageProvider) == widget.index
                    ? Colors.white
                    : Colors.white54),
          ),
        ));
  }
}
