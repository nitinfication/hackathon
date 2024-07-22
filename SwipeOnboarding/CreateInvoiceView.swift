//
//  CreateInvoiceView.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI
import TipKit

struct Customer: Identifiable {
    let id = UUID()
    let name: String
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct CreateInvoiceView: View {
    @State private var selectedCustomer: Customer?
    @State private var selectedProduct: Product?
    @State private var isCustomerDropdownOpen = false
    @State private var isProductDropdownOpen = false
    @State private var addedProducts: [Product] = []
    @State private var total: Double = 0
    @Binding var shouldShowInvoice: Bool
    @State private var showCustomerTip = true
    @State private var showProductTip = false
    @State private var showCreateInvoiceTip = false
    
    let customers = [
        Customer(name: "Ved Prakash")
    ]
    
    let products = [
        Product(name: "Product A", price: 1999.82)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Invoice #001")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("19-07-2024")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        Text("INV-2425-252")
                            .font(.system(size: 15, weight: .bold))
                            .lineLimit(1)
                            .padding(.trailing, 64)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.bottom, 16)
                .padding(1)
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Customers")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        if showCustomerTip {
                            TipPromptView(
                                title: "Select a Customer",
                                message: "Choose a customer from the dropdown to start creating an invoice.",
                                onDismiss: { showCustomerTip = false }
                            )
                        }
                        
                        DropdownView(
                            placeholder: "Select Customer",
                            options: customers.map { $0.name },
                            selectedOption: selectedCustomer?.name,
                            isOpen: $isCustomerDropdownOpen,
                            onSelectOption: { selectedName in
                                selectedCustomer = customers.first(where: { $0.name == selectedName })
                                isCustomerDropdownOpen = false
                                showCustomerTip = false
                                showProductTip = true
                            }
                        )
                        
                        Text("Products")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 16)
                        
                        if showProductTip {
                            TipPromptView(
                                title: "Add Products",
                                message: "Select products to add to the invoice.",
                                onDismiss: { showProductTip = false }
                            )
                        }
                        
                        DropdownView(
                            placeholder: "Add Product",
                            options: products.map { $0.name },
                            selectedOption: selectedProduct?.name,
                            isOpen: $isProductDropdownOpen,
                            onSelectOption: { selectedName in
                                if let product = products.first(where: { $0.name == selectedName }) {
                                    addProduct(product)
                                    showProductTip = false
                                    showCreateInvoiceTip = true
                                }
                                isProductDropdownOpen = false
                            }
                        )
                        .disabled(selectedCustomer == nil)
                        
                        // Added Products List
                        ForEach(addedProducts) { product in
                            HStack {
                                Text(product.name)
                                Spacer()
                                Text("₹\(String(format: "%.2f", product.price))")
                                Button(action: {
                                    removeProduct(product)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(1)
            }
            
            Spacer()
            
            HStack {
                // Total Amount
                VStack(alignment: .leading, spacing: 0) {
                    Text("Total Amount")
                        .font(Font.system(size: 12, weight: .semibold))
                    HStack(alignment: .top, spacing: 0) {
                        Text("₹")
                            .font(Font.system(size: 8, weight: .bold))
                            .padding(.top, 2)
                        Text("\(String(format: "%.2f", total))")
                            .font(Font.system(size: 16, weight: .bold))
                    }
                }
                .foregroundColor(.black)
                Spacer()
                
                // Create Button
                Button(action: {
                    shouldShowInvoice = true
                }) {
                    HStack {
                        Text("Create")
                            .font(Font.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .font(Font.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Color("AccentColor"))
                    .cornerRadius(8)
                }
                .disabled(addedProducts.isEmpty)
            }
            
            if showCreateInvoiceTip {
                TipPromptView(
                    title: "Create Invoice",
                    message: "Click 'Create' to generate the invoice with the selected customer and products.",
                    onDismiss: { showCreateInvoiceTip = false }
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .onAppear {
            resetTips()
        }
    }
    
    private func addProduct(_ product: Product) {
        addedProducts.append(product)
        updateTotal()
    }
    
    private func removeProduct(_ product: Product) {
        if let index = addedProducts.firstIndex(where: { $0.id == product.id }) {
            addedProducts.remove(at: index)
            updateTotal()
        }
    }
    
    private func updateTotal() {
        total = addedProducts.reduce(0) { $0 + $1.price }
    }
    
    private func resetTips() {
        showCustomerTip = true
        showProductTip = false
        showCreateInvoiceTip = false
    }
}


struct CreateInvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateInvoiceView(shouldShowInvoice: .constant(false))
    }
}

extension View {
    func cardStyleLarge(backgroundColor: Color) -> some View {
        return padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
