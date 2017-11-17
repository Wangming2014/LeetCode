//: Playground - noun: a place where people can play

import UIKit

//class ListNode {
//    var val: Int
//    var next: ListNode?
//    init(_ val: Int) {
//        self.val = val
//        self.next = nil
//    }
//}
//
//class Solution {
//
//    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
//        // 1.判断两个链表是否都为nil，若都为nil，则直接返回nil
//        // 2.判断是否有一个链表为nil，若有一个为nil，则直接返回另一个链表
//        // 3.声明一个节点(returnListNode)，用于保存链表的首节点，作为返回值
//        //  声明一个节点(previousNode)，用于保存上一个节点
//        //  声明一个变量(shiwei)，用于保存节点相加的结果的十位数
//        // 4.while循环，同时遍历两个链表，直到遍历完两个链表时，结束循环
//        //      声明两个ListNode变量(iterate1,iterate2)，并赋初始值为对应链表的首节点，用于遍历两个链表
//        //      对两个链表的当前节点中的值相加，再加上shiwei，得到sum，进而得到sum的个位(sum%10)和十位(sum/10)
//        //      使用sum的个位初始化一个node，判断previousNode是否为nil，若为nil，则将这个node作为返回链表的首节点，若不为nil，则将这个node作为previousNode的next节点，注意两种情况下，最后都要将node赋值给previousNode
//        //      更新iterate1，iterate2的值
//        // 5.判断shiwei是否有值(>0)，若>0，则使用shiwei初始化一个node，并做为previousNode的next节点
//        // 6.返回结果链表
//        
//        if l1 == nil && l2 == nil {
//            return nil
//        }
//        guard let l1 = l1 else { return l2 }
//        guard let l2 = l2 else { return l1 }
//        
//        var returnListNode: ListNode? = nil
//        var previousNode: ListNode? = nil
//        var shiwei: Int = 0
//        
//        var iterate1: ListNode? = l1
//        var iterate2: ListNode? = l2
//        
//        while iterate1 != nil || iterate2 != nil {
//            let sum = (iterate1?.val ?? 0) + (iterate2?.val ?? 0) + shiwei
//            let gewei = sum % 10
//            shiwei = sum / 10
//            let currentNode = ListNode(gewei)
//            if previousNode == nil {
//                returnListNode = currentNode
//                previousNode = currentNode
//            } else {
//                previousNode?.next = currentNode
//                previousNode = currentNode
//            }
//            
//            iterate1 = iterate1?.next
//            iterate2 = iterate2?.next
//        }
//        
//        if shiwei > 0 {
//            previousNode?.next = ListNode(shiwei)
//        }
//        return returnListNode
//    }
//}
//
//let node0 = TreeNode(7)
//let node1 = TreeNode(15)
//let node2 = TreeNode(20)
//node2.left = node1
//node2.right = node0
//let node3 = TreeNode(9)
//let node4 = TreeNode(3)
//node4.left = node3
//node4.right = node2
//
//let solution = Solution()
//solution.levelOrder(node4)
//solution.levelOrderBottom(node4)
//let res = solution.levelOrder(node4).flatMap { $0 }
//res
//
//
//let node10 = ListNode(2)
//var previousNode = node10
//let node11 = ListNode(4)
//previousNode.next = node11
//previousNode = node11
//let node12 = ListNode(1)
//previousNode.next = node12
//previousNode = node12
//node10.val
//node10.next?.val
//node10.next?.next?.val
//
////node10.next = node11
////node11.next = node12
//
//let node20 = ListNode(5)
//let node21 = ListNode(6)
//
//let node22 = ListNode(1)
//let node23 = ListNode(9)
//node20.next = node21
//node21.next = node22
//node22.next = node23
//node20.val
//node20.next?.val
//node21.next?.val
//
//let results = solution.addTwoNumbers(node20, node20)
//var iterate = results
//while let element = iterate {
//    print(element.val, terminator:(element.next != nil ? "-->" : "\n"))
//    iterate = element.next
//}
//print("------")


example("Binary search") {
    let res = MySolution.binarySearch(2, for: [1, 2])
    print(res)
}

example("Bubble sort") {
    let res = MySolution.bubbleSort([8, 2, 1, 1, 10, 9, 3, 10, 5])
    print(res)
}

example("Invert tree") {
    let node20 = TreeNode(9)
    let node21 = TreeNode(6)
    let node22 = TreeNode(3)
    let node23 = TreeNode(1)
    
    let node10 = TreeNode(7)
    node10.left = node20
    node10.right = node21
    let node11 = TreeNode(2)
    node11.left = node22
    node11.right = node23
    
    let root = TreeNode(4)
    root.left = node10
    root.right = node11
    
    let res = MySolution.invertTree(root)
    
    var currentNode = res!
    print(currentNode.val)
    print(currentNode.left!.val, currentNode.right!.val)
    
    currentNode = currentNode.left!
    let rightNode = (res?.right)!
    print(currentNode.left!.val, currentNode.right!.val, rightNode.left!.val, rightNode.right!.val)
    
    
}

example("Invert tree 2") {
    let node10 = TreeNode(7)
//    node10.left = node20
//    node10.right = node21
    let node11 = TreeNode(2)
//    node11.left = node22
//    node11.right = node23
    
    let root = TreeNode(4)
    root.left = node10
    root.right = node11
    
    MySolution.invertTree2(root)
}

example("Tree sum") {
    let node20 = TreeNode(9)
    let node21 = TreeNode(6)
    let node22 = TreeNode(3)
    let node23 = TreeNode(1)
    
    let node10 = TreeNode(7)
    node10.left = node20
    node10.right = node21
    let node11 = TreeNode(2)
    node11.left = node22
    node11.right = node23
    
    let root = TreeNode(4)
    root.left = node10
    root.right = node11
    
    MySolution.nodeSum(root)
    
}

example("tree2str") {
    let node20 = TreeNode(9)
    let node21 = TreeNode(6)
    let node22 = TreeNode(3)
    let node23 = TreeNode(1)
    
    let node10 = TreeNode(7)
    node10.left = node20
    node10.right = node21
    let node11 = TreeNode(2)
    node11.left = node22
    node11.right = node23
    
    let root = TreeNode(4)
    root.left = node10
    root.right = node11
    
    MySolution.tree2str(root)
}

example("sumOfLeftLeaves") {
//    let node20 = TreeNode(9)
//    let node21 = TreeNode(6)
    let node22 = TreeNode(15)
    let node23 = TreeNode(7)
    
    let node10 = TreeNode(9)
//    node10.left = node20
//    node10.right = node21
    let node11 = TreeNode(20)
    node11.left = node22
    node11.right = node23
    
    let root = TreeNode(3)
    root.left = node10
    root.right = node11
    
    MySolution.sumOfLeftLeaves(root)

}

example("levelOrderBottom2") {
    let node20 = TreeNode(9)
    let node21 = TreeNode(6)
    let node22 = TreeNode(3)
    let node23 = TreeNode(1)
    
    let node10 = TreeNode(7)
    node10.left = node20
    node10.right = node21
    let node11 = TreeNode(2)
    node11.left = node22
    node11.right = node23
    
    let root = TreeNode(4)
    root.left = node10
    root.right = node11
    
    MySolution.levelOrderBottom2(root)
    
}

example("Insertion Sort") {
    let array = [10, 5, 9, 4, 8, 3, 7, 2, 6, 1]
    let res = MySolution.insertionSort(array)
    print(res)    
}

example("Quick Sort") {
    var array = [10, 5, 9, 4, 8, 3, 7, 2, 6, 1, 10, 1]
    MySolution.quickSort(&array)
    print(array)
}





