//
//  HomeViewController.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import UIKit
import SwiftUI

// HomeController class manages the main view displaying a collection of meals
class HomeController: UICollectionViewController {
    
    // MARK: - Properties
    
    var isSearchBarVisible = false
    var allMeal: [MealLocalData] = []
    var filteredMeals: [MealLocalData] = []
    var searchText: String?
    
    // MARK: - Initialization
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        collectionView.register(MealCollectionCell.self, forCellWithReuseIdentifier: MealCollectionCell.id)
        
        // Configure collection view properties
        collectionView.keyboardDismissMode = .interactive
        collectionView.contentInset = UIEdgeInsets(top: -111, left: 0, bottom: 111, right: 0)
        collectionView.collectionViewLayout = createLayout()
        
        // Fetch meals data
        fetchMeals()
        
        // Setup search functionality
        searchOnDisplay()
    }
    
    // MARK: - Data Fetching
    
    func fetchMeals() {
        let category = "Dessert"
        
        // Fetch meals data from the network
        MealManagerNetwork.shared.fetchData(category: category) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    // Update data source and reload collection view on the main thread
                    self.filteredMeals.append(contentsOf: data)
                    self.allMeal.append(contentsOf: data)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Collection View Layout
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            // Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [headerItem]
            section.interGroupSpacing = 10
            
            return section
        }
        
        return layout
    }
}


//MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension HomeController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filteredMeals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionCell.id, for: indexPath) as! MealCollectionCell
        cell.imageView.load(urlString: filteredMeals[indexPath.row].urlImage)
        cell.nameLabel.text = filteredMeals[indexPath.row].name
        cell.idLabel.text =  "ID: \(filteredMeals[indexPath.row].id)"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailView(meal: filteredMeals[indexPath.row])
        
        // Wrap the DetailView in a NavigationView
        let hostingController = UIHostingController(rootView: NavigationView {
            detailView
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button("Back") {
                    self.dismiss(animated: true)
                }) 
        })
        
        present(hostingController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width), height: (view.frame.height/2) - 210)
    }
}


//MARK: - UISearchBarDelegate,UISearchResultsUpdating

extension HomeController: UISearchBarDelegate,UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    private func searchOnDisplay() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.showsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.barTintColor = .red // Set the background color to red
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // Ensure that the search bar is always visible
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchFields: [KeyPath<MealLocalData, String>] = [\MealLocalData.name]
        
        if searchText.isEmpty {
            filteredMeals = allMeal.sorted { $0.name < $1.name }
            return
        }
        
        let searchTerms = searchText.lowercased().split(separator: " ")
        filteredMeals = allMeal.filter { card in
            for field in searchFields {
                let value = card[keyPath: field].lowercased()
                for term in searchTerms {
                    if !value.contains(term) {
                        return false
                    }
                }
            }
            return true
        }
        .sorted { $0.name < $1.name }
        collectionView.reloadData()
    }
}
