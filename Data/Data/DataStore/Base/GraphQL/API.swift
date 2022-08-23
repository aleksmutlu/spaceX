// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LaunchesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Launches {
      launches(limit: 10, order: "desc", sort: "launch_date_utc") {
        __typename
        launch_date_utc
        mission_name
        launch_success
      }
    }
    """

  public let operationName: String = "Launches"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("launches", arguments: ["limit": 10, "order": "desc", "sort": "launch_date_utc"], type: .list(.object(Launch.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(launches: [Launch?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "launches": launches.flatMap { (value: [Launch?]) -> [ResultMap?] in value.map { (value: Launch?) -> ResultMap? in value.flatMap { (value: Launch) -> ResultMap in value.resultMap } } }])
    }

    public var launches: [Launch?]? {
      get {
        return (resultMap["launches"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Launch?] in value.map { (value: ResultMap?) -> Launch? in value.flatMap { (value: ResultMap) -> Launch in Launch(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Launch?]) -> [ResultMap?] in value.map { (value: Launch?) -> ResultMap? in value.flatMap { (value: Launch) -> ResultMap in value.resultMap } } }, forKey: "launches")
      }
    }

    public struct Launch: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Launch"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("launch_date_utc", type: .scalar(String.self)),
          GraphQLField("mission_name", type: .scalar(String.self)),
          GraphQLField("launch_success", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(launchDateUtc: String? = nil, missionName: String? = nil, launchSuccess: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "Launch", "launch_date_utc": launchDateUtc, "mission_name": missionName, "launch_success": launchSuccess])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var launchDateUtc: String? {
        get {
          return resultMap["launch_date_utc"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "launch_date_utc")
        }
      }

      public var missionName: String? {
        get {
          return resultMap["mission_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "mission_name")
        }
      }

      public var launchSuccess: Bool? {
        get {
          return resultMap["launch_success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "launch_success")
        }
      }
    }
  }
}
