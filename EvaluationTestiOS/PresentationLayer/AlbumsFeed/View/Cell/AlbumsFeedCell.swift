//
//  AlbumsFeedCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import UIKit
import Kingfisher

final class AlbumsFeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let collectionName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return label
    }()
    
    private let primaryGenreName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .dark)
        blur.effect = blurEffect
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blur
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
        contentView.addSubview(backgroundImageView)
        
        blurEffectView.frame = contentView.bounds
        backgroundImageView.addSubview(blurEffectView)
        backgroundImageView.addSubview(contentImageView)
        
        backgroundImageView.addSubview(collectionName)
        backgroundImageView.addSubview(artistName)
        backgroundImageView.addSubview(primaryGenreName)
        
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupCell(album: AlbumModel) {
        collectionName.text = album.collectionName
        artistName.text = album.artistName
        primaryGenreName.text = album.primaryGenreName
        
        setupImage(string: album.artworkUrl100)
        layoutIfNeeded()
    }
    
    private func setupImage(string: String) {
        backgroundImageView.kf.setImage(with: URL(string: string))
        contentImageView.kf.setImage(with: URL(string: string))
    }
    
    // MARK: - Layout
    
    private func makeConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        collectionName.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview().inset(8.0)
            make.height.equalTo(15.0)
        }
        artistName.snp.makeConstraints { make in
            make.height.equalTo(15.0)
            make.top.equalTo(collectionName.snp.bottom).offset(6.0)
            make.left.right.equalToSuperview().inset(8.0)
        }
        primaryGenreName.snp.makeConstraints { make in
            make.height.equalTo(15.0)
            make.top.equalTo(artistName.snp.bottom).offset(4.0)
            make.left.right.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().offset(-12.0)
        }
    }
}
