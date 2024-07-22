//
//  OnboardingMain.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI


struct OnboardingMain: View {
    @Namespace var namespace
    let middle = [" Invoices,", " Payments,", " Purchases,", " Inventory,", " Reports,", " GST,", " Analytics,", " Online Store,"," Payments,", " Inventory,", " Reports,", " Online Store,", "Inventory,", " Analytics,"]
     let end = ["Pro Forma, Quotations, Credit Notes, Debit Notes, Purchase Order, Delivery Challan, Payments,",
           "UPI, Cards, Net Banking, Cash, Cheque, EMI, TDS,",
           "Expenses, Vendors, Purchase Order,",
           "Barcode, Stock In, StockOut,",
           "GSTR-1, TDS, JSON,",
           "E-WayBills, E-Invoicing, Billing,",
           "Profit & Loss, Tracked,", "Ecommerce, Products,",
           "Pro Forma, Quotations, Credit Notes, Debit Notes, Purchase Order, Delivery Challan, Payments,",
           "Expenses, Vendors, Purchase Order,",
           "Barcode, Stock In, StockOut,",
           "UPI, Cards, Net Banking, Cash, Cheque, EMI, TDS,",
           "Pro Forma, Quotations, Credit Notes, Debit Notes, Purchase Order, Delivery Challan, Payments,", "E-WayBills, E-Invoicing, Billing,"]
    
    @State private var isShowAnimation = false
    @State private var shouldShowBottomSheet = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            if shouldShowBottomSheet {
                OnboardingInvoiceCreation(namespace: namespace)
            } else {
                StartingOnboardingView()
            }
        }
        .statusBar(hidden: true)
    }
    
    func StartingOnboardingView() -> some View {
        return ZStack {
            // Marquee
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    if isShowAnimation {
                        ForEach(0..<middle.count, id: \.self) { index in
                            MarqueeView {
                                HStack(spacing: 12) {
                                    Text(middle[index])
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.black)
                                    
                                    Text(end[index])
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.black.opacity(0.4))
                                }
                            }
                            .frame(height: 40)
                            .transition(getIndexTransition(index))
                        }
                    }
                    Spacer()
                }
            }
            .opacity(0.3)
            
            Image("logo")
                .resizable()
                .frame(width: 150, height: 100)
                .matchedGeometryEffect(id: "logo", in: namespace)
            
            VStack(spacing: 16) {
                Spacer()
                GetStartedButton(buttonText: "Get Started", shouldShowBottomSheet: $shouldShowBottomSheet)
                    .matchedGeometryEffect(id: "startButton", in: namespace)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                isShowAnimation = true
            }
        }
        .padding(.vertical, 48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
    
    func getIndexTransition(_ index: Int) -> AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ).animation(.easeInOut(duration: 0.5).delay(Double(index) * 0.3))
    }
}

#Preview {
    OnboardingMain()
}
