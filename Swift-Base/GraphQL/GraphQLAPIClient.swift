//
//  GraphQLAPIClient.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo
import Combine

@available(iOS 13.0, *)
protocol GraphQLAPIClient {

    // MARK: - Instance Properties

    static var shared: GraphQLAPIClient { get }

    // MARK: - Instance Methods

    func fetchPublisher<Query: GraphQLQuery>(query: Query, cachePolicy: CachePolicy, queue: DispatchQueue, contextIdentifier: UUID?) -> Publishers.ApolloFetch<Query>
    func performPublisher<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue) -> Publishers.ApolloPerform<Mutation>
    func uploadPublisher<Operation: GraphQLOperation>(operation: Operation, queue: DispatchQueue, files: [GraphQLFile]) -> Publishers.ApolloUpload<Operation>
}

// MARK: -

@available(iOS 13.0, *)
extension GraphQLAPIClient {

    // MARK: - Insatnсe Methods

    func performPublisher<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = .main) -> Publishers.ApolloPerform<Mutation> {
        return self.performPublisher(mutation: mutation, queue: queue)
    }
}
