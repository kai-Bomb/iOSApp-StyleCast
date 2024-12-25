//
//  CoreDataStorageError.swift
//  StyleCast
//
//  Created by kyusok.lee on 2024/12/25.
//

enum CoreDataStorageError: Error {
    case readError(Error)
    case updateError(Error)
    case saveError(Error)
    case deleteError(Error)
}
