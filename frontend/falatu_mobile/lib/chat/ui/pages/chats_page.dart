import "dart:ui";
import "package:falatu_mobile/chat/core/data/models/chat/private_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/group_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_events.dart";
import "package:falatu_mobile/chat/ui/components/chats_list_view.dart";
import "package:falatu_mobile/chat/utils/enums/chat_tabs.dart";
import "package:falatu_mobile/commons/ui/components/blur_effect.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
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

class _ChatsPageState extends State<ChatsPage> {
  late final LoadChatsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<LoadChatsBloc>();
    _bloc.add(Load());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;
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
        backgroundColor: Colors.transparent,
        actions: [
          ScaffoldAction(
              icon: FalaTuIconsEnum.settinsFilled,
              onTap: () => Modular.to.pushNamed(Routes.settings)),
        ],
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicator: const FalaTuTabIndicator(),
                  labelStyle: typography.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700, color: colors.primary),
                  unselectedLabelColor: Colors.white,
                  tabs: ChatTabs.values
                      .map((e) => Tab(text: e.getLabel(context)))
                      .toList(),
                ),
              ),
              BlocBuilder<LoadChatsBloc, BaseState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Expanded(
                    child: BlurEffect(
                      height: double.infinity,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      child: TabBarView(
                        children: [
                          ChatsListView<PrivateChatEntity>(state: state),
                          ChatsListView<GroupChatEntity>(state: state),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
