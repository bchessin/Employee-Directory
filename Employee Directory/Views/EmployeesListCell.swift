//
//  EmployeesListCell.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit

final class EmployeesListCell: UITableViewCell {
    private var networking: Networking?
    private var cacheService: CacheService?
    
    // MARK: UI Elements
    private (set) lazy var profileImageView: CachedImageView = {
        // We pass our networking / cache service from the view model, however if something goes wrong
        // then we can just instantiate a new service without much repercussions
        let imageViewNetworking = networking ?? Networking()
        let imageViewCacheService = cacheService ?? CacheService()
        let imageView = CachedImageView(networking: imageViewNetworking, cacheService: imageViewCacheService)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 38
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = StringHelper.profilePhoto
        return imageView
    }()
    
    private (set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        let title3FontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
        label.font = UIFont(descriptor: title3FontDescriptor, size: title3FontDescriptor.pointSize)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .squareBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private (set) lazy var teamLabel: UILabel = {
        let label = UILabel()
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        label.font = UIFont(descriptor: bodyFontDescriptor, size: bodyFontDescriptor.pointSize)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .squareBlack
        label.backgroundColor = .squareBlue
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Setup User Interface
    private func setupCellUI(){
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(teamLabel)
        
        // Constraints for profile image view. We hardcode width and height to be 75 (for now)
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:75).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:75).isActive = true
        
        // Primary constraints
        let commonSpacing: CGFloat = 12.0
        nameLabel.bottomAnchor.constraint(equalTo:self.profileImageView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:commonSpacing).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-commonSpacing).isActive = true
        
        teamLabel.topAnchor.constraint(equalTo:self.profileImageView.centerYAnchor).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        
        // Constraint to ensure width of team label matches text but 
        let teamLabelTrailingConstraint = NSLayoutConstraint(
            item: teamLabel,
            attribute: .right,
            relatedBy: .lessThanOrEqual,
            toItem: self.contentView,
            attribute: .right,
            multiplier: 1,
            constant: commonSpacing)
        
        // Constraints to ensure profile picture is not cut off
        let topProfilePicContraint = NSLayoutConstraint(
            item: profileImageView,
            attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: self.contentView,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        let bottomProfilePicContraint = NSLayoutConstraint(
            item: profileImageView,
            attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem: self.contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        
        // Constraints to ensure labels resize UITableViewCell height accordingly
        let topNameContraint = NSLayoutConstraint(
            item: nameLabel,
            attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: self.contentView,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        let bottomTeamConstraint = NSLayoutConstraint(
            item: teamLabel,
            attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem: self.contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        NSLayoutConstraint.activate([teamLabelTrailingConstraint,
                                     topNameContraint,
                                     bottomTeamConstraint,
                                     topProfilePicContraint,
                                     bottomProfilePicContraint])
    }
    
    // MARK: Employee Data
    func setData(employee: Employee?, networking: Networking, cacheService: CacheService) {
        guard let employee = employee else { return }
        self.networking = networking
        self.cacheService = cacheService
        
        profileImageView.loadImage(from: employee.photoURLSmall, withUUID: employee.uuid)
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
    }
    
    // MARK: UITableViewCell initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCellUI()
    }
}
