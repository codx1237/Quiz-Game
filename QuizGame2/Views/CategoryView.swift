//
//  CategoryView.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import SwiftUI

struct CategoryView: View {
    
    var categories: [Category]
    @Binding var selectedCategory: Category
    
    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                        ForEach(0..<2) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[i].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                        }
                }
                
                GridRow {
                    ForEach(2..<4) { i in
                        Button(action: {
                            selectedCategory = categories[i]
                        }, label: {
                            Text(categories[i].name)
                                .padding()
                                .frame(width:190,height: 100)
                                .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                .cornerRadius(20)
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .bold()
                        })
                    }
                }
                
                GridRow {
                        ForEach(4..<6) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[i].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                        }
                }
                 
                GridRow {
                        ForEach(6..<8) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[i].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                        }
                }
                
                GridRow {
                        ForEach(8..<10) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[i].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                        }
                }
                
                GridRow {
                        ForEach(10..<12) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[i].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                        }
                }
                
                GridRow {
                        ForEach(12..<13) { i in
                            Button(action: {
                                selectedCategory = categories[i]
                            }, label: {
                                Text(categories[12].name)
                                    .padding()
                                    .frame(width: 190,height: 100)
                                    .background(selectedCategory.name == categories[i].name ? Color.green : Color.orange)
                                    .cornerRadius(20)
                                    .foregroundStyle(Color.white)
                                    .font(.title2)
                                    .bold()
                                   
                            })
                            
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 190,height: 100)
                                .cornerRadius(20)
                            
                        }
                }
                
                 
            }
        }
    }
}


