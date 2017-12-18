//: [Previous](@previous)

import Foundation

example("Find words") {
    let result = findWords(["Hello", "Alaska", "Dad", "Peace"])
    print(result)
}

example("Get importence") {
    var employees: [Employee] = []
    employees.append(Employee(id: 1, importance: 5, subordinates: [2, 3]))
    employees.append(Employee(id: 3, importance: 3, subordinates: []))
    employees.append(Employee(id: 2, importance: 3, subordinates: []))
    
    let result = getImportance(employees: employees, id: 2)
    print(result)
    
}

example("Island number") {
    let grid: [[Character]] = [["1", "1", "1", "1", "0"],
                               ["1", "1", "0", "1", "0"],
                               ["1", "1", "0", "0", "1"],
                               //["0", "0", "0", "0", "0"],
                               ]
    let result = numIslands(grid)
    print(result)
    
}

example("Single number") {
    let result = singleNumber([1, 1, 2, 3, 2])
    print(result)
}

example("Find the Difference") {
    let result = findTheDifference("abcd", "abcde")
    print(result)
}

example("Intersection") {
    let result = intersection([1, 2, 2, 1], [2, 3])
    print(result)
}

example("Valid Anagram") {
    let result = isAnagram("anagram", "nagarmm")
    let result2 = isAnagram2("abb", "baa")
    print(result)
    print(result2)
}

example("findRestaurant") {
    let result = findRestaurant(["a", "b", "c"], ["b", "aa", "a"])
    print(result)
}

example("longestPalindrome") {
    let result = longestPalindrome("abbbcccddd")
    print(result)
}

example("numberOfBoomerangs") {
    let result = numberOfBoomerangs([[0, 0], [1, 0], [2, 0], [1, 1]])
    let result2 = numberOfBoomerangs2([[0, 0], [1, 0], [2, 0], [1, 1]])
    print(result)
    print(result2)
}

example("findAnagrams") {
    let result = findAnagrams("cbaebabacd", "abc")
    print(result)
}

example("findAnagrams2") {
    let result = findAnagrams2("cbaebabacd", "abca")
    print(result)
}

example("sqrt") {
    let res = sqrt(4)
    print(res)
}

example("findDuplicate") {
    let input = ["root/a 1.txt(abcd) 2.txt(efgh)", "root/c 3.txt(abcd)", "root/c/d 4.txt(efgh)", "root 4.txt(efgh)"]
    let res = findDuplicate(input)
    print(res)
}

