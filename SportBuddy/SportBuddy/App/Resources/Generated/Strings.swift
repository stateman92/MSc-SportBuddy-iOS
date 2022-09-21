// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Add {
    public enum New {
      public enum Chat {
        /// Add new chat
        public static let title = L10n.tr("Localizable", "add_new_chat_title")
      }
    }
  }

  public enum Chat {
    /// Copy
    public static let copy = L10n.tr("Localizable", "chat_copy")
    /// Delete
    public static let delete = L10n.tr("Localizable", "chat_delete")
    /// Send
    public static let send = L10n.tr("Localizable", "chat_send")
    /// Share
    public static let share = L10n.tr("Localizable", "chat_share")
    public enum Copy {
      /// Message copied!
      public static let success = L10n.tr("Localizable", "chat_copy_success")
    }
    public enum Share {
      /// Message cannot be shared! Error: %@
      public static func error(_ p1: Any) -> String {
        return L10n.tr("Localizable", "chat_share_error", String(describing: p1))
      }
      /// Message shared!
      public static let success = L10n.tr("Localizable", "chat_share_success")
    }
    public enum Types {
      /// Existing chat!
      public static let existing = L10n.tr("Localizable", "chat_types_existing")
      /// New chat!
      public static let new = L10n.tr("Localizable", "chat_types_new")
    }
  }

  public enum Chats {
    /// Chats
    public static let title = L10n.tr("Localizable", "chats_title")
  }

  public enum General {
    public enum Connectivity {
      /// Internet is available!
      public static let internet = L10n.tr("Localizable", "general_connectivity_internet")
      public enum No {
        /// Internet connection is lost!
        public static let internet = L10n.tr("Localizable", "general_connectivity_no_internet")
      }
    }
    public enum Session {
      /// Your session has expired. Login again to continue.
      public static let expired = L10n.tr("Localizable", "general_session_expired")
    }
  }

  public enum Live {
    public enum Feed {
      /// Copy
      public static let copy = L10n.tr("Localizable", "live_feed_copy")
      /// Send
      public static let send = L10n.tr("Localizable", "live_feed_send")
      /// Share
      public static let share = L10n.tr("Localizable", "live_feed_share")
      /// LiveFeed
      public static let title = L10n.tr("Localizable", "live_feed_title")
      public enum Copy {
        /// Message copied!
        public static let success = L10n.tr("Localizable", "live_feed_copy_success")
      }
      public enum Share {
        /// Message cannot be shared! Error: %@
        public static func error(_ p1: Any) -> String {
          return L10n.tr("Localizable", "live_feed_share_error", String(describing: p1))
        }
        /// Message shared!
        public static let success = L10n.tr("Localizable", "live_feed_share_success")
      }
      public enum Title {
        public enum First {
          /// Welcome! 👋
          public static let line = L10n.tr("Localizable", "live_feed_title_first_line")
        }
        public enum Second {
          /// Type something to discuss... ✍️
          public static let line = L10n.tr("Localizable", "live_feed_title_second_line")
        }
      }
    }
  }

  public enum Login {
    /// Login
    public static let login = L10n.tr("Localizable", "login_login")
    public enum Email {
      /// Type your email...
      public static let placeholder = L10n.tr("Localizable", "login_email_placeholder")
    }
    public enum Forgot {
      /// Forgot password
      public static let password = L10n.tr("Localizable", "login_forgot_password")
      public enum Password {
        /// Forgot password request failed! Try again later.
        public static let error = L10n.tr("Localizable", "login_forgot_password_error")
        /// You've requested a password reset email successfully!
        public static let success = L10n.tr("Localizable", "login_forgot_password_success")
      }
    }
    public enum Login {
      /// Login failed! Try again later.
      public static let error = L10n.tr("Localizable", "login_login_error")
      /// You've logged in successfully!
      public static let success = L10n.tr("Localizable", "login_login_success")
    }
    public enum Name {
      /// Type your name...
      public static let placeholder = L10n.tr("Localizable", "login_name_placeholder")
    }
    public enum Password {
      /// Type your password...
      public static let placeholder = L10n.tr("Localizable", "login_password_placeholder")
    }
    public enum Segmented {
      public enum Control {
        /// Login
        public static let login = L10n.tr("Localizable", "login_segmented_control_login")
        public enum Sign {
          /// Sign up
          public static let up = L10n.tr("Localizable", "login_segmented_control_sign_up")
        }
      }
    }
    public enum Sign {
      /// Registration
      public static let up = L10n.tr("Localizable", "login_sign_up")
      public enum Up {
        /// Registration failed! Try again later.
        public static let error = L10n.tr("Localizable", "login_sign_up_error")
        /// You've signed up successfully!
        public static let success = L10n.tr("Localizable", "login_sign_up_success")
      }
    }
  }

  public enum Onboarding {
    /// Continue
    public static let `continue` = L10n.tr("Localizable", "onboarding_continue")
    /// Skip
    public static let skip = L10n.tr("Localizable", "onboarding_skip")
    /// Subtitle
    public static let subtitle = L10n.tr("Localizable", "onboarding_subtitle")
    /// Title
    public static let title = L10n.tr("Localizable", "onboarding_title")
    public enum Get {
      /// Get started
      public static let started = L10n.tr("Localizable", "onboarding_get_started")
    }
  }

  public enum Settings {
    /// Battery saving
    public static let battery = L10n.tr("Localizable", "settings_battery")
    /// Close
    public static let close = L10n.tr("Localizable", "settings_close")
    /// Choose image
    public static let image = L10n.tr("Localizable", "settings_image")
    /// Logout
    public static let logout = L10n.tr("Localizable", "settings_logout")
    /// Settings
    public static let title = L10n.tr("Localizable", "settings_title")
    public enum Battery {
      /// With this you can control whether to use WebSocket or not
      public static let description = L10n.tr("Localizable", "settings_battery_description")
    }
  }

  public enum Trainings {
    /// Trainings
    public static let title = L10n.tr("Localizable", "trainings_title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
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
