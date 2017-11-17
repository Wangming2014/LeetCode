import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
    }
}

public class MySolution {
    
    public init() {
        
    }
    
    /// 冒泡排序
    /// 这里按升序排列
    /// 时间复杂度：O(n^2)
    public static func bubbleSort(_ array: Array<Int>) -> Array<Int> {
        var returnValue = array
        for i in 0..<returnValue.count {
            for j in 0..<returnValue.count - i - 1 {
                if returnValue[j] > returnValue[j + 1] {
                    let tmp = returnValue[j + 1]
                    returnValue[j + 1] = returnValue[j]
                    returnValue[j] = tmp
                }
            }
        }
        return returnValue
    }
    
    
    /// 二分法查找
    /// 时间复杂度为：O(log n)——对数时间复杂度
    /// - Parameters:
    ///   - value: 要查找的值
    ///   - array: 有序数组，这里以升序排列
    /// - Returns: 要查找的值在数组中的下标，若查找不到，则返回-1
    public static func binarySearch(_ value: Int, for array: Array<Int>) -> Int {
        guard array.count > 0 else {
            return -1
        }
        var result = -1
        var start = 0
        var end = array.count - 1
        while start <= end {
            let center = start + ((end - start) / 2)
            if value > array[center] {
                start = center + 1
            } else if value < array[center] {
                end = center - 1
            } else {
                result = center
                break
            }
        }
        return result
    }
    
    
    /// 翻转二叉树
    /// 迭代法，按层翻转
    /// 时间复杂度：O(n)
    /// - Parameter root: 二叉树根节点
    /// - Returns: 翻转后的二叉树根节点
    public static func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var currentLevel:Array<TreeNode> = [root]
        while !currentLevel.isEmpty {
            var nextLevel:Array<TreeNode> = []
            for node in currentLevel {
                // invert
                let tmpNode = node.left
                node.left = node.right
                node.right = tmpNode
                
                if let left = node.left {
                    nextLevel.append(left)
                }
                if let right = node.right {
                    nextLevel.append(right)
                }
            }
            
            currentLevel = nextLevel
        }
        return root;
    }
    
    /// LeetCode上效率最高的算法
    /// 递归法，自下而上的交换
    /// 时间复杂度: O(n)
    public static func invertTree2(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else {
            return nil
        }
        
        let left = invertTree2(node.left)
        let right = invertTree2(node.right)
        
        node.left = right
        node.right = left
        
        return node
    }
    
    
    /// 找出二叉树中最长的一条路径
    /// 我实现的是BFS(宽度优先搜索算法):逐层便利二叉树
    /// 这可使用先进先出队列这一数据结构来实现该算法
    /// 相比我的做法，可以省去一个中间数组(我的做法也是BFS)
    /// 这里直接用数组来代替队列
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var returnValue: Int = 0
//        var currentLevel: Array<TreeNode> = [root]
//        while !currentLevel.isEmpty {
//            returnValue += 1
//            var nextLevel: Array<TreeNode> = []
//            for node in currentLevel {
//                if let left = node.left {
//                    nextLevel.append(left)
//                }
//                if let right = node.right {
//                    nextLevel.append(right)
//                }
//            }
//            currentLevel = nextLevel
//        }
        
        var queue: Array<TreeNode> = [root]
        while !queue.isEmpty {
            returnValue += 1
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        
        return returnValue
    }
    
    /// DFS
    /// 做为一个DFS的例子，在这个例子中，使用DFS并不是一个好的注意
    func maxDepth2(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var maxValue: Int = 0
        var stack: Array<TreeNode> = []
        var value: Array<Int> = [] // stack
        stack.append(root) // push
        value.append(1)
        while !stack.isEmpty {
            let tmp = value.removeLast() // pop
            maxValue = max(tmp, maxValue)
            let node = stack.removeLast() // pop
            if let left = node.left {
                stack.append(left)
                value.append(tmp + 1)
            }
            if let right = node.right {
                stack.append(right)
                value.append(tmp + 1)
            }
        }
        return maxValue
    }
    
    /// 递归
    func maxDepth3(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth3(root.left), maxDepth3(root.right)) + 1
    }
    
    
    /// 找出二叉树中最短的一条路径
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var returnValue = 0
        var queue: Array<TreeNode> = [root]
        while !queue.isEmpty {
            returnValue += 1
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                if node.left == nil && node.right == nil {
                    return returnValue
                }
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        return returnValue
    }
    
    
    
    /// 二叉树的坡度
    /// 1.二叉树的坡度是所有节点坡度的和
    /// 2.节点坡度 = 左子节点之和与右子节点之和的差的绝对值
    /// 3.nil节点的坡度为0
    public static func findTilt(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let tilt = abs(nodeSum(root.left) - nodeSum(root.right)) /// 会遍历多次树，运行时间较长
        return tilt + findTilt(root.left) + findTilt(root.right)
    }
    
    /// 这种实现方式，使用了成员变量
    /// 参考：https://discuss.leetcode.com/topic/87207/java-solution-post-order-traversal
    private var result = 0
    public func findTilt2(_ root: TreeNode?) -> Int {
        _ = _sum(root)
        return result
    }
    /// 二叉树节点的和
    /// 在计算和的过程中，算出当前节点的坡度，累加到成员变量中
    /// 这样只会遍历一次树
    private func _sum(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        let leftSum = _sum(root.left)
        let rightSum = _sum(root.right)
        let tilt = abs(leftSum - rightSum)
        result += tilt
        return root.val + leftSum + rightSum
    }
    
    
    /// 二叉树节点的和
    public static func nodeSum(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return root.val + nodeSum(root.left) + nodeSum(root.right)
    }
    
    
    /// 二叉树直径: 任意两个节点之间的最大距离，可能经过根节点也可能不经过根节点
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var result = 0
        /// 嵌套函数
        /// 求最大路径
        func maxDepth(_ root: TreeNode?) -> Int {
            guard let root = root else {
                return 0
            }
            let leftDepth = maxDepth(root.left)
            let rightDepth = maxDepth(root.right)
            result = max(leftDepth + rightDepth, result) /// 左子树的深度与右子树的深度的和的最大值
            return max(leftDepth, rightDepth) + 1
        }
        _ = maxDepth(root)
        return result
    }
    
    
    /// 按层遍历二叉树
    /// 从上到下
    /// 可以改写成使用queue，从Leetcode上看，使用queue并没有这种方式运行效率高
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let node = root else {
            return []
        }
        var ans: [[TreeNode]] = []
        
        var currentLevel: [TreeNode] = []
        currentLevel.append(node)
        while !currentLevel.isEmpty {
            ans.append(currentLevel)
            
            var nextLevel: [TreeNode] = []
            for subNode in currentLevel {
                if let left = subNode.left {
                    nextLevel.append(left)
                }
                if let right = subNode.right {
                    nextLevel.append(right)
                }
            }
            currentLevel = nextLevel
        }
        return ans.map { $0.map { $0.val} } // 使用map函数
    }

    /// 按层遍历二叉树
    /// 从下到上
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        return levelOrder(root).reversed()
    }
    
    /// DFS
    /// 参考：https://discuss.leetcode.com/topic/7651/my-dfs-and-bfs-java-solution
    public static func levelOrderBottom2(_ root: TreeNode?) -> [[Int]] {
        var returnValue: [[Int]] = []
        func DFS(_ root: TreeNode?, _ level: Int) {
            guard let root = root else {
                return
            }
            if level >= returnValue.count {
                returnValue.append([])
            }
            DFS(root.left, level + 1);
            DFS(root.right, level + 1);
            returnValue[level].append(root.val)
        }
        DFS(root, 0)
        return returnValue
    }
    
    
    /// 二叉树所有路径
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var result: [String] = []
        var allPaths: [[String]] = []
        var path: [String] = []
        
        func dfs(_ root: TreeNode?) {
            guard let root = root else {
                return
            }
            path.append("\(root.val)")
            dfs(root.left)
            dfs(root.right)
            if root.left == nil && root.right == nil {
                allPaths.append(path)
            }
            path.removeLast()
        }
        
        dfs(root)
        
        return allPaths.map {
            $0.joined(separator: "->")
        }
    }
    
    /// 优化方案
    func binaryTreePaths2(_ root: TreeNode?) -> [String] {
        var result: [String] = []
        
        /// 可以进一步将path的类型改为String
//        func dfs(_ root: TreeNode?, _ path: [String]) {
//            guard let root = root else {
//                return
//            }
//            dfs(root.left, path + ["\(root.val)"])
//            dfs(root.right, path + ["\(root.val)"])
//            if root.left == nil && root.right == nil {
//                let str = (path + ["\(root.val)"]).joined(separator: "->")
//                result.append(str)
//            }
//        }
//        
//        dfs(root, [])
        
        func dfs(_ root: TreeNode?, _ path: String) {
            guard let root = root else {
                return
            }
            dfs(root.left, path + "\(root.val)" + "->")
            dfs(root.right, path + "\(root.val)" + "->")
            if root.left == nil && root.right == nil {
                result.append(path + "\(root.val)")
            }
        }
        dfs(root, "")
        
        return result;
    }
    
    /// 不使用其它函数，递归调用自己
    func binaryTreePaths3(_ root: TreeNode?) -> [String] {
        guard let root = root else {
            return []
        }
        if root.left == nil && root.right == nil {
            return ["\(root.val)"]
        }
        
        let leftPaths = binaryTreePaths3(root.left)
        let rightPaths = binaryTreePaths3(root.right)
        
        var paths = leftPaths + rightPaths // 合并左子树路径与右子树路径到一个数组
        for i in 0..<paths.count {
            paths[i] = "\(root.val)" + "->" + paths[i]
        }
        
        return paths
    }
    
    /// 二叉树是否是高度平衡二叉树
    /// 高度平衡二叉树：所有节点的左、右子树的路径的差都不大于1
    func isBalanced(_ root: TreeNode?) -> Bool {
        var result = true
        @discardableResult
        func maxDepth(_ root: TreeNode?) -> Int {
            guard let root = root else {
                return 0
            }
            let leftDepth = maxDepth(root.left)
            let rightDepth = maxDepth(root.right)
            if abs(leftDepth - rightDepth) > 1 {
                result = false
                return 0
            }
            return max(leftDepth, rightDepth) + 1
        }
        
        maxDepth(root)
        return result
    }
    
    public static func tree2str(_ t: TreeNode?) -> String {
        func DFS(_ t: TreeNode?) -> String {
            guard let root = t else {
                return ""
            }
            
            var leftStr = DFS(root.left)
            let rightStr = DFS(root.right)
            if leftStr.isEmpty && !rightStr.isEmpty {
                leftStr = "()"
            }
            
            return "(" + "\(root.val)" + leftStr + rightStr + ")"
        }
        
        let result = DFS(t)
        guard result.count > 2 else {
            return result
        }
        let start = result.index(result.startIndex, offsetBy: 1)
        let end = result.index(result.endIndex, offsetBy: -1)
        return String(result[start..<end])
    }
    
    // 合并二叉树
    public static func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        guard t1 == nil && t2 == nil else {
            return nil
        }
        guard let root1 = t1 else {
            return t2
        }
        guard let root2 = t2 else {
            return t1
        }
        
        root1.val += root2.val
        root1.left = mergeTrees(root1.left, root2.left)
        root1.right = mergeTrees(root1.right, root2.right)
        return root1
    }
    
    // 左子节点的和，注意当这个左子节点没有子节点时，才会加它的值
    public static func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        var sum = 0
        // 该函数不要返回Int型，因为sum的值有可能与该返回值相等，这样就会执行到if语句块中
        // 该函数的返回值，表示的意思是，当前节点是否没有左、右子节点
        // 我们可以直接判断当前节点的左、右子节点是否为空。这样对于一个节点就会少两次递归
//        func DFS(_ root: TreeNode?, _ leftOrRight: Int) -> Int {
//            guard let root = root else {
//                return 0
//            }
//            
//            let leftVal = DFS(root.left, 0)
//            let rightVal = DFS(root.right, 1)
//            if leftVal == 0 && rightVal == 0 && leftOrRight == 0 {
//                sum += root.val
//            }
//            
//            return sum
//        }
        
        func DFS(_ root: TreeNode?, _ leftOrRight: Int) {
            guard let root = root else {
                return
            }
            
            if root.left == nil && root.right == nil && leftOrRight == 0 {
                sum += root.val
            }
            
            DFS(root.left, 0)
            DFS(root.right, 1)
        }
        
        DFS(root?.left, 0)
        DFS(root?.right, 1)
        return sum
    }
}


public func example(_ description: String, action: () -> Void) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) example ---")
}
