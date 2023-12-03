//
//  FCollectionReference.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 2/12/23.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case Usuario
    case Categoria
    case Producto
    case Ubicacion
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
