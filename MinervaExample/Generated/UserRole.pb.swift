// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: UserRole.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public enum UserRole: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case user  // = 1
  case userManager  // = 2
  case admin  // = 3

  public init() {
    self = .user
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 1: self = .user
    case 2: self = .userManager
    case 3: self = .admin
    default: return nil
    }
  }

  public var rawValue: Int {
    switch self {
    case .user: return 1
    case .userManager: return 2
    case .admin: return 3
    }
  }

}

#if swift(>=4.2)

extension UserRole: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension UserRole: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "user"),
    2: .same(proto: "userManager"),
    3: .same(proto: "admin"),
  ]
}
