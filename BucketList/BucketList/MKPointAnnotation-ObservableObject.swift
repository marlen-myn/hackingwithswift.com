//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Marlen Mynzhassar on 03.12.2020.
//

import MapKit

extension MKPointAnnotation : ObservableObject {
    public var wrapppedTitle: String {
        get {
            title ?? "Unknown title"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            subtitle ?? "Unknown subtitle"
        }
        set {
            subtitle = newValue
        }
    }
}
