import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/create_chat/create_chat_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/create_chat/create_chat_events.dart";
import "package:falatu_mobile/chat/ui/components/non_friends_tile.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/ui/blocs/get_non_friends_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class NonFriendsPage extends StatefulWidget {
  const NonFriendsPage({super.key});

  @override
  State<NonFriendsPage> createState() => _NonFriendsPageState();
}

class _NonFriendsPageState extends State<NonFriendsPage> {
  late final GetNonFriendsBloc _bloc;
  late final CreateChatBloc _createChatBloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetNonFriendsBloc>();
    _createChatBloc = Modular.get<CreateChatBloc>();

    _bloc.call();
  }

  int _createIndex = -1;

  void Function()? _handleCreate(int index, BaseState state, String userId) {
    return state is LoadingState
        ? null
        : () {
      final myId = Modular.get<SharedPreferencesService>().getUserId();
      _createIndex = index;
      _createChatBloc.add(Create(
        type: ChatType.private,
        usersIds: [myId!, userId],
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme
        .of(context)
        .colorScheme;
    return FalaTuScaffold(
      backgroundColor: colors.surface,
      title: context.i18n.nonFriendsPageTitle,
      body: BlocBuilder<GetNonFriendsBloc, BaseState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const _Loading();
            } else if (state is SuccessState<List<UserEntity>>) {
              if (state.data.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Ainda não existem amigos para chamar. Espere um pouco :).",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return BlocConsumer<CreateChatBloc, BaseState>(
                bloc: _createChatBloc,
                listener: (context, state) {
                  if (state is SuccessState<ChatEntity>) {
                    _createIndex = -1;
                    Modular.to.pushReplacementNamed(
                        Routes.chats + Routes.privateChat,
                        arguments: state.data);
                  }
                },
                builder: (context, createState) {
                  return ListView.separated(
                    itemCount: state.data.length,
                    separatorBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            height: 4,
                            thickness: 1,
                            color: colors.onSurface.withValues(alpha: 0.2),
                          ),
                        ),
                    itemBuilder: (context, index) {
                      final user = state.data[index];
                      return NonFriendsTile(
                        user: user,
                        onTap: _handleCreate(index, createState, user.id),
                        isButtonLoading: _createIndex == index &&
                            createState is LoadingState,
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox();
          }),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: List.generate(
              10,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 16, bottom: 16),
                    child: Row(
                      children: [
                        const FalaTuShimmer.circle(size: 60),
                        8.pw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FalaTuShimmer.customBorder(
                                border: BorderRadius.circular(100),
                                height: 20,
                              ),
                              12.ph,
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 130),
                                child: FalaTuShimmer.customBorder(
                                  border: BorderRadius.circular(100),
                                  height: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
        ));
  }
}
