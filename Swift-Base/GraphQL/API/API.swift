// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct RequestPasswordRecoveryInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - email
  public init(email: String) {
    graphQLMap = ["email": email]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }
}

public struct SignInInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - email
  ///   - password
  public init(email: String, password: String) {
    graphQLMap = ["email": email, "password": password]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }
}

public struct SignOutInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - everywhere
  public init(everywhere: Swift.Optional<Bool?> = nil) {
    graphQLMap = ["everywhere": everywhere]
  }

  public var everywhere: Swift.Optional<Bool?> {
    get {
      return graphQLMap["everywhere"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "everywhere")
    }
  }
}

public struct SignUpInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - email
  ///   - password
  ///   - firstName
  ///   - lastName
  ///   - avatar
  public init(email: String, password: String, firstName: Swift.Optional<String?> = nil, lastName: Swift.Optional<String?> = nil, avatar: Swift.Optional<ImageUploader?> = nil) {
    graphQLMap = ["email": email, "password": password, "firstName": firstName, "lastName": lastName, "avatar": avatar]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }

  public var firstName: Swift.Optional<String?> {
    get {
      return graphQLMap["firstName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: Swift.Optional<String?> {
    get {
      return graphQLMap["lastName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var avatar: Swift.Optional<ImageUploader?> {
    get {
      return graphQLMap["avatar"] as? Swift.Optional<ImageUploader?> ?? Swift.Optional<ImageUploader?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avatar")
    }
  }
}

public struct ImageUploader: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - storage
  ///   - metadata
  public init(id: String, storage: Swift.Optional<String?> = nil, metadata: ImageUploaderMetadata) {
    graphQLMap = ["id": id, "storage": storage, "metadata": metadata]
  }

  public var id: String {
    get {
      return graphQLMap["id"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var storage: Swift.Optional<String?> {
    get {
      return graphQLMap["storage"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "storage")
    }
  }

  public var metadata: ImageUploaderMetadata {
    get {
      return graphQLMap["metadata"] as! ImageUploaderMetadata
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "metadata")
    }
  }
}

public struct ImageUploaderMetadata: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - size
  ///   - filename
  ///   - mimeType
  public init(size: Int, filename: String, mimeType: String) {
    graphQLMap = ["size": size, "filename": filename, "mimeType": mimeType]
  }

  public var size: Int {
    get {
      return graphQLMap["size"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }

  public var filename: String {
    get {
      return graphQLMap["filename"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "filename")
    }
  }

  public var mimeType: String {
    get {
      return graphQLMap["mimeType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "mimeType")
    }
  }
}

public struct UpdateUserInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - email
  ///   - firstName
  ///   - lastName
  ///   - currentPassword
  ///   - password
  ///   - avatar
  public init(email: Swift.Optional<String?> = nil, firstName: Swift.Optional<String?> = nil, lastName: Swift.Optional<String?> = nil, currentPassword: Swift.Optional<String?> = nil, password: Swift.Optional<String?> = nil, avatar: Swift.Optional<ImageUploader?> = nil) {
    graphQLMap = ["email": email, "firstName": firstName, "lastName": lastName, "currentPassword": currentPassword, "password": password, "avatar": avatar]
  }

  public var email: Swift.Optional<String?> {
    get {
      return graphQLMap["email"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var firstName: Swift.Optional<String?> {
    get {
      return graphQLMap["firstName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: Swift.Optional<String?> {
    get {
      return graphQLMap["lastName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var currentPassword: Swift.Optional<String?> {
    get {
      return graphQLMap["currentPassword"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "currentPassword")
    }
  }

  public var password: Swift.Optional<String?> {
    get {
      return graphQLMap["password"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }

  public var avatar: Swift.Optional<ImageUploader?> {
    get {
      return graphQLMap["avatar"] as? Swift.Optional<ImageUploader?> ?? Swift.Optional<ImageUploader?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avatar")
    }
  }
}

public final class RequestPasswordRecoveryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation requestPasswordRecovery($input: RequestPasswordRecoveryInput!) {
      requestPasswordRecovery(input: $input) {
        __typename
        detail
        message
      }
    }
    """

  public let operationName: String = "requestPasswordRecovery"

  public var input: RequestPasswordRecoveryInput

  public init(input: RequestPasswordRecoveryInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("requestPasswordRecovery", arguments: ["input": GraphQLVariable("input")], type: .object(RequestPasswordRecovery.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(requestPasswordRecovery: RequestPasswordRecovery? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "requestPasswordRecovery": requestPasswordRecovery.flatMap { (value: RequestPasswordRecovery) -> ResultMap in value.resultMap }])
    }

    public var requestPasswordRecovery: RequestPasswordRecovery? {
      get {
        return (resultMap["requestPasswordRecovery"] as? ResultMap).flatMap { RequestPasswordRecovery(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "requestPasswordRecovery")
      }
    }

    public struct RequestPasswordRecovery: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RequestPasswordRecoveryPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("detail", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(detail: String, message: String) {
        self.init(unsafeResultMap: ["__typename": "RequestPasswordRecoveryPayload", "detail": detail, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var detail: String {
        get {
          return resultMap["detail"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "detail")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class SigninMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation signin($input: SignInInput!) {
      signin(input: $input) {
        __typename
        me {
          __typename
          ...currentUserFragment
        }
        accessToken
        refreshToken
      }
    }
    """

  public let operationName: String = "signin"

  public var queryDocument: String { return operationDefinition.appending("\n" + CurrentUserFragment.fragmentDefinition) }

  public var input: SignInInput

  public init(input: SignInInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("signin", arguments: ["input": GraphQLVariable("input")], type: .object(Signin.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signin: Signin? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signin": signin.flatMap { (value: Signin) -> ResultMap in value.resultMap }])
    }

    public var signin: Signin? {
      get {
        return (resultMap["signin"] as? ResultMap).flatMap { Signin(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signin")
      }
    }

    public struct Signin: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SignInPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("me", type: .object(Me.selections)),
          GraphQLField("accessToken", type: .nonNull(.scalar(String.self))),
          GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(me: Me? = nil, accessToken: String, refreshToken: String) {
        self.init(unsafeResultMap: ["__typename": "SignInPayload", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }, "accessToken": accessToken, "refreshToken": refreshToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var me: Me? {
        get {
          return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "me")
        }
      }

      public var accessToken: String {
        get {
          return resultMap["accessToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accessToken")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }

      public struct Me: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CurrentUser"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(CurrentUserFragment.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

          public var currentUserFragment: CurrentUserFragment {
            get {
              return CurrentUserFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class SignoutMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation signout($input: SignOutInput!) {
      signout(input: $input) {
        __typename
        message
      }
    }
    """

  public let operationName: String = "signout"

  public var input: SignOutInput

  public init(input: SignOutInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("signout", arguments: ["input": GraphQLVariable("input")], type: .object(Signout.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signout: Signout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signout": signout.flatMap { (value: Signout) -> ResultMap in value.resultMap }])
    }

    public var signout: Signout? {
      get {
        return (resultMap["signout"] as? ResultMap).flatMap { Signout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signout")
      }
    }

    public struct Signout: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SignOutPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(message: String) {
        self.init(unsafeResultMap: ["__typename": "SignOutPayload", "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class SignupMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation signup($input: SignUpInput!) {
      signup(input: $input) {
        __typename
        me {
          __typename
          ...currentUserFragment
        }
        accessToken
        refreshToken
      }
    }
    """

  public let operationName: String = "signup"

  public var queryDocument: String { return operationDefinition.appending("\n" + CurrentUserFragment.fragmentDefinition) }

  public var input: SignUpInput

  public init(input: SignUpInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("signup", arguments: ["input": GraphQLVariable("input")], type: .object(Signup.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signup: Signup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signup": signup.flatMap { (value: Signup) -> ResultMap in value.resultMap }])
    }

    public var signup: Signup? {
      get {
        return (resultMap["signup"] as? ResultMap).flatMap { Signup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signup")
      }
    }

    public struct Signup: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SignUpPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("me", type: .object(Me.selections)),
          GraphQLField("accessToken", type: .nonNull(.scalar(String.self))),
          GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(me: Me? = nil, accessToken: String, refreshToken: String) {
        self.init(unsafeResultMap: ["__typename": "SignUpPayload", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }, "accessToken": accessToken, "refreshToken": refreshToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var me: Me? {
        get {
          return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "me")
        }
      }

      public var accessToken: String {
        get {
          return resultMap["accessToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accessToken")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }

      public struct Me: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CurrentUser"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(CurrentUserFragment.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

          public var currentUserFragment: CurrentUserFragment {
            get {
              return CurrentUserFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class UpdateTokenMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation updateToken {
      updateToken {
        __typename
        me {
          __typename
          ...currentUserFragment
        }
        accessToken
        refreshToken
      }
    }
    """

  public let operationName: String = "updateToken"

  public var queryDocument: String { return operationDefinition.appending("\n" + CurrentUserFragment.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateToken", type: .object(UpdateToken.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateToken: UpdateToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateToken": updateToken.flatMap { (value: UpdateToken) -> ResultMap in value.resultMap }])
    }

    public var updateToken: UpdateToken? {
      get {
        return (resultMap["updateToken"] as? ResultMap).flatMap { UpdateToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateToken")
      }
    }

    public struct UpdateToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateTokenPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("me", type: .object(Me.selections)),
          GraphQLField("accessToken", type: .nonNull(.scalar(String.self))),
          GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(me: Me? = nil, accessToken: String, refreshToken: String) {
        self.init(unsafeResultMap: ["__typename": "UpdateTokenPayload", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }, "accessToken": accessToken, "refreshToken": refreshToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var me: Me? {
        get {
          return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "me")
        }
      }

      public var accessToken: String {
        get {
          return resultMap["accessToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accessToken")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }

      public struct Me: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CurrentUser"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(CurrentUserFragment.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

          public var currentUserFragment: CurrentUserFragment {
            get {
              return CurrentUserFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class UpdateUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation updateUser($input: UpdateUserInput!) {
      updateUser(input: $input) {
        __typename
        me {
          __typename
          ...currentUserFragment
        }
      }
    }
    """

  public let operationName: String = "updateUser"

  public var queryDocument: String { return operationDefinition.appending("\n" + CurrentUserFragment.fragmentDefinition) }

  public var input: UpdateUserInput

  public init(input: UpdateUserInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateUser", arguments: ["input": GraphQLVariable("input")], type: .object(UpdateUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUser: UpdateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateUser": updateUser.flatMap { (value: UpdateUser) -> ResultMap in value.resultMap }])
    }

    public var updateUser: UpdateUser? {
      get {
        return (resultMap["updateUser"] as? ResultMap).flatMap { UpdateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateUser")
      }
    }

    public struct UpdateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateUserPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("me", type: .nonNull(.object(Me.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(me: Me) {
        self.init(unsafeResultMap: ["__typename": "UpdateUserPayload", "me": me.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var me: Me {
        get {
          return Me(unsafeResultMap: resultMap["me"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "me")
        }
      }

      public struct Me: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CurrentUser"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(CurrentUserFragment.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

          public var currentUserFragment: CurrentUserFragment {
            get {
              return CurrentUserFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class FetchCurrentUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchCurrentUser {
      me {
        __typename
        ...currentUserFragment
      }
    }
    """

  public let operationName: String = "FetchCurrentUser"

  public var queryDocument: String { return operationDefinition.appending("\n" + CurrentUserFragment.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("me", type: .object(Me.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CurrentUser"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CurrentUserFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

        public var currentUserFragment: CurrentUserFragment {
          get {
            return CurrentUserFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct CurrentUserFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment currentUserFragment on CurrentUser {
      __typename
      id
      email
      firstName
      lastName
      avatarUrl
    }
    """

  public static let possibleTypes: [String] = ["CurrentUser"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("email", type: .nonNull(.scalar(String.self))),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("avatarUrl", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "CurrentUser", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

  public var email: String {
    get {
      return resultMap["email"]! as! String
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

  public var avatarUrl: String? {
    get {
      return resultMap["avatarUrl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }
}

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
      avatarUrl
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("email", type: .nonNull(.scalar(String.self))),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("avatarUrl", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, avatarUrl: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "avatarUrl": avatarUrl])
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

  public var email: String {
    get {
      return resultMap["email"]! as! String
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

  public var avatarUrl: String? {
    get {
      return resultMap["avatarUrl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }
}
