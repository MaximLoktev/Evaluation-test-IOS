//
//  AlbumsActivityCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

final class AlbumsActivityCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        makeCostraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicatorView.startAnimating()
    }
    
    // MARK: - Layout
    
    private func makeCostraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
}
