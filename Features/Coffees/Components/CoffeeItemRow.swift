//
//  CoffeeItemRow.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/7/25.
//

import SwiftUI

struct CoffeeItemRow: View {
    let item: Coffee
    
    var body: some View {
        HStack {
            Image(uiImage:
                    UIImage(systemName: "cup.and.saucer") ?? UIImage())
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
            Spacer(minLength: 20)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.system(.headline))
                Text("Roaster: \(item.roaster.name)")
                    .font(.system(.subheadline))
                    .lineLimit(1)
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Roast: \(String(item.roastLevel))")
                            .font(.system(.subheadline))
                            .lineLimit(1)
                        Text("Price: $\(String(item.price))")
                            .font(.system(.subheadline))
                    }
//                    .padding(EdgeInsets(top: 0, leading: /*-9*/0, bottom: 0, trailing: 0))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Origin: \(item.origin)")
                            .font(.subheadline)
                            .lineLimit(1)
                        
                    }
//                    .padding(EdgeInsets(top: 0, leading: /*-9*/0, bottom: 0, trailing: 0))
                }
                Text(item.description ?? "")
                    .font(.system(.caption))
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let coffee = Coffee(id: "123",
                        name: "Test Coffee",
                        roaster: Roaster(
                         id: "1234",
                         name: "Roaster A",
                         location: "Seattle"),
                        origin: "Colombia",
                        roastLevel: "Light",
                        description: "This is the best coffee you can get in the country, by far, the best in this continent",
                        price: 19,
                        availableQuantity: 100)
    CoffeeItemRow(item: coffee)
}
