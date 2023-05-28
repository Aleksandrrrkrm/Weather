//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    var dateLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratSemiBold.rawValue, size: 14) ?? UIFont())
    var descriptionLabel = UILabel()
        .alignment(.right)
        .setManyLines()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratBold.rawValue, size: 19) ?? UIFont())
    var maxLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratBold.rawValue, size: 19) ?? UIFont())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        contentView.backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5,
                                                                     left: 10,
                                                                     bottom: 5,
                                                                     right: 10))
    }
    
    private func setupViews() {
        addViews()
        setupMaxLabel()
        setupDescriptionLabel()
        setupDateLabel()
    }
    
    private func addViews() {
        [dateLabel, descriptionLabel, maxLabel].forEach { label in
            contentView.addSubview(label)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupMaxLabel() {
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            maxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            maxLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30)
        ])
    }
    
    public func setupCell(data: Forecast) {
        setDescription(key: data.parts.day.condition)
        maxLabel.text = "До \(data.parts.day.tempMax)°C"
        guard let date = DateService.format(from: data.date, to: "dd.MM") else { return }
        dateLabel.text = date
    }
    
    private func setDescription(key: String) {
        let weatherDescription = DescriptionTranslate.translate(key: key)
        descriptionLabel.text = weatherDescription
    }
}
