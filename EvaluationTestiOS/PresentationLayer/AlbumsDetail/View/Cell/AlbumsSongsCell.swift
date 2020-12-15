//
//  AlbumsSongsCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 13.12.2020.
//

import UIKit

final class AlbumsSongsCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let trackNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    private let trackTimeMillis: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .white
        label.textAlignment = .right

        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(trackNumber)
        contentView.addSubview(trackName)
        contentView.addSubview(trackTimeMillis)
        
        // Расстановка приоритетов контенту
        trackNumber.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        trackNumber.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        trackName.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trackName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        trackTimeMillis.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        trackTimeMillis.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        makeCostraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupCell(song: SongModel, index: Int) {
        trackNumber.text = String(index)
        trackName.text = song.trackName
        
        let time = setupTimeFormatter(duration: song.trackTimeMillis)
        trackTimeMillis.text = time
    }
    
    private func setupTimeFormatter(duration: Int) -> String {
        let durationInSeconds: Int = duration / 1000
        let seconds = durationInSeconds % 60
        let minutes: Int = durationInSeconds / 60
        
        if minutes > 59 {
            let hours = minutes / 60
            let remainder: Int = minutes % 60
            
            return "\(zeroPrefix(hours)):\(zeroPrefix(remainder)):\(zeroPrefix(seconds))"
        }
        
        return "\(zeroPrefix(minutes)):\(zeroPrefix(seconds))"
    }
    
    private func zeroPrefix(_ value: Int) -> String {
        return (value < 10) ? "0\(value)" : "\(value)"
    }
    
    // MARK: - Layout
    
    private func makeCostraints() {
        trackNumber.snp.makeConstraints { make in
            make.height.equalTo(15.0)
            make.top.bottom.equalToSuperview().inset(4.0)
            make.left.equalToSuperview().offset(20.0)
        }
        trackName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4.0)
            make.left.equalTo(trackNumber.snp.right).offset(16.0)
        }
        trackTimeMillis.snp.makeConstraints { make in
            make.height.equalTo(15.0)
            make.top.bottom.equalToSuperview().inset(4.0)
            make.left.equalTo(trackName.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0)
        }
    }
}
