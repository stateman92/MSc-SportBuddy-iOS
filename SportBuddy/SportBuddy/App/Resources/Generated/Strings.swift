// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Add {
    public enum New {
      public enum Chat {
        /// Add new chat
        public static var title: String { return L10n.tr("Localizable", "add_new_chat_title", fallback: "Add new chat") }
      }
    }
  }
  public enum Chat {
    /// Copy
    public static var copy: String { return L10n.tr("Localizable", "chat_copy", fallback: "Copy") }
    /// Delete
    public static var delete: String { return L10n.tr("Localizable", "chat_delete", fallback: "Delete") }
    /// Send
    public static var send: String { return L10n.tr("Localizable", "chat_send", fallback: "Send") }
    /// Share
    public static var share: String { return L10n.tr("Localizable", "chat_share", fallback: "Share") }
    public enum Copy {
      /// Message copied!
      public static var success: String { return L10n.tr("Localizable", "chat_copy_success", fallback: "Message copied!") }
    }
    public enum Share {
      /// Message cannot be shared! Error: %@
      public static func error(_ p1: Any) -> String {
        return L10n.tr("Localizable", "chat_share_error", String(describing: p1), fallback: "Message cannot be shared! Error: %@")
      }
      /// Message shared!
      public static var success: String { return L10n.tr("Localizable", "chat_share_success", fallback: "Message shared!") }
    }
    public enum Types {
      /// Existing chat!
      public static var existing: String { return L10n.tr("Localizable", "chat_types_existing", fallback: "Existing chat!") }
      /// New chat!
      public static var new: String { return L10n.tr("Localizable", "chat_types_new", fallback: "New chat!") }
    }
  }
  public enum Chats {
    /// Chats
    public static var title: String { return L10n.tr("Localizable", "chats_title", fallback: "Chats") }
  }
  public enum Exercise {
    public enum Change {
      /// Change camera
      public static var camera: String { return L10n.tr("Localizable", "exercise_change_camera", fallback: "Change camera") }
    }
    public enum Kettlebell {
      public enum _1 {
        /// With this you can lift your kettlebells and make fun of them!
        public static var details: String { return L10n.tr("Localizable", "exercise_kettlebell_1_details", fallback: "With this you can lift your kettlebells and make fun of them!") }
        /// Kettlebell double arm snatch
        public static var name: String { return L10n.tr("Localizable", "exercise_kettlebell_1_name", fallback: "Kettlebell double arm snatch") }
        public enum Error {
          /// Put your legs wider
          public static var _1: String { return L10n.tr("Localizable", "exercise_kettlebell_1_error_1", fallback: "Put your legs wider") }
          /// Put your legs narrower
          public static var _2: String { return L10n.tr("Localizable", "exercise_kettlebell_1_error_2", fallback: "Put your legs narrower") }
        }
      }
    }
    public enum Medicine {
      public enum _1 {
        /// 
        public static var details: String { return L10n.tr("Localizable", "exercise_medicine_1_details", fallback: "") }
        /// Medicine ball alternating twist lunge
        public static var name: String { return L10n.tr("Localizable", "exercise_medicine_1_name", fallback: "Medicine ball alternating twist lunge") }
        public enum Error {
          /// Put your legs narrower
          public static var _1: String { return L10n.tr("Localizable", "exercise_medicine_1_error_1", fallback: "Put your legs narrower") }
          /// Put your legs wider
          public static var _2: String { return L10n.tr("Localizable", "exercise_medicine_1_error_2", fallback: "Put your legs wider") }
        }
      }
    }
    public enum Mountain {
      public enum _1 {
        /// 
        public static var details: String { return L10n.tr("Localizable", "exercise_mountain_1_details", fallback: "") }
        /// Mountain climb
        public static var name: String { return L10n.tr("Localizable", "exercise_mountain_1_name", fallback: "Mountain climb") }
        public enum Error {
          /// Put your legs wider
          public static var _1: String { return L10n.tr("Localizable", "exercise_mountain_1_error_1", fallback: "Put your legs wider") }
          /// Put your legs narrower
          public static var _2: String { return L10n.tr("Localizable", "exercise_mountain_1_error_2", fallback: "Put your legs narrower") }
        }
      }
    }
    public enum Ropes {
      public enum _1 {
        /// 
        public static var details: String { return L10n.tr("Localizable", "exercise_ropes_1_details", fallback: "") }
        /// Battle ropes alternating lateral squat waves
        public static var name: String { return L10n.tr("Localizable", "exercise_ropes_1_name", fallback: "Battle ropes alternating lateral squat waves") }
        public enum Error {
          /// Put your legs narrower
          public static var _1: String { return L10n.tr("Localizable", "exercise_ropes_1_error_1", fallback: "Put your legs narrower") }
          /// Put your legs wider
          public static var _2: String { return L10n.tr("Localizable", "exercise_ropes_1_error_2", fallback: "Put your legs wider") }
        }
      }
    }
    public enum Sandbag {
      public enum _1 {
        /// 
        public static var details: String { return L10n.tr("Localizable", "exercise_sandbag_1_details", fallback: "") }
        /// Sandbag burpee
        public static var name: String { return L10n.tr("Localizable", "exercise_sandbag_1_name", fallback: "Sandbag burpee") }
      }
    }
    public enum Swiss {
      public enum _1 {
        /// 
        public static var details: String { return L10n.tr("Localizable", "exercise_swiss_1_details", fallback: "") }
        /// Swiss ball Jack knife
        public static var name: String { return L10n.tr("Localizable", "exercise_swiss_1_name", fallback: "Swiss ball Jack knife") }
        public enum Error {
          /// Put your legs narrower
          public static var _1: String { return L10n.tr("Localizable", "exercise_swiss_1_error_1", fallback: "Put your legs narrower") }
          /// Put your legs wider
          public static var _2: String { return L10n.tr("Localizable", "exercise_swiss_1_error_2", fallback: "Put your legs wider") }
        }
      }
    }
  }
  public enum General {
    public enum Connectivity {
      /// Internet is available!
      public static var internet: String { return L10n.tr("Localizable", "general_connectivity_internet", fallback: "Internet is available!") }
      public enum No {
        /// Internet connection is lost!
        public static var internet: String { return L10n.tr("Localizable", "general_connectivity_no_internet", fallback: "Internet connection is lost!") }
      }
    }
    public enum Session {
      /// Your session has expired. Login again to continue.
      public static var expired: String { return L10n.tr("Localizable", "general_session_expired", fallback: "Your session has expired. Login again to continue.") }
    }
  }
  public enum Live {
    public enum Feed {
      /// Copy
      public static var copy: String { return L10n.tr("Localizable", "live_feed_copy", fallback: "Copy") }
      /// Send
      public static var send: String { return L10n.tr("Localizable", "live_feed_send", fallback: "Send") }
      /// Share
      public static var share: String { return L10n.tr("Localizable", "live_feed_share", fallback: "Share") }
      /// LiveFeed
      public static var title: String { return L10n.tr("Localizable", "live_feed_title", fallback: "LiveFeed") }
      public enum Copy {
        /// Message copied!
        public static var success: String { return L10n.tr("Localizable", "live_feed_copy_success", fallback: "Message copied!") }
      }
      public enum Share {
        /// Message cannot be shared! Error: %@
        public static func error(_ p1: Any) -> String {
          return L10n.tr("Localizable", "live_feed_share_error", String(describing: p1), fallback: "Message cannot be shared! Error: %@")
        }
        /// Message shared!
        public static var success: String { return L10n.tr("Localizable", "live_feed_share_success", fallback: "Message shared!") }
      }
      public enum Title {
        public enum First {
          /// Welcome! 👋
          public static var line: String { return L10n.tr("Localizable", "live_feed_title_first_line", fallback: "Welcome! 👋") }
        }
        public enum Second {
          /// Type something to discuss... ✍️
          public static var line: String { return L10n.tr("Localizable", "live_feed_title_second_line", fallback: "Type something to discuss... ✍️") }
        }
      }
    }
  }
  public enum Login {
    /// Login
    public static var login: String { return L10n.tr("Localizable", "login_login", fallback: "Login") }
    public enum Email {
      /// Type your email...
      public static var placeholder: String { return L10n.tr("Localizable", "login_email_placeholder", fallback: "Type your email...") }
    }
    public enum Forgot {
      /// Forgot password
      public static var password: String { return L10n.tr("Localizable", "login_forgot_password", fallback: "Forgot password") }
      public enum Password {
        /// Forgot password request failed! Try again later.
        public static var error: String { return L10n.tr("Localizable", "login_forgot_password_error", fallback: "Forgot password request failed! Try again later.") }
        /// You've requested a password reset email successfully!
        public static var success: String { return L10n.tr("Localizable", "login_forgot_password_success", fallback: "You've requested a password reset email successfully!") }
      }
    }
    public enum Login {
      /// Login failed! Try again later.
      public static var error: String { return L10n.tr("Localizable", "login_login_error", fallback: "Login failed! Try again later.") }
      /// You've logged in successfully!
      public static var success: String { return L10n.tr("Localizable", "login_login_success", fallback: "You've logged in successfully!") }
    }
    public enum Name {
      /// Type your name...
      public static var placeholder: String { return L10n.tr("Localizable", "login_name_placeholder", fallback: "Type your name...") }
    }
    public enum Password {
      /// Type your password...
      public static var placeholder: String { return L10n.tr("Localizable", "login_password_placeholder", fallback: "Type your password...") }
    }
    public enum Segmented {
      public enum Control {
        /// Login
        public static var login: String { return L10n.tr("Localizable", "login_segmented_control_login", fallback: "Login") }
        public enum Sign {
          /// Sign up
          public static var up: String { return L10n.tr("Localizable", "login_segmented_control_sign_up", fallback: "Sign up") }
        }
      }
    }
    public enum Sign {
      /// Registration
      public static var up: String { return L10n.tr("Localizable", "login_sign_up", fallback: "Registration") }
      public enum Up {
        /// Registration failed! Try again later.
        public static var error: String { return L10n.tr("Localizable", "login_sign_up_error", fallback: "Registration failed! Try again later.") }
        /// You've signed up successfully!
        public static var success: String { return L10n.tr("Localizable", "login_sign_up_success", fallback: "You've signed up successfully!") }
      }
    }
  }
  public enum Onboarding {
    /// Continue
    public static var `continue`: String { return L10n.tr("Localizable", "onboarding_continue", fallback: "Continue") }
    /// Skip
    public static var skip: String { return L10n.tr("Localizable", "onboarding_skip", fallback: "Skip") }
    /// Subtitle
    public static var subtitle: String { return L10n.tr("Localizable", "onboarding_subtitle", fallback: "Subtitle") }
    /// Title
    public static var title: String { return L10n.tr("Localizable", "onboarding_title", fallback: "Title") }
    public enum Get {
      /// Get started
      public static var started: String { return L10n.tr("Localizable", "onboarding_get_started", fallback: "Get started") }
    }
  }
  public enum Settings {
    /// Battery saving
    public static var battery: String { return L10n.tr("Localizable", "settings_battery", fallback: "Battery saving") }
    /// Close
    public static var close: String { return L10n.tr("Localizable", "settings_close", fallback: "Close") }
    /// Choose image
    public static var image: String { return L10n.tr("Localizable", "settings_image", fallback: "Choose image") }
    /// Language
    public static var language: String { return L10n.tr("Localizable", "settings_language", fallback: "Language") }
    /// Logout
    public static var logout: String { return L10n.tr("Localizable", "settings_logout", fallback: "Logout") }
    /// Settings
    public static var title: String { return L10n.tr("Localizable", "settings_title", fallback: "Settings") }
    public enum Battery {
      /// With this you can control whether to use WebSocket or not
      public static var description: String { return L10n.tr("Localizable", "settings_battery_description", fallback: "With this you can control whether to use WebSocket or not") }
    }
    public enum Image {
      /// Delete
      public static var deletion: String { return L10n.tr("Localizable", "settings_image_deletion", fallback: "Delete") }
    }
    public enum Language {
      /// English
      public static var english: String { return L10n.tr("Localizable", "settings_language_english", fallback: "English") }
      /// Hungarian
      public static var hungarian: String { return L10n.tr("Localizable", "settings_language_hungarian", fallback: "Hungarian") }
      /// System
      public static var system: String { return L10n.tr("Localizable", "settings_language_system", fallback: "System") }
      public enum Alert {
        /// Please confirm
        public static var message: String { return L10n.tr("Localizable", "settings_language_alert_message", fallback: "Please confirm") }
        /// Are you sure?
        public static var title: String { return L10n.tr("Localizable", "settings_language_alert_title", fallback: "Are you sure?") }
        public enum Button {
          /// Cancel
          public static var cancel: String { return L10n.tr("Localizable", "settings_language_alert_button_cancel", fallback: "Cancel") }
          /// Restart app
          public static var restart: String { return L10n.tr("Localizable", "settings_language_alert_button_restart", fallback: "Restart app") }
        }
        public enum Notification {
          /// Tap to restart the application
          public static var title: String { return L10n.tr("Localizable", "settings_language_alert_notification_title", fallback: "Tap to restart the application") }
        }
      }
    }
  }
  public enum Trainings {
    /// Trainings
    public static var title: String { return L10n.tr("Localizable", "trainings_title", fallback: "Trainings") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = TranslatorServiceImpl.string(key, table, value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
