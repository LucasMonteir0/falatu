import "package:falatu_mobile/app/ui/components/resources_config_card.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/ui/blocs/get_user_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_card.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/ui/components/falatu_user_avatar.dart";
import "package:falatu_mobile/commons/ui/components/round_background_container.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FalaTuScaffold(
      backgroundColor: colors.surface,
      title: context.i18n.settings,
      titleColor: Colors.white,
      iconsColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(builder: (context, constraints) {
        final containerHeight = constraints.maxHeight * 0.4;
        return Stack(
          children: [
            RoundBackgroundContainer(
              child: FalaTuImage.asset(
                image: FalaTuImagesEnum.background,
                height: containerHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ProfileSection(),
                    const ResourcesConfigCard(),
                    FalaTuCard(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(top: 8),
                      child: FalaTuSplashEffect(
                        onTap: () => Modular.get<SignOutBloc>().call(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          children: [
                            Expanded(child: Text(context.i18n.signOut)),
                            FalaTuIcon(
                              icon: FalaTuIconsEnum.chevronRight,
                              color: colors.onSurface,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: BlocBuilder<GetUserBloc, BaseState>(
        bloc: Modular.get<GetUserBloc>(),
        builder: (context, state) {
          if (state is LoadingState) {
            return Column(
              children: [
                const FalaTuShimmer.circle(size: 80),
                16.ph,
                const FalaTuShimmer.rectangle(
                    width: double.infinity, height: 22),
              ],
            );
          }
          if (state is SuccessState<UserEntity>) {
            return Column(
              children: [
                FalaTuUserAvatar(size: 80, pictureUrl: state.data.pictureUrl),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    state.data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: typography.titleLarge!.copyWith(
                        color: colors.surfaceBright,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
