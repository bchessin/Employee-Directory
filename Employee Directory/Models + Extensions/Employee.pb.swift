// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Employee.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Employee_Type: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case none // = 0
  case fullTime // = 1
  case partTime // = 2
  case contractor // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .none
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .none
    case 1: self = .fullTime
    case 2: self = .partTime
    case 3: self = .contractor
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .none: return 0
    case .fullTime: return 1
    case .partTime: return 2
    case .contractor: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Employee_Type: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Employee_Type] = [
    .none,
    .fullTime,
    .partTime,
    .contractor,
  ]
}

#endif  // swift(>=4.2)

struct Employee {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var uuid: String = String()

  var fullName: String = String()

  var emailAddress: String = String()

  var team: String = String()

  var employeeType: Employee_Type = .none

  var phoneNumber: String = String()

  var biography: String = String()

  var photoURLSmall: String = String()

  var photoURLLarge: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Employee_Type: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NONE"),
    1: .same(proto: "FULL_TIME"),
    2: .same(proto: "PART_TIME"),
    3: .same(proto: "CONTRACTOR"),
  ]
}

extension Employee: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Employee"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "uuid"),
    2: .standard(proto: "full_name"),
    3: .standard(proto: "email_address"),
    4: .same(proto: "team"),
    6: .standard(proto: "employee_type"),
    7: .standard(proto: "phone_number"),
    8: .same(proto: "biography"),
    9: .standard(proto: "photo_url_small"),
    10: .standard(proto: "photo_url_large"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.uuid) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.fullName) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.emailAddress) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.team) }()
      case 6: try { try decoder.decodeSingularEnumField(value: &self.employeeType) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.phoneNumber) }()
      case 8: try { try decoder.decodeSingularStringField(value: &self.biography) }()
      case 9: try { try decoder.decodeSingularStringField(value: &self.photoURLSmall) }()
      case 10: try { try decoder.decodeSingularStringField(value: &self.photoURLLarge) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.uuid.isEmpty {
      try visitor.visitSingularStringField(value: self.uuid, fieldNumber: 1)
    }
    if !self.fullName.isEmpty {
      try visitor.visitSingularStringField(value: self.fullName, fieldNumber: 2)
    }
    if !self.emailAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.emailAddress, fieldNumber: 3)
    }
    if !self.team.isEmpty {
      try visitor.visitSingularStringField(value: self.team, fieldNumber: 4)
    }
    if self.employeeType != .none {
      try visitor.visitSingularEnumField(value: self.employeeType, fieldNumber: 6)
    }
    if !self.phoneNumber.isEmpty {
      try visitor.visitSingularStringField(value: self.phoneNumber, fieldNumber: 7)
    }
    if !self.biography.isEmpty {
      try visitor.visitSingularStringField(value: self.biography, fieldNumber: 8)
    }
    if !self.photoURLSmall.isEmpty {
      try visitor.visitSingularStringField(value: self.photoURLSmall, fieldNumber: 9)
    }
    if !self.photoURLLarge.isEmpty {
      try visitor.visitSingularStringField(value: self.photoURLLarge, fieldNumber: 10)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Employee, rhs: Employee) -> Bool {
    if lhs.uuid != rhs.uuid {return false}
    if lhs.fullName != rhs.fullName {return false}
    if lhs.emailAddress != rhs.emailAddress {return false}
    if lhs.team != rhs.team {return false}
    if lhs.employeeType != rhs.employeeType {return false}
    if lhs.phoneNumber != rhs.phoneNumber {return false}
    if lhs.biography != rhs.biography {return false}
    if lhs.photoURLSmall != rhs.photoURLSmall {return false}
    if lhs.photoURLLarge != rhs.photoURLLarge {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
