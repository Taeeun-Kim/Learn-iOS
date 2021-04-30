//
//  ContentView.swift
//  Carousel List
//
//  Created by Kavsoft on 09/04/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

// Code is Updated For Even Length Data

import SwiftUI

struct ContentView: View {
    var body: some View {
           
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
    
    @State var data = [

        Card(id: 0, img: "p1", name: "Jill"),
        Card(id: 1, img: "p2", name: "Emma"),
        Card(id: 2, img: "p3", name: "Catherine"),
        Card(id: 3, img: "p4", name: "iJustine"),
        Card(id: 4, img: "p5", name: "Juliana"),
        Card(id: 5, img: "p6", name: "Lilly"),
        Card(id: 6, img: "p7", name: "Emily")

    ]
    
    var body : some View{
        
        NavigationView{
            
            VStack{
                
                Spacer()
                
                HStack(spacing: 15){
                    
                    ForEach(data){i in
                        
                        CardView(data: i)
                        .offset(x: self.x)
                        .highPriorityGesture(DragGesture()
                        
                            .onChanged({ (value) in
                                
                                // 1. 오른쪽으로 조금이라도 드래그하면 (positive)
                                // 2. 왼쪽으로 조금이라도 드래그하면 (negative)
                                if value.translation.width > 0{
                                    self.x = value.location.x
                                }
                                else{
                                    self.x = value.location.x - self.screen
                                }
                                
                            })
                            .onEnded({ (value) in
                                // 오른쪽으로 조금이라도 드래그하면 (positive)
                                if value.translation.width > 0{
                                    
                                    // screen = UIScreen.main.bounds.width - 30
                                    // 1. 카드를 일정이상 드래그하면
                                    // 2. 카드의 count가 0이 아니라면, 즉 왼쪽에 카드가 더이상 없으면, 드래그가 더이상 안되야 함
                                    if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                        
                                        self.count -= 1
//                                        self.updateHeight(value: Int(self.count))
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                    else{
                                        
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                }
                                // 왼쪽으로 조금이라도 드래그하면 (negative)
                                else{
                                    
                                    
                                    if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
                                        
                                        self.count += 1
//                                        self.updateHeight(value: Int(self.count))
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                    else{
                                        
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                }
                            })
                        )
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .offset(x: self.op)
                
                Spacer()
            }
            .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.bottom))
            .navigationBarTitle("Carousel List")
            .animation(.spring())
            .onAppear {
                
                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
                
//                self.data[0].show = true
            }
        }
    }
    
//    func updateHeight(value : Int){
//
//
//        for i in 0..<data.count{
//
//            data[i].show = false
//        }
//
//        data[value].show = true
//    }
}

struct CardView : View {
    
    var data : Card
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 0){
            
            Image(data.img)
            .resizable()
            
            Text(data.name)
                .fontWeight(.bold)
                .padding(.vertical, 13)
                .padding(.leading)
            
        }
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct Card : Identifiable {
    
    var id : Int
    var img : String
    var name : String
//    var show : Bool
}


