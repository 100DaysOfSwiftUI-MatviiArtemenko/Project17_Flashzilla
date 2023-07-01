//
//  EditCards.swift
//  Project17_Flashzilla
//
//  Created by admin on 09/03/2023.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var keyString = "Cards"

    @State private var cards = [Card]()
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt:", text: $newPrompt)
                    TextField("Answer:", text: $newAnswer)
                    
                    Button("Add card", action: addCard)
                }
                Section {
                    ForEach(0 ..< cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }

    func done() { dismiss() }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: keyString) {
            do {
                let decoded = try JSONDecoder().decode([Card].self, from: data)
                cards = decoded
            } catch {
                print("error loading data: \(error.localizedDescription)")
            }
        }
    }

    func saveData() {
        do {
            let encoded = try JSONEncoder().encode(cards)
            UserDefaults.standard.set(encoded, forKey: keyString)
        } catch {
            print("error encoding data: \(error.localizedDescription)")
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard !trimmedAnswer.isEmpty && !trimmedPrompt.isEmpty else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        withAnimation {
            newPrompt = ""
            newAnswer = ""
        }
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
