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
    
    private var searchResultHandler: (() -> Void)?
    
    //MARK: - Init
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func executeSearch() {
        
        //Test search text
        searchText = "Rick"
        
        //Build arguments
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText)
        ]
        //Add Options
        queryParams.append(contentsOf:
                            optionMap.enumerated().compactMap({ _, element in
            let key: SearchInputViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        })
        )
        //Create request
        let request = NetworkRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams
        )
        
        //Execute request
        NetworkService.shared.execute(
            request,
            expecting: GetAllCharactersResponse.self
        ) { result in
            //Notify view of results, no results, or error
            
            switch result {
            case .success(let model):
                print("Search results found: \(model.results.count)")
            case .failure:
                break
            }
        }
        
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
