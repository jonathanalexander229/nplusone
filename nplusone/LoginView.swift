//
//  LoginView.swift
//  nplusone
//
//  Created by clutchcoder on 11/4/24.
//

import SwiftUI
import CoreData
struct LoginView: View {
    
    @EnvironmentObject var auth: Auth
    
    @State private var isLoading = false
    @State private var username: String = ""
    @State private var newUser: User?
    @State private var password: String = ""
    
    @State private var showUsers = true
    
    
    var body: some View {
        Group {
            if auth.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityIdentifier("Progress")
            } else {
                VStack(spacing: 20) {
                    Text("NplusONE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: "bicycle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .cornerRadius(30)
                        .shadow(color: .gray, radius: 1, x: 5, y: 5)
                    
                    Text("Username")
                        .frame(alignment: .leading)
                    
                    TextField("", text: $username)
                        .font(.headline)
                        .frame(width: 200)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("UsernameTextField")
                    
                    Button(action: {
                        isLoading = true
                        debugPrint("Login Button Tapped!")
                        auth.login(username: username) { success in
                                             
                        }
                    })
                    {
                        Text("Login")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    }
                    
                }
        }
        }
    }



#Preview {
    LoginView()
}
