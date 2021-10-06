// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Text {

  internal enum Chat {
    internal enum MessageField {
      /// Type your message here...
      internal static let placeHolder = Text.tr("Localizable", "Chat.MessageField.placeHolder")
    }
  }

  internal enum Common {
    /// Применить
    internal static let apply = Text.tr("Localizable", "Common.apply")
    /// Отменить
    internal static let cancel = Text.tr("Localizable", "Common.cancel")
    /// Не удалять
    internal static let cancelRemoval = Text.tr("Localizable", "Common.cancelRemoval")
    /// Выбрать
    internal static let choose = Text.tr("Localizable", "Common.choose")
    /// Закрыть
    internal static let close = Text.tr("Localizable", "Common.close")
    /// Да, удалить
    internal static let confirmRemoval = Text.tr("Localizable", "Common.confirmRemoval")
    /// Готово
    internal static let done = Text.tr("Localizable", "Common.done")
    /// Править
    internal static let edit = Text.tr("Localizable", "Common.edit")
    /// Ошибка
    internal static let error = Text.tr("Localizable", "Common.error")
    /// Найти
    internal static let find = Text.tr("Localizable", "Common.find")
    /// Загрузка, спасибо\nза ожидание
    internal static let loadingTitle = Text.tr("Localizable", "Common.loadingTitle")
    /// Выйти
    internal static let logout = Text.tr("Localizable", "Common.logout")
    /// Далее
    internal static let next = Text.tr("Localizable", "Common.next")
    /// Нет
    internal static let no = Text.tr("Localizable", "Common.no")
    /// Ок
    internal static let ok = Text.tr("Localizable", "Common.ok")
    /// Удалить
    internal static let remove = Text.tr("Localizable", "Common.remove")
    /// Удалить все
    internal static let removeAll = Text.tr("Localizable", "Common.removeAll")
    /// Сбросить
    internal static let reset = Text.tr("Localizable", "Common.reset")
    /// Сохранить
    internal static let save = Text.tr("Localizable", "Common.save")
    /// Обновить
    internal static let update = Text.tr("Localizable", "Common.update")
    /// Да
    internal static let yes = Text.tr("Localizable", "Common.yes")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Text {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
