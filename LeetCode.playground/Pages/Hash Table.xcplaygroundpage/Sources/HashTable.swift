import Foundation

public func findWords(_ words: [String]) -> [String] {
    
    func hashCode(_ char: String) -> Int {
        let row0 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        let row1 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
        let row2 = ["Z", "X", "C", "V", "B", "N", "M"]
        let uppercased = char.uppercased()
        if row0.index(of: uppercased) != nil {
            return 0
        }
        if row1.index(of: uppercased) != nil {
            return 1
        }
        if row2.index(of: uppercased) != nil {
            return 2
        }
        return -1
    }
    
    
    var returnValue: [String] = []
    
    for word in words {
        var set: Set<Int> = []
        for char in word {
            let code = hashCode(String(char))
            set.insert(code)
        }
        if set.count == 1 {
            returnValue.append(word)
        }
    }
    
    return returnValue
}


// Employee info
public class Employee {
    public var id: Int
    public var importance: Int
    public var subordinates: [Int]
    
    public init(id: Int, importance: Int, subordinates: [Int]) {
        self.id = id
        self.importance = importance
        self.subordinates = subordinates
    }
}

public func getImportance(employees: [Employee], id: Int) -> Int {
    let ids = employees.map { $0.id }
    guard let index = ids.index(of: id) else {
        return 0
    }
    let employee = employees[index]
    var returnValue = employee.importance
    for subordinate in employee.subordinates {
        if let index = ids.index(of: subordinate) {
            returnValue += employees[index].importance
        }
    }
    
    return returnValue
}

public func numIslands(_ grid: [[Character]]) -> Int {
    guard !grid.isEmpty && !grid.first!.isEmpty else {
        return 0
    }
    
    let n = grid.count
    let m = grid.first!.count
    
    func DFSMarking(_ grids: inout [[Character]], _ i: Int, _ j: Int) {
        if i < 0 || j < 0 || i >= n || j >= m {
            return
        }
        if grids[i][j] != "1" {
            return
        }
        grids[i][j] = "0"
        DFSMarking(&grids, i + 1, j)
        DFSMarking(&grids, i - 1, j)
        DFSMarking(&grids, i, j + 1)
        DFSMarking(&grids, i, j - 1)
    }
    
    var mutableGrid = grid // 后面都要使用mutableGrid这个可变版本的
    var returnValue = 0
    for i in 0..<n {
        for j in 0..<m {
            if mutableGrid[i][j] == "1" {
                DFSMarking(&mutableGrid, i, j)
                returnValue += 1
            }
        }
    }
    return returnValue
}

// ^(按位异或): 相同为0，不同为1，可交换的
// https://discuss.leetcode.com/topic/1916/my-o-n-solution-using-xor
public func singleNumber(_ nums: [Int]) -> Int {
    var returnValue = 0
    for num in nums {
        returnValue ^= num
    }
    return returnValue
}

// LeetCode上使用^(按位异或)实现的版本
// https://discuss.leetcode.com/topic/55912/java-solution-using-bit-manipulation
public func findTheDifference(_ s: String, _ t: String) -> Character {
    guard t.count > s.count else {
        return "0"
    }
    let setS = Set(Array(s))
    let setT = Set(Array(t))
    return setT.symmetricDifference(setS).first ?? "0"
}

public func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    return Array(Set(nums1).intersection(nums2))
}

// https://leetcode.com/problems/valid-anagram/description/
public func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else {
        return false
    }
    var t = t
    for char in s {
        if let i = t.index(of: char) {
            t.remove(at: i)
        }
    }
    return t.count == 0
}

// 参考：https://discuss.leetcode.com/topic/20314/accepted-java-o-n-solution-in-5-lines/3
public func isAnagram2(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else {
        return false
    }
    var alphabet: [Int] = Array(repeating: 0, count: 26)
    let start = Character("a").unicodeScalarCodePoint
    for char in s {
        let i = Int(char.unicodeScalarCodePoint - start)
        alphabet[i] += 1
    }
    for char in t {
        let i = Int(char.unicodeScalarCodePoint - start)
        guard alphabet[i] != 0 else {
            return false
        }
        alphabet[i] -= 1
    }
    return true
}

public func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
    var dictionary: [String: Int] = [:]
    for (i, key) in list1.enumerated() {
        dictionary[key] = i
    }
//    for (i, key) in list2.enumerated() {
//        if dictionary[key] != nil {
//            dictionary[key]! += i
//            dictionary[key]! += 1000
//        }
//    }
//    dictionary = dictionary.filter { $1 >= 1000 }
//    let array = Array(dictionary)
//    var min = array.first!
//    var returnValue: [String] = []
//    for element in array {
//        if element.value < min.value {
//            min = element
//            returnValue.removeAll()
//            returnValue.append(min.key)
//        } else if element.value == min.value {
//            returnValue.append(element.key)
//        } else {
//        }
//    }
//    return returnValue
    
    // 上面注释部分可以简化一下
    var returnValue: [String] = []
    var minSum = list1.count + list2.count
    for (i, key) in list2.enumerated() {
        if let index = dictionary[key] {
            if index + i <= minSum {
                if index + i < minSum {
                    minSum = index + i
                    returnValue.removeAll()
                }
                returnValue.append(key)
            }
        }
    }
    return returnValue
}

public func longestPalindrome(_ s: String) -> Int {
    var dictionary: [Character: Int] = [:]
    for char in s {
        if dictionary[char] == nil {
            dictionary[char] = 1
        } else {
            dictionary[char]! += 1
        }
    }
    var returnValue = 0
    var flag = false
    for (_, value) in dictionary {
        if value % 2 == 0 {
            returnValue += value
        } else if value / 2 >= 1 {
            returnValue += value / 2 * 2
            flag = true
        } else {
            flag = true
        }
    }
    if flag {
        returnValue += 1
    }
    return returnValue
}

// 这个思路是对的，但是性能太低，不能通过测试
public func numberOfBoomerangs(_ points: [[Int]]) -> Int {
    func distance(from: [Int], to: [Int]) -> Int {
        let xDistance = from[0] - to[0] // x方向上的距离
        let yDistance = from[1] - to[1] // y方向上的距离
        return xDistance * xDistance + yDistance * yDistance
    }
    
    func combination(_ count: Int) -> Int {
        guard count > 0 else {
            return 0
        }
        return combination(count - 1) + count - 1
    }
    
    var returnValue = 0
    var dictionary: [Int: [Int]] = [:]
    for i in 0..<points.count {
        let start = i + 1
        for j in start..<points.count {
            let dis = distance(from: points[i], to: points[j])
            if dictionary[i] == nil {
                dictionary[i] = []
            }
            if dictionary[j] == nil {
                dictionary[j] = []
            }
            dictionary[i]!.append(dis)
            dictionary[j]!.append(dis)
        }
        if let array = dictionary[i] {
            var map: [Int: Int] = [:]
            for value in array {
                if map[value] == nil {
                    map[value] = 1
                } else {
                    returnValue -= combination(map[value]!)
                    map[value]! += 1
                    returnValue += combination(map[value]!)
                }
            }
        }
    }
    return returnValue * 2
}

// 优化后的
// 参考：https://discuss.leetcode.com/topic/66587/clean-java-solution-o-n-2-166ms
public func numberOfBoomerangs2(_ points: [[Int]]) -> Int {
    func distance(from: [Int], to: [Int]) -> Int {
        let xDistance = from[0] - to[0] // x方向上的距离
        let yDistance = from[1] - to[1] // y方向上的距离
        return xDistance * xDistance + yDistance * yDistance
    }
    
    var returnValue = 0
    var dictionary: [Int: Int] = [:] // key为两个点之间的距离，value为相同的距离的个数
    for i in 0..<points.count {
        for j in 0..<points.count {
            if i == j { continue }
            let dis = distance(from: points[i], to: points[j])
            dictionary[dis] = (dictionary[dis] ?? 0) + 1
        }
        for value in dictionary.values {
            returnValue += value * (value - 1) // 这里不用使用递归去计算组合的个数，在组合的个数乘以2后(因为在上面我们最终的结果也乘以2了)，我们可以发现这个规律
        }
        dictionary.removeAll()
    }
    return returnValue
}

// 202.HappyNumber
public func isHappy(_ n: Int) -> Bool {
    
    // 可以在计算digit的同时，把sum计算出来
    func sumOfDigits(_ n: Int) -> Int {
        var sum = 0
        var tmp = n
        while tmp > 0 {
            let digit = tmp % 10
            sum += digit * digit
            tmp = tmp / 10
        }
        return sum
    }
    
    // 这种方式没法结束递归，因为sum可能永远不会小于10
//     func recursive(_ n: Int) -> Int {
//         let sum = sumOfDigits(n)
//         guard sum >= 10 else {
//             return sum
//         }
//         return recursive(sum)
//     }
    
    // 方法一
    // 参考Linked List Cycle算法的思想: https://segmentfault.com/a/1190000003718848
    // 一个慢指针，一个快指针，慢指针一次走一步，快指针一次走两步，二者从同一位置出发
    // 若是一个链表环，由于快指针走的快，总会赶上慢指针。
    // 应用到这里，若slow与fast相等，说明sumOfDigits得到的值是处于一个环中(总是那么几个值)，那么就应该结束循环
//    var slow = n
//    var fast = n
//    repeat {
//        slow = sumOfDigits(slow)
//        fast = sumOfDigits(sumOfDigits(fast))
//    } while slow != fast
//
//    return slow == 1
    
    
    // 方法二
    var set: Set<Int> = []
    var tmp = n
    // insert()方法返回一个元组，第一个值表示是否成功
    // 若set中已经存在相同的元素了，那么返回的元组一个值就为false
    while set.insert(tmp).0 {
        let sum = sumOfDigits(tmp)
        if sum == 1 {
            return true
        } else {
            tmp = sum
        }
    }
    return false
}








// Extension
// https://stackoverflow.com/questions/24102044/how-can-i-get-the-unicode-code-points-of-a-character
public extension Character {
    public var unicodeScalarCodePoint: UInt32 {
        get {
            return unicodeScalars.first!.value
        }
    }
}








