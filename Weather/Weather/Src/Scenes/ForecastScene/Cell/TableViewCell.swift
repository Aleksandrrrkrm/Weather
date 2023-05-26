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
        .font(UIFont(name: "Montserrat-SemiBold", size: 12) ?? UIFont())
    var descriptionLabel = UILabel()
        .alignment(.right)
        .setManyLines()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-Bold", size: 19) ?? UIFont())
    var minLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont())
    var maxLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        backgroundColor = UIColor(named: "appBlue")
        contentView.backgroundColor = UIColor(named: "appBlue")
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    private func setupViews() {
        addViews()
        setupMinLabel()
        setupMaxLabel()
        setupDescriptionLabel()
        setupDateLabel()
    }
    
    private func addViews() {
        [dateLabel, descriptionLabel, minLabel, maxLabel].forEach { label in
            contentView.addSubview(label)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: minLabel.trailingAnchor, constant: 10),
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
    
    private func setupMinLabel() {
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            minLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            minLabel.widthAnchor.constraint(equalToConstant: CGFloat(90))
        ])
    }
    
    private func setupMaxLabel() {
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            maxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            maxLabel.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 30)
        ])
    }
    
    public func setupCell(data: Forecast) {
        dateLabel.text = data.date
        setDescription(key: data.parts.day.condition)
        minLabel.text = "Oт \(data.parts.day.tempMin)°C"
        maxLabel.text = "До \(data.parts.day.tempMax)°C"
    }
    
    private func setDescription(key: String) {
        let weatherDescription = DescriptionTranslate.translate(key: key)
        descriptionLabel.text = weatherDescription
    }
}
