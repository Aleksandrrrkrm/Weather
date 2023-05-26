//
//  SearchResultTableViewCell.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    private var label = UILabel()
        .font(UIFont(name: "Montserrat-SemiBold", size: 18) ?? UIFont())
        .color(.white)
    
    // MARK: - Private properties
    private var lon = ""
    private var lat = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureCell()
        setupLabel()
    }
    
    // MARK: - Settings
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "appBlue")
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.backgroundColor = UIColor(named: "appBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: CGFloat(50))
        ])
    }
    
    // MARK: - Setup cell
    func setupCell(_ data: AddressSuggestion) {
        label.text = data.value
        lat = data.data.geoLat ?? ""
        lon = data.data.geoLon ?? ""
    }
}
