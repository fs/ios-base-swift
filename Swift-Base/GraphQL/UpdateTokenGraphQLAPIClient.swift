//
//  UpdateTokenGraphQLAPIClient.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo
import Combine

@available(iOS 13.0, *)
class UpdateTokenGraphQLAPIClient: GraphQLAPIClient {

    // MARK: - GraphQLAPIClient Properties

    static let shared: GraphQLAPIClient = UpdateTokenGraphQLAPIClient(accessManager: DefaultManagersModule().accessManager)

    // MARK: -

    private let accessManager: AccessManager

    // MARK: - Instance Properties

    private lazy var client: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let interceptorProvider = NetworkInterceptorProvider(accessManager: self.accessManager, store: store, isUpdateToken: true)
        let requestChainNetworkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider, endpointURL: Configuration.graphQLURL)
        return ApolloClient(networkTransport: requestChainNetworkTransport, store: store)
    }()

    // MARK: - Initializers

    init(accessManager: AccessManager) {
        self.accessManager = accessManager
    }

    // MARK: - GraphQLAPIClient Methods

    func fetchPublisher<Query: GraphQLQuery>(query: Query, cachePolicy: CachePolicy, queue: DispatchQueue, contextIdentifier: UUID? = nil) -> Publishers.ApolloFetch<Query> {
        let config = Publishers.ApolloFetchConfiguration(client: self.client, query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue)
        return Publishers.ApolloFetch(with: config)
    }

    func performPublisher<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue) -> Publishers.ApolloPerform<Mutation> {
        let config = Publishers.ApolloPerformConfiguration(client: self.client, mutation: mutation, queue: queue)
        return Publishers.ApolloPerform(with: config)
      }

    func uploadPublisher<Operation: GraphQLOperation>(operation: Operation, queue: DispatchQueue, files: [GraphQLFile]) -> Publishers.ApolloUpload<Operation> {
        let config = Publishers.ApolloUploadConfiguration(client: self.client, operation: operation, files: files, queue: queue)
        return Publishers.ApolloUpload(with: config)
    }
}
