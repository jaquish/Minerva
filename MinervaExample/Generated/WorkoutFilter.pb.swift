// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: WorkoutFilter.proto
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

public struct WorkoutFilterProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var startDateTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get { return _storage._startDateTimestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp() }
    set { _uniqueStorage()._startDateTimestamp = newValue }
  }
  /// Returns true if `startDateTimestamp` has been explicitly set.
  public var hasStartDateTimestamp: Bool { return _storage._startDateTimestamp != nil }
  /// Clears the value of `startDateTimestamp`. Subsequent reads from it will return its default value.
  public mutating func clearStartDateTimestamp() { _uniqueStorage()._startDateTimestamp = nil }

  public var endDateTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get { return _storage._endDateTimestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp() }
    set { _uniqueStorage()._endDateTimestamp = newValue }
  }
  /// Returns true if `endDateTimestamp` has been explicitly set.
  public var hasEndDateTimestamp: Bool { return _storage._endDateTimestamp != nil }
  /// Clears the value of `endDateTimestamp`. Subsequent reads from it will return its default value.
  public mutating func clearEndDateTimestamp() { _uniqueStorage()._endDateTimestamp = nil }

  public var startTimeTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get { return _storage._startTimeTimestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp() }
    set { _uniqueStorage()._startTimeTimestamp = newValue }
  }
  /// Returns true if `startTimeTimestamp` has been explicitly set.
  public var hasStartTimeTimestamp: Bool { return _storage._startTimeTimestamp != nil }
  /// Clears the value of `startTimeTimestamp`. Subsequent reads from it will return its default value.
  public mutating func clearStartTimeTimestamp() { _uniqueStorage()._startTimeTimestamp = nil }

  public var endTimeTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get { return _storage._endTimeTimestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp() }
    set { _uniqueStorage()._endTimeTimestamp = newValue }
  }
  /// Returns true if `endTimeTimestamp` has been explicitly set.
  public var hasEndTimeTimestamp: Bool { return _storage._endTimeTimestamp != nil }
  /// Clears the value of `endTimeTimestamp`. Subsequent reads from it will return its default value.
  public mutating func clearEndTimeTimestamp() { _uniqueStorage()._endTimeTimestamp = nil }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum FilterType: SwiftProtobuf.Enum {
    public typealias RawValue = Int
    case startDate  // = 1
    case endDate  // = 2
    case startTime  // = 3
    case endTime  // = 4

    public init() {
      self = .startDate
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 1: self = .startDate
      case 2: self = .endDate
      case 3: self = .startTime
      case 4: self = .endTime
      default: return nil
      }
    }

    public var rawValue: Int {
      switch self {
      case .startDate: return 1
      case .endDate: return 2
      case .startTime: return 3
      case .endTime: return 4
      }
    }

  }

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

#if swift(>=4.2)

extension WorkoutFilterProto.FilterType: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension WorkoutFilterProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase,
  SwiftProtobuf._ProtoNameProviding
{
  public static let protoMessageName: String = "WorkoutFilterProto"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "startDateTimestamp"),
    2: .same(proto: "endDateTimestamp"),
    3: .same(proto: "startTimeTimestamp"),
    4: .same(proto: "endTimeTimestamp"),
  ]

  fileprivate class _StorageClass {
    var _startDateTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _endDateTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _startTimeTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _endTimeTimestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _startDateTimestamp = source._startDateTimestamp
      _endDateTimestamp = source._endDateTimestamp
      _startTimeTimestamp = source._startTimeTimestamp
      _endTimeTimestamp = source._endTimeTimestamp
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._startDateTimestamp)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._endDateTimestamp)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._startTimeTimestamp)
        case 4: try decoder.decodeSingularMessageField(value: &_storage._endTimeTimestamp)
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._startDateTimestamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._endDateTimestamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._startTimeTimestamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if let v = _storage._endTimeTimestamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func == (lhs: WorkoutFilterProto, rhs: WorkoutFilterProto) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) {
        (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._startDateTimestamp != rhs_storage._startDateTimestamp { return false }
        if _storage._endDateTimestamp != rhs_storage._endDateTimestamp { return false }
        if _storage._startTimeTimestamp != rhs_storage._startTimeTimestamp { return false }
        if _storage._endTimeTimestamp != rhs_storage._endTimeTimestamp { return false }
        return true
      }
      if !storagesAreEqual { return false }
    }
    if lhs.unknownFields != rhs.unknownFields { return false }
    return true
  }
}

extension WorkoutFilterProto.FilterType: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "startDate"),
    2: .same(proto: "endDate"),
    3: .same(proto: "startTime"),
    4: .same(proto: "endTime"),
  ]
}
