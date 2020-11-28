import Foundation

public class ListNode {
    
    public var val: Int
    public var next: ListNode?
    
    public init() {
        self.val = 0;
        self.next = nil;
    }
    public init(_ val: Int) {
        self.val = val;
        self.next = nil;
        
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var num1 = l1
    var num2 = l2
    var divider = 0
    var result = [ListNode?]()
    
    while true {
        
        guard (num1 != nil || num2 != nil) else {
            if let last = result.last, divider > 0 {
                let temp = ListNode(divider)
                last?.next = temp
                result.append(temp)
            }
            break
        }
        
        let sum = (num1?.val ?? 0) + (num2?.val ?? 0) + divider
        let (q, d) = sum.quotientAndRemainder(dividingBy: 10)
        
        let temp = ListNode(d)
        divider = (q == 0) ? 0 : q
        
        if let last = result.last {
            last?.next = temp
        }
        
        result.append(temp)
        
        num1 = num1?.next
        num2 = num2?.next
    }
    
    return result.first ?? nil
}


//let l1_6 = ListNode(9, nil)
//let l1_5 = ListNode(9, l1_6)
//let l1_4 = ListNode(9, l1_5)
//let l1_3 = ListNode(9, l1_4)
//let l1_2 = ListNode(9, l1_3) //9
//let l1_1 = ListNode(9, l1_2) //9
//let l1 = ListNode(9, l1_1) //8
//
//let l2_3 = ListNode(9, nil)
//let l2_2 = ListNode(9, l2_3)
//let l2_1 = ListNode(9, l2_2)
//let l2 = ListNode(9, l2_1)


let l1_2 = ListNode(3, nil) //9
let l1_1 = ListNode(4, l1_2) //9
let l1 = ListNode(2, l1_1) //8

let l2_2 = ListNode(4, nil)
let l2_1 = ListNode(6, l2_2)
let l2 = ListNode(5, l2_1)


var res = addTwoNumbers(l1, l2)
var num = res

while num?.next != nil {
    print(num?.val)
    num = num?.next
}

print(num?.val)
