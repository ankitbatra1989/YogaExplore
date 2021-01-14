//
//  CustomTabItemView.swift
//  YogaExplore
//
//  Created by Ankit Batra on 11/01/21.
//

import Foundation
import UIKit

class CustomTabItemView: UIView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth), // fixing width
                
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0)
    }
    
    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        
        // adding tags to get views for modification when selected/unselected
        tabBarItem.tag = 11
        itemTitleLabel.tag = 12
        itemIconView.tag = 13
        
        switch item {
        case .yoga:
            itemIconView.image = UIImage(named: "yoga")
            break
        case .chats:
            itemIconView.image = UIImage(named: "chats")
            break
        case .articles:
            itemIconView.image = UIImage(named: "articles")
            break
        case .settings:
            itemIconView.image = UIImage(named: "settings")
            break
        }
        
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont(name: "Ubuntu-Regular", size: 12.0)
        itemTitleLabel.textColor = .black
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        itemIconView.image = item.icon!.withRenderingMode(.automatic)
        itemIconView.contentMode = .scaleAspectFit // added to stop stretching
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 25),
            itemIconView.widthAnchor.constraint(equalToConstant: 25),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 22),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 10),
            itemTitleLabel.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemTitleLabel.bottomAnchor.constraint(equalTo: tabBarItem.bottomAnchor, constant: -22)
            ])
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        
        let tabToActivate = self.subviews[tab]
        let itemTitleLabel = tabToActivate.viewWithTag(12) as? UILabel
        itemTitleLabel?.textColor = UIColor(red: (170.0/255.0), green: (143.0/255.0), blue: (118.0/255.0), alpha: 1.0)

        //
        if let itemIconView = tabToActivate.viewWithTag(13) as? UIImageView {
            switch tab {
            case 0:
                itemIconView.image = UIImage(named: "yoga_selected")
                break
            case 1:
                itemIconView.image = UIImage(named: "chats_selected")
                break
            case 2:
                itemIconView.image = UIImage(named: "articles_selected")
                break
            case 3:
                itemIconView.image = UIImage(named: "settings_selected")
                break
            default:
                break
            }
        }
       
        self.itemTapped?(tab)
        self.activeItem = tab
    }
    
    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        
        let itemTitleLabel = inactiveTab.viewWithTag(12) as? UILabel
        itemTitleLabel?.textColor = UIColor.black
        
        if let itemIconView = inactiveTab.viewWithTag(13) as? UIImageView {
            switch tab {
            case 0:
                itemIconView.image = UIImage(named: "yoga")
                break
            case 1:
                itemIconView.image = UIImage(named: "chats")
                break
            case 2:
                itemIconView.image = UIImage(named: "articles")
                break
            case 3:
                itemIconView.image = UIImage(named: "settings")
                break
            default:
                break
            }
        }
    }
}
