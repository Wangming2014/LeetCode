import Foundation

/*
 插入排序
 原理：
 通过构造有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入
 实现：
 采用in-place排序(只需要用到O(1)的额外空间复杂度)
 时间复杂度：
 最好：当数组已经是有序的情况下为O(n)
 最差：当数组是倒序的情况下(数组本身是从大到小排序的，但要从小到大排序)，为O(n^2)
 平均: O(n^2)
 空间复杂度：
 O(1)
 优化：
 在查询时，可以使用二分法查找(因为二分法查找要求是有序数组)，称为二分查找插入排序
 参考：
 https://zh.wikipedia.org/wiki/%E6%8F%92%E5%85%A5%E6%8E%92%E5%BA%8F
 */
public func insertSort(_ array: inout [Int]) {
    // 1.我们把第一个元素看做一个有序序列，所以从下标1开始遍历
    for i in 1..<array.count {
        let temp = array[i] // 去除新元素(待排序)
        // 2.从后向前扫描
        var j = i - 1
        while j >= 0 && array[j] > temp { // 3.若扫描的元素大于新元素，则将扫描的元素移到下一位
            array[j + 1] = array[j]
            j -= 1
        }
        array[j + 1] = temp // 4.将新元素放到指定位置
    }
}

// 桶排序(Bucket Sort)
// 一组大于0的数组，均匀分布，可使用桶排序
// 最坏时间复杂度 O(n^2)
// 平均时间复杂度 O(n+k)
// 空间复杂度 O(n*k)
// 参考：http://bubkoo.com/2014/01/15/sort-algorithm/bucket-sort/
public func bucketSort(_ array: inout [Int]) {
    guard array.count > 0 else {
        return
    }
    // 1.计算需要多少个桶
    var max = array[0], min = array[0]
    for element in array {
        if element > max {
            max = element
        }
        if element < min {
            min = element
        }
    }
    let bucketSize = 10 // 桶的大小，可以根据情况设定
    let bucketNum = max / bucketSize - min / bucketSize + 1
    
    // 2.创建桶
    var bucketList: [[Int]] = []
    for _ in 0..<bucketNum {
        bucketList.append([])
    }
    
    // 3.向桶中加入元素
    for element in array {
        let index = element / bucketSize // 当前元素应该放入到哪个桶
        bucketList[index].append(element)
    }
    
    // 4.对每个桶中的元素排序(这里用插入排序)
    var index = 0
    for i in 0..<bucketList.count {
        insertSort(&bucketList[i])
        // 5.取出桶中的元素，放在对应的位置上
        for element in bucketList[i] {
            array[index] = element
            index += 1
        }
    }
    
}

// 堆排序
// 时间复杂度：O(n * log n)
// 空间复杂度: O(1)
// 参考：http://bubkoo.com/2014/01/14/sort-algorithm/heap-sort/
public func heapSort(_ array: inout [Int]) {
    
    // 最大堆调整
    // 调用一次最大堆调整，并不能得到一个最大堆
    func maxHeapify(_ array: inout [Int], _ start: Int, _ end: Int) {
        var parent = start
        var child = parent * 2 + 1
        while child <= end {
            // 取最大的子节点
            if child + 1 <= end && array[child] < array[child + 1] {
                child += 1
            }
            
            // 若最大的子节点大于父节点，则交换二者的值
            // 并更新parent, child，继续操作
            guard array[child] > array[parent] else {
                return
            }
            //swap(&array[child], &array[parent])
            array.swapAt(child, parent)
            parent = child
            child = parent * 2 + 1
        }
    }
    
    // 1.创建最大堆
    // 从最后一个节点的父节点开始，自下而上逐个调用maxHeapify函数
    let parentOfLastNode = array.count / 2 - 1 // 最后一个节点的父节点
    for i in (0...parentOfLastNode).reversed() { // 倒着遍历，这样可以保证节点i下面的节点保持最大堆特性
        maxHeapify(&array, i, array.count - 1)
    }
    
    // 2.交换堆顶与堆底的值，分离出最大值
    for i in (0..<array.count).reversed() {
        //swap(&array[0], &array[i]) // 交换堆顶与堆底的值，这样就把最大值给分离出来了
        array.swapAt(0, i)
        maxHeapify(&array, 0, i - 1) // 最大堆调整，保持最大堆特性
    }
}

// Top K
public func topK(_ sourceArray: [Int], _ k: Int) -> [Int] {
    
    // 这里使用最小堆
    // 最小堆调整
    func minHeapify(_ array: inout [Int], _ start: Int, _ end: Int) {
        var parent = start
        var child = parent * 2 + 1
        while child <= end {
            if child + 1 <= end && array[child] > array[child + 1] {
                child += 1
            }
            
            guard array[child] < array[parent] else {
                return
            }
            //swap(&array[child], &array[parent])
            array.swapAt(child, parent)
            parent = child
            child = parent * 2 + 1
        }
    }
    
    
    // 创建最小堆
    var heap: [Int] = []
    for _ in 0..<k { // 初始化堆
        heap.append(0)
    }
    
    for element in sourceArray {
        // 把元素放入堆顶
        if element > heap[0] {
            heap[0] = element
        }
        
        // 最小堆调整
        minHeapify(&heap, 0, heap.count - 1)
    }
    
    return heap
}


/*
 快排(参考：http://harttle.com/2015/09/27/quick-sort.html)
 核心思想是采用 分治策略：
 1.选取一个基准值(pivot)
 2.比基准值小的放在数组的左边，比基准值大的放在数组的右边
 3.对左边和右边的部分分别进行1、2操作
 
 其中选择基准值又分为两种方法：(参考：https://cs.stackexchange.com/questions/11458/quicksort-partitioning-hoare-vs-lomuto/11550#11550)
 Lomulo: 以数组中的最后一个元素为pivot
 Hoare: 随机生成一个pivot
 
 时间复杂度：
 最坏: O(n^2)
 最好: O(n * log n)
 平均: O(n * log n)
 空间复杂度：
 O(log n)
 */
public func quickSort(_ array: inout [Int]) {
    // 划分，这里使用Lomulo方法
    func partition(_ array: inout [Int], _ begin: Int, _ end: Int) -> Int {
        let pivot = array[end] // 数组最后一个元素作为基准值
        var i = begin - 1 // i：小于基准值的子数组的下标上线，为-1表示数组中没有值
        for j in begin..<end { // 遍历，不包含end，因为end元素作为基准值
            if array[j] < pivot {
                i += 1 // 增加小于基准值的子数组的下标上线(增加元素)
                array.swapAt(i, j) // 将array[j]加入小于基准值的子数组(将小于基准值的元素放在基准值的左边)
            }
        }
        array.swapAt(i + 1, end) // 将基准值移到子数组后面的位置，这样就实现了：小于基准值的元素放到基准值的左边，大的则放到右边
        return i + 1 // 返回基准值的下标
    }
    
    // 递归
    func recursive(_ array: inout [Int], _ begin: Int, _ end: Int) {
        if begin < end {
            let pivot = partition(&array, begin, end)
            recursive(&array, begin, pivot - 1)
            recursive(&array, pivot + 1, end)
        }
    }
    
    recursive(&array, 0, array.count - 1)
}

/*
 选择排序：在无序序列中选取最小值，并放在有序序列的最后
 不稳定排序
 时间复杂度：
 O(n ^ 2)
 */
public func selectionSort(_ array: inout [Int]) {
    // 一开始是没有有序序列的，我们认为第一个元素就是一个有序序列
    for i in 0..<array.count - 1 {
        var min = i
        // 从i+1后面的元素都是无序的
        for j in (i + 1)..<array.count {
            if array[j] < array[min] {
                min = j
            }
        }
        array.swapAt(min, i)
    }
}





