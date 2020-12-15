//
//  AlbumsDetailCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

final class AlbumsDetailCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let collectionName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    private let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11.0, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.numberOfLines = 2
        
        return label
    }()
    
    private let primaryGenreName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9.0, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return label
    }()
    
    private let trackCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9.0, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return label
    }()
    
    private let releaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9.0, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(collectionName)
        contentView.addSubview(artistName)
        contentView.addSubview(primaryGenreName)
        contentView.addSubview(trackCount)
        contentView.addSubview(releaseDate)
        
        makeCostraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupCell(album: AlbumModel) {
        collectionName.text = album.collectionName
        artistName.text = album.artistName
        releaseDate.text = NSLocalizedString("Релиз: ", comment: "") + album.releaseDate
        primaryGenreName.text = album.primaryGenreName
        trackCount.text = NSLocalizedString("Треки: ", comment: "") + String(album.trackCount)
        
        setupImage(string: album.artworkUrl100)
    }
    
    private func setupImage(string: String) {
        contentImageView.kf.setImage(with: URL(string: string))
    }
    
    // MARK: - Layout
    
    private func makeCostraints() {
        contentImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100.0)
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16.0)
        }
        collectionName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16.0)
            make.left.equalTo(contentImageView.snp.right).offset(8.0)
        }
        artistName.snp.makeConstraints { make in
            make.top.equalTo(collectionName.snp.bottom).offset(2.0)
            make.left.equalTo(contentImageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
        }
        primaryGenreName.snp.makeConstraints { make in
            make.height.equalTo(12.0)
            make.top.equalTo(artistName.snp.bottom).offset(4.0).priority(.low)
            make.left.equalTo(contentImageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
        }
        trackCount.snp.makeConstraints { make in
            make.height.equalTo(12.0)
            make.top.equalTo(primaryGenreName.snp.bottom).offset(2.0)
            make.left.equalTo(contentImageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
        }
        releaseDate.snp.makeConstraints { make in
            make.height.equalTo(12.0)
            make.top.equalTo(trackCount.snp.bottom).offset(2.0)
            make.left.equalTo(contentImageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-7.0)
        }
    }
}
