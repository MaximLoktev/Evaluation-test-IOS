//
//  UITableView+Extensions.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

extension UITableViewCell {
    
    class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
}

extension UITableViewHeaderFooterView {
    
    class func defaultReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier())
    }
    
    func register<T: UITableViewCell>(nib: UINib, forCellClass cellClass: T.Type) {
        register(nib, forCellReuseIdentifier: cellClass.defaultReuseIdentifier())
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterClass viewClass: T.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.defaultReuseIdentifier())
    }
    
    func register<T: UITableViewHeaderFooterView>(nib: UINib, forHeaderFooterClass viewClass: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: viewClass.defaultReuseIdentifier())
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.defaultReuseIdentifier()) as? T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type, forIndexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.defaultReuseIdentifier(),
            for: forIndexPath
            ) as? T else {
                fatalError("""
                    Error: cell with identifier: \(cellClass.defaultReuseIdentifier()) \
                    for index path: \(forIndexPath) is not \(T.self)"
                    """)
        }
        return cell
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(withClass viewClass: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(
            withIdentifier: viewClass.defaultReuseIdentifier()
            ) as? T else {
                fatalError("""
                    Error: view with \(viewClass.defaultReuseIdentifier()) is not registered
                    """)
        }
        return view
    }
    
}
