import "package:falatu_mobile/app/ui/components/resources_config_card.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/round_background_container.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/material.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final containerHeight = MediaQuery.of(context).size.height * 0.4;
    return FalaTuScaffold(
      body: Stack(
        children: [
          RoundBackgroundContainer(
            child: FalatuImage.asset(
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
                    child: FalaTuButton(
                      label: context.i18n.continueLabel,
                      onTap: () {},
                    ),
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
