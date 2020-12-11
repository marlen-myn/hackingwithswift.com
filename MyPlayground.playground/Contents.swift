import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let result = ListNode(0)
    var nextL1 = l1
    var nextL2 = l2
    
    while nextL1?.next != nil || nextL2?.next != nil {
        
        guard nextL1?.val != nil && nextL2?.val != nil else {
            result.next = nextL1?.val != nil ? nextL1 : nextL2
            nextL1 = nextL1?.next
            nextL2 = nextL2?.next
            return result.next
        }
        
        if nextL1!.val < nextL2!.val {
            result.next = nextL1
            nextL1 = nextL1?.next
        } else {
            result.next = nextL2
            nextL2 = nextL2?.next
        }
        
        result.next = (l1?.next != nil) ? l1 : l2
    }
    
    return result.next
}

let c = ListNode(4)
let b = ListNode(2,c)
let a = ListNode(1,b)

let f = ListNode(4)
let e = ListNode(3,f)
let d = ListNode(1,e)

var s = mergeTwoLists(a,d)
print(s?.val)
print(s?.next?.val)
print(s?.next?.next?.val)
print(s?.next?.next?.next?.val)
