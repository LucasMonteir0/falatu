import "package:falatu_mobile/commons/ui/components/falatu_card.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/resources/resources_manager.dart";
import "package:flutter/material.dart";

class ResourcesConfigCard extends StatelessWidget {
  const ResourcesConfigCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FalaTuCard(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<Resources>(
        valueListenable: ResourcesManager.i.resourcesNotifier,
        builder: (context, value, child) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(context.i18n.darkTheme)),
                  Checkbox(
                    value: value.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value != null) {
                        ResourcesManager.i.toggleTheme(value);
                      }
                    },
                  ),
                ],
              ),
              Divider(
                height: 4,
                color: colors.onSurface.withValues(alpha: 0.4),
              ),
              Row(
                children: [
                  Expanded(child: Text(context.i18n.selectLanguage)),
                  DropdownButton(
                    items: LocalesEnum.values
                        .map(
                          (e) => DropdownMenuItem(
                              value: e, child: Text(e.getTranslate(context))),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ResourcesManager.i.selectLocale(value);
                      }
                    },
                    value: value.locale,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
