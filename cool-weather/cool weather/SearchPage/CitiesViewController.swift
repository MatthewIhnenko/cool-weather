//
//  CitiesViewController.swift
//  cool weather
//
//  Created by Matthew on 19.09.22.
//

import UIKit

class CitiesViewController: UIViewController {

    var latitide = 0.0
    var longitude = 0.0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var favoriteCity1: UIButton!
    
    @IBOutlet weak var favoriteCity2: UIButton!
    
    @IBOutlet weak var favoriteCity3: UIButton!
    
    
    
    
    //@IBOutlet weak var citiPicker: UIPickerView!
    
    public let citiesArr = ["Minsk", "Moscow", "Berlin", "Tokyo", "Stambul", "London", "Vienna", "Dubai", "Ankara", "Cairo", "Canberra","Caracas",]
    
    
    
    var filterCities: [String]!
    
    var cityFromSearch: String = ""
    var arrayOfFavorites: [String] = []
    
    @IBOutlet weak var cityLabel: UILabel!
    
//@IBOutlet weak var geoCityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        filterCities = citiesArr
        
        //citiPicker.delegate = self
        //citiPicker.dataSource = self
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self


    }
    
    func favotiteCities() {
        

        
        
        if arrayOfFavorites.count >= 1 {
            
            favoriteCity1.setTitle(arrayOfFavorites[0], for: .normal)
        } else if arrayOfFavorites.count >= 2 {
            favoriteCity2.setTitle(arrayOfFavorites[1], for: .normal)
        } else if arrayOfFavorites.count == 3 {
            favoriteCity3.setTitle(arrayOfFavorites[2], for: .normal)}
            
            
            
            
    }
    
    
    
    @IBAction func addToFavoritePressed(_ sender: UIButton) {
        
        arrayOfFavorites.append(cityFromSearch)
        
        if arrayOfFavorites.count == 4 {
            arrayOfFavorites.removeFirst()
            
        }
        
        favotiteCities()
        
        print(arrayOfFavorites)
        //print(cityFromSearch)
        
    }
    
    
    
    
    
    

}
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filterCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        print("Выбран",filterCities[indexPath.row])
        cityLabel.text = filterCities[indexPath.row]
        
        self.cityFromSearch = filterCities[indexPath.row]
        
    }
    

    
}



extension CitiesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArr[row]
        //return filterCities[IndexPath.Element]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //cityLabel.text = cities[row]
    }
    
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCities = []

        if searchText == "" {
            filterCities = citiesArr
        }

        for word in citiesArr {

            if word.uppercased().contains(searchText.uppercased()) {
                filterCities.append(word)
            }

        }
        
        self.tableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

