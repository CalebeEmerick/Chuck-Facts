//
//  CollectionViewReusable.swift
//  Reusable
//
//  Created by Calebe Emerick on 24/09/16.
//  Copyright © 2016 CodeLLamas. All rights reserved.
//

import UIKit

/// Provides an easy way to `register` and `dequeue` cells, headers or footerViews.
public protocol CollectionViewReusable : NibCreatable { }

public extension CollectionViewReusable where Self : UICollectionView {
	
	/// Register a `cell` that can be used in the `UICollectionView` methods.
	///
	/// - Parameter cellClass: The `cell` type to be used in the `UICollectionView`.
	public func register<T: Reusable>(cellClass: T.Type) {
		
		register(T.self, forCellWithReuseIdentifier: T.identifier)
	}
	
	/// Register a `cell` that can be used in the `UICollectionView` methods.
	///
	/// **Important**
	///
	/// - Both your files `.xib` and `.swift` **must** have the same name.
	///
	/// - Parameter cellNib: The `cell` type to be used in the `UICollectionView`.
	public func register<T: Reusable>(cellNib: T.Type) {
		
		let nib = makeNib(for: T.self)
		
		register(nib, forCellWithReuseIdentifier: T.identifier)
	}
	
	/// Register a `view` that can be used in the `UICollectionView`.
	///
	/// **Important**
	///
	/// - Remember to **not** inherit from `UIView`.
	///
	/// - Make sure your `class` is a **UICollectionReusableView** subclass.
	///
	/// - You **must** choose one of these types: `UICollectionElementKindSectionFooter` or `UICollectionElementKindSectionHeader`.
	///
	/// - Parameters:
	///   - viewClass: The `view` type to be used as header of footer in the `UICollectionView`.
	///   - kind: The `String` defined to represent header or footer.
	public func register<T: Reusable>(viewClass: T.Type, ofKind kind: String) {
		
		register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
	}
	
	/// Register a `view` that can be used in the `UICollectionView`.
	///
	/// **Important**
	///
	/// - Remember to **not** inherit from `UIView`.
	///
	/// - Make sure your `class` is a **UICollectionReusableView** subclass.
	///
	/// - You **must** choose one of these types: `UICollectionElementKindSectionFooter` or `UICollectionElementKindSectionHeader`.
	///
	/// - Both your files `.xib` and `.swift` **must** have the same name.
	///
	/// - Parameters:
	///   - viewNib: The `view` type to be used as header of footer in the `UICollectionView`.
	///   - kind: The `String` defined to represent header or footer.
	public func register<T: Reusable>(viewNib: T.Type, ofKind kind: String) {
		
		let nib = makeNib(for: T.self)
		
		register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
	}
	
	/// Returns a reusable `cell` for the specified `class` and adds it to the collection.
	///
	/// **Important**
	///
	/// - You should use the `register(cellNib: Reusable.Protocol)` or `register(cellClass: Reusable.Protocol)` to prevent insert the identifier manually.
	///
	/// - Parameter indexPath: The `IndexPath` provided by the `UICollectionView` method.
	/// - Returns: Returns the reusable `cell` based in its type.
	public func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
		
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
			fatalError("It was not possible dequeue the cell with identifier: \(T.identifier)")
		}
		
		return cell
	}
	
	/// Returns a reusable `view` for the specified `class` and adds it to the collection.
	///
	/// **Important**
	///
	/// - You should use the `register(viewNib: Reusable.Protocol)` or `register(viewClass: Reusable.Protocol)` to prevent insert the identifier manually.
	///
	/// - You **must** choose one of these types: `UICollectionElementKindSectionFooter` or `UICollectionElementKindSectionHeader`.
	///
	/// - Parameters:
	///   - kind: The `String` defined to represent header or footer.
	///   - indexPath: The `IndexPath` provided by the `UICollectionView` method.
	/// - Returns: Returns the reusable `view` based in its type.
	public func dequeueReusableView<T: Reusable>(ofKind kind: String, for indexPath: IndexPath) -> T {
		
		guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
			fatalError("It was not possible dequeue the view with identifier: \(T.identifier)")
		}
		
		return view
	}
}

extension UICollectionView : CollectionViewReusable { }
