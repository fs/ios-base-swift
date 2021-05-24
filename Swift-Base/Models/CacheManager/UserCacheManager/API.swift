//
//  API.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 24/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

public struct UserFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment userFragment on User {
      __typename
      id
      email
      firstName
      lastName
      profileNumber
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("email", type: .scalar(String.self)),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("profileNumber", type: .nonNull(.scalar(String.self)))
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, email: String? = nil, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil, profileNumber: String) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "profileNumber": profileNumber])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var profileNumber: String {
    get {
      return resultMap["profileNumber"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "profileNumber")
    }
  }

  public struct CanManage: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["AuthorizationResult"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(AuthorizationResultFragment.self)
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(value: Bool) {
      self.init(unsafeResultMap: ["__typename": "AuthorizationResult", "value": value])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var authorizationResultFragment: AuthorizationResultFragment {
        get {
          return AuthorizationResultFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct AuthorizationResultFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment authorizationResultFragment on AuthorizationResult {
      __typename
      value
    }
    """

  public static let possibleTypes: [String] = ["AuthorizationResult"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("value", type: .nonNull(.scalar(Bool.self)))
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(value: Bool) {
    self.init(unsafeResultMap: ["__typename": "AuthorizationResult", "value": value])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Result of applying a policy rule
  public var value: Bool {
    get {
      return resultMap["value"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "value")
    }
  }
}
