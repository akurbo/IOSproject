//
//  TestResultView.swift
//  EasyEnglish
//
//  Created by Kurbatov Artem on 05.07.2021.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var correct: Int
    
    var percent: Float {
        guard model.currentModule != nil else {
            return 0
        }
        return Float(correct)/Float(model.currentModule!.test.questions.count)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 1)
                
                VStack {
                    Text("Ваш результат:")
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                        
                        .padding(.top, 10)
                    
                    ZStack{
                        ProgressBarView(progress: percent, lineWidth: 10.0)
                            .frame(width: 75, height: 75, alignment: .center)
                        
                        Text(String(format: "%.0f %%", percent * 100))
                            .foregroundColor(.black)
                            .bold()
                            .font(.title3)
                    }
                    .padding(10)
                    
                    Divider().background(Color.black)
                    
                    Spacer()
                    
                    HStack(spacing: 100) {
                        VStack{
                            Text("Верно:")
                                .foregroundColor(.black)
                                .padding(.bottom, 5)
                            Text("\(correct)")
                                .foregroundColor(.green)
                        }
                        .font(.title3)
                        
                        VStack{
                            Text("Неверно:")
                                .foregroundColor(.black)
                                .padding(.bottom, 5)
                            Text("\((model.currentModule?.test.questions.count ?? 0) - correct)")
                                .foregroundColor(.red)
                        }
                        .font(.title3)
                    }
                    Spacer()
                }
            }
            .frame(width: 350, height: 200)
            
            Spacer()
            
            Button {
                model.saveData(title: model.currentModule?.category ?? "", percent: percent)
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .frame(height: 48)
                    
                    Text("Завершить тест")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .padding(.top, 50)
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView(correct: 10)
            .environmentObject(ContentModel())
    }
}
