//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Taeeun Kim on 29.10.21.
//  Copyright © 2021 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    
    var body: some View {
        VStack {
            AccountListView(accounts: accountSummaryVM.accounts)
            Text("\(accountSummaryVM.total.formatAsCurrency())")
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
