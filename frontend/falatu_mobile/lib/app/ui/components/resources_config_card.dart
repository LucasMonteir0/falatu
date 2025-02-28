import "package:falatu_mobile/commons/ui/components/falatu_card.dart";
import "package:falatu_mobile/commons/ui/components/falatu_dropdown.dart";
import "package:falatu_mobile/commons/ui/components/falatu_switch.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/theme_mode_extensions.dart";
import "package:falatu_mobile/commons/utils/resources/resources_manager.dart";
import "package:flutter/material.dart";

class ResourcesConfigCard extends StatelessWidget {
  const ResourcesConfigCard({super.key});

  List<FalaTuDropdownItem<LocalesEnum>> _localeItems(BuildContext context) =>
      LocalesEnum.values
          .map((e) =>
              FalaTuDropdownItem(value: e, text: e.getTranslate(context)))
          .toList();

  List<SwitchItem<ThemeMode>> _themeItems() {
    return [
      SwitchItem(ThemeMode.light, ThemeMode.light.getIcon()),
      SwitchItem(ThemeMode.dark, ThemeMode.dark.getIcon()),
      SwitchItem(ThemeMode.system, ThemeMode.system.getIcon()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FalaTuCard(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<Resources>(
        valueListenable: ResourcesManager.i.resourcesNotifier,
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Expanded(child: Text(context.i18n.darkTheme)),
                    FalaTuSwitch<ThemeMode>(
                      initialValue: value.themeMode,
                      items: _themeItems(),
                      onChanged: (item) =>
                          ResourcesManager.i.setThemeMode(item),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: colors.onSurface.withValues(alpha: 0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Text(context.i18n.selectLanguage)),
                    Container(
                      width: 150,
                      margin: const EdgeInsets.only(left: 8),
                      child: FalatuDropdown<LocalesEnum>(
                          items: _localeItems(context),
                          value: value.locale,
                          onChanged: ResourcesManager.i.selectLocale),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
