//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Alexandre Gravelle on 2021-03-12.
//

import SwiftUI

struct CoursesView: View {
    @State var show = false
    @Namespace var namespace
    @State var selectedItem: Course? = nil
    @State var isDisabled = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16
                ) {
                    ForEach(courses) { item in
                        VStack {
                            CourseItem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                        show.toggle()
                                        selectedItem = item
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .zIndex(1)
            
            if let selectedItem = self.selectedItem {
                ZStack(alignment: .topTrailing) {
                    VStack {
                        ScrollView {
                            CourseItem(course: selectedItem)
                                .matchedGeometryEffect(id: selectedItem.id, in: namespace)
                                .frame(height: 300)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        show.toggle()
                                        self.selectedItem = nil
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            isDisabled = false
                                        }
                                    }
                                }
                            VStack(spacing: 8) {
                                ForEach(0 ..< 20) { item in
                                    CourseRow()
                                }
                            }
                            .padding()
                        }
                    }
                    .background(Color("Background 1"))
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    .matchedGeometryEffect(id: "container\(selectedItem.id)", in: namespace)
                    .edgesIgnoringSafeArea(.all)
                    
                    
                    CloseButton()
                        .padding(.trailing, 16)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                show.toggle()
                                self.selectedItem = nil
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isDisabled = false
                                }
                            }
                        }
                }
                .zIndex(2)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
