import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:flutter/material.dart";
import "package:grouped_list/grouped_list.dart";

typedef MessagesBuilder = Widget Function(
    BuildContext context, MessageEntity item, int index);

class MessagesListView extends StatefulWidget {
  final List<MessageEntity> data;
  final MessagesBuilder builder;
  final ScrollController? controller;

  const MessagesListView(
      {required this.data, required this.builder, super.key, this.controller});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView>
    with SingleTickerProviderStateMixin {

  static const Duration _duration = Duration(milliseconds: 350);
  static const Curve _curve = Curves.easeIn;

  late final AnimationController _controller = AnimationController(
    duration: _duration,
    vsync: this,
  )..forward();
  late final CurvedAnimation _animation = CurvedAnimation(parent: _controller, curve: _curve);

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GroupedListView<MessageEntity, DateTime>(
        elements: widget.data,
        reverse: true,
        controller: widget.controller,
        separator: 20.ph,
        padding: const EdgeInsets.all(8),
        groupBy: (e) =>
            DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day),
        floatingHeader: true,
        itemComparator: (e1, e2) => e1.createdAt.compareTo(e2.createdAt),
        groupComparator: (e1, e2) => e1.compareTo(e2),
        order: GroupedListOrder.DESC,
        groupHeaderBuilder: (e) => _GroupHeaderChip(message: e),
        indexedItemBuilder: widget.builder,
      ),
    );
  }
}

class _GroupHeaderChip extends StatelessWidget {
  final MessageEntity message;

  const _GroupHeaderChip({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme
        .of(context)
        .colorScheme;
    final typography = Theme
        .of(context)
        .textTheme;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          message.createdAt.formatToMessageList(context),
          textAlign: TextAlign.end,
          style: typography.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
