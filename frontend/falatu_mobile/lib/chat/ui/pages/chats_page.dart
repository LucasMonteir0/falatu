import "package:falatu_mobile/chat/core/domain/entities/chat/group_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/chat_events.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_bloc.dart";
import "package:falatu_mobile/chat/ui/components/chats_list_view.dart";
import "package:falatu_mobile/chat/utils/enums/chat_tabs.dart";
import "package:falatu_mobile/commons/ui/blocs/get_user_bloc.dart";
import "package:falatu_mobile/commons/ui/components/blur_effect.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/ui/components/falatu_tab.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage>
    with SingleTickerProviderStateMixin {
  late final LoadChatsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<LoadChatsBloc>();

    _bloc.add(LoadChats());
    Modular.get<GetUserBloc>().call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/${FalaTuImagesEnum.background.value}",
          ),
        ),
      ),
      child: FalaTuScaffold(
        title: context.i18n.messages,
        titleColor: Colors.white,
        backgroundColor: Colors.transparent,
        floatingButton: ScaffoldAction(
          icon: FalaTuIconsEnum.chatFilled,
          onTap: () => Modular.to.pushNamed(Routes.chats + Routes.nonFriends),
        ),
        actions: [
          ScaffoldAction(
            icon: FalaTuIconsEnum.settinsFilled,
            onTap: () => Modular.to.pushNamed(Routes.settings),
          ),
        ],
        body: BlocBuilder<LoadChatsBloc, BaseState>(
            bloc: _bloc,
            builder: (context, state) {
              return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _TabBarComponent(state: state),
                    ),
                    Expanded(
                      child: BlurEffect(
                        height: double.infinity,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24)),
                        child: TabBarView(
                          children: [
                            ChatsListView<PrivateChatEntity>(state: state),
                            ChatsListView<GroupChatEntity>(state: state),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class _TabBarComponent extends StatelessWidget {
  final BaseState state;

  const _TabBarComponent({required this.state});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    if (state is LoadingState) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 8),
              child: FalaTuShimmer.customBorder(
                width: 80,
                height: 28,
                border: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 28,
        child: TabBar(
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          isScrollable: true,
          splashBorderRadius: BorderRadius.circular(100),
          indicator: FalaTuTabIndicator(indicatorColor: colors.surface),
          labelStyle: typography.bodyMedium!
              .copyWith(fontWeight: FontWeight.w700, color: colors.primary),
          unselectedLabelColor: Colors.white,
          tabs: ChatTabs.values
              .map((e) => Tab(text: e.getLabel(context)))
              .toList(),
        ),
      ),
    );
  }
}
