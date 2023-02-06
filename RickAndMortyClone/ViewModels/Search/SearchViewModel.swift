//
//  SearchViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 1/2/2023.
//

import Foundation

//Responsibilities
// - Show search results
// - Show no results view
// - Kick off api request

final class SearchViewModel {
    
    let config: SearchViewController.Config
    private var optionMap: [SearchInputViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    private var optionMapUpdateBloc: (((SearchInputViewModel.DynamicOption, String)) -> Void)?
    
    //MARK: - Init
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
    public func executeSearch() {
        //Create request based on filters
        //Send API call
        //Notify view of results, no results, or error
    }
    
    public func set(query text: String) {
        
    }
    
    public func set(value: String, for option: SearchInputViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBloc?(tuple)
    }
    
    public func registerOptionChangeBlock(
        _ block: @escaping ((SearchInputViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBloc = block
    }
}
