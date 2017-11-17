//: [Previous](@previous)

import Foundation

example("Bucket Sort") {
    var array = [10, 5, 9, 4, 8, 3, 7, 2, 6, 1, 10, 1]
    bucketSort(&array)
}

example("Heap Sort") {
    var array = [16, 18, 4, 20, 7]
    heapSort(&array)
}


example("Top k") {
    let array = [10, 5, 9, 4, 8, 3, 7, 2, 6, 1, 10, 1, 100, 50, 88, 99, 12]
    topK(array, 5)
}

example("Quick Sort") {
    var array = [10, 5, 9, 4, 8, 3, 7, 2, 6, 1, 10, 1, 100, 50, 88, 99, 12]
    quickSort(&array)
}
