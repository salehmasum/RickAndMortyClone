//
//  SettingsView.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 24/1/2023.
//

import SwiftUI

struct SettingsView: View {
    
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { cellViewModel in
            HStack {
                if let image = cellViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(cellViewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                Text(cellViewModel.title)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.bottom, 3)
            .onTapGesture {
                cellViewModel.onTapHandler(cellViewModel.type)
            }
            
        }
    }
    
}
 
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
           
            return SettingsCellViewModel(type: $0) { option in
                
            }
            
        })))
    }
}
