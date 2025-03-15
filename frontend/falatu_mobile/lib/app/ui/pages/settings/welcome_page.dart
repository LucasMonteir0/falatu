import "package:falatu_mobile/app/ui/components/resources_config_card.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/round_background_container.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/resources/resources_manager.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final containerHeight = MediaQuery.of(context).size.height * 0.4;
    bool isLoading = false;
    return FalaTuScaffold(
      body: Stack(
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      height: containerHeight / 2,
                      child: Center(
                        child: Text(
                          context.i18n.welcomeText,
                          textAlign: TextAlign.center,
                          style: typography.titleMedium!.copyWith(
                            color: colors.surfaceBright,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const ResourcesConfigCard(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: ValueListenableBuilder(
                        valueListenable: ResourcesManager.i.notifier,
                        builder: (context, value, _) {
                          return FalaTuButton(
                            label: context.i18n.continueLabel,
                            onTap: () async {
                              if (isLoading) {
                                return;
                              }
                              isLoading = true;
                              final preferences =
                                  Modular.get<SharedPreferencesService>();
                              await preferences.setThemeMode(value.themeMode);
                              await preferences.setLocale(value.locale);
                              isLoading = false;
                              Modular.to.pushReplacementNamed(
                                  Routes.chats + Routes.root);
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: FalaTuIcon(icon: FalaTuIconsEnum.falatuLogomarca),
      )),
    );
  }
}
