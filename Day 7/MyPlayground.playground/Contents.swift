import UIKit

class Pokemon: CustomDebugStringConvertible {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var debugDescription: String { return "<Pokemon \(name)>" }
    
    deinit { print("\(self) escaped!") }
    
    func delay(_ seconds: Int, closure: @escaping ()->()) {
        let time = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: time) {
            print("🕑")
            closure()
        }
    }
    
    func demo1() {
      let pokemon = Pokemon(name: "Mewtwo")
      print("before closure: \(pokemon)")
      delay(1) {
        print("inside closure: \(pokemon)")
      }
      print("bye")
    }
    
    func demo2() {
      var pokemon = Pokemon(name: "Pikachu")
      print("before closure: \(pokemon)")
      delay(1) {
        print("inside closure: \(pokemon)")
      }
      pokemon = Pokemon(name: "Mewtwo")
      print("after closure: \(pokemon)")
    }
    
    func demo7() {
      var pokemon = Pokemon(name: "Mew")
      print("➡️ Initial pokemon is \(pokemon)")

      delay(1) { [capturedPokemon = pokemon] in
        print("closure 1 — pokemon captured at creation time: \(capturedPokemon)")
        print("closure 1 — variable evaluated at execution time: \(pokemon)")
        pokemon = Pokemon(name: "Pikachu")
        print("closure 1 - pokemon has been now set to \(pokemon)")
      }

      pokemon = Pokemon(name: "Mewtwo")
      print("🔄 pokemon changed to \(pokemon)")

      delay(2) { [capturedPokemon = pokemon] in
        print("closure 2 — pokemon captured at creation time: \(capturedPokemon)")
        print("closure 2 — variable evaluated at execution time: \(pokemon)")
        pokemon = Pokemon(name: "Charizard")
        print("closure 2 - value has been now set to \(pokemon)")
      }
    }
}




var test = Pokemon(name: "Test")
test.demo7()
