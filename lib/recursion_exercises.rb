# sum beetween given range of numbers
def range(num1, num2)
    return [] if num2 <= num1
    [num1] + range(num1+1, num2)
end

# Test
# p range(1,10)
# p range(-5, -1)
# p range(-2, -5)
# p range(-1, 0)

def sum_array_iterative(arr)
    arr.inject(0) {|sum, el| sum + el}
end

def sum_array_recursive(arr)
    case arr.length
    when 0
        return 0
    when 1
        return arr[0]
    else
        arr[0] + sum_array_recursive(arr[1..-1])
    end
end

# Test
# p sum_array_iter([1, 4, 6, -4])
# p sum_array_iter([])
# p sum_array_iter([0])

# p sum_array_recursive([1, 4, 6, -4])
# p sum_array_recursive([])
# p sum_array_recursive([0])

def exponent_v1(base, power)
    return 1 if power <= 0
    base * exponent_v1(base, power-1)
end

def exponent_v2(base,power)
    case
    when power == 0
        return 1
    when power == 1
        return base
    when power % 2 == 0
        exponent_v2(base,power/2) ** 2
    else
        base * (exponent_v2(base, (power-1)/2) ** 2)
    end 
end

# Test
# p exponent_v1(4,0)
# p exponent_v1(-1,5)
# p exponent_v1(3,3)

# p exponent_v2(2,0)
# p exponent_v2(5,1)

class Array
    def deep_dup
        result = []
        # iterate through array
        self.each do |el|
            if el.is_a?(Array) # recursive call to copy entire element if array
                result << el.deep_dup
            else # single element, copy over
                result << el
            end
        end
        result
    end
end

# arr = [ [1,2] , [3,4,5] , 6 , []]
# copy = arr.deep_dup
# puts "Original: #{arr}"
# puts "Copy: #{copy}"
# copy[3] << 7
# puts "Adjusted Copy: #{copy}"
# puts "Original: #{arr}"

def fibonacci_iterative(num)
    result = []
    (1..num).each do |number|
        if number <= 1
            result << 1
        elsif number == 2
            result << 1
        else
            result << result[-1] + result[-2]
        end
    end
    result
end

def fibonacci_recursive(num)
    case
    when num <= 1
        return [1]
    when num == 2
        return [1,1]
    else
        previous = fibonacci_recursive(num-1)
        previous << previous[-1] + previous[-2]
        previous
    end
end

# Test
# p fibonacci_iterative(1)
# p fibonacci_iterative(2)
# p fibonacci_iterative(5)

# p fibonacci_recursive(2)
# p fibonacci_recursive(4)
# p fibonacci_recursive(10)

def bsearch(arr, target)
    if arr.length < 1   # empty array, returns nil
        return nil
    end
    
    # multiple elements, grab middle and compare
    middle_index = arr.length / 2
    middle_element = arr[middle_index]
    case target <=> middle_element
    when -1 # target smaller, check left half
        new_arr = arr[0...middle_index]
        bsearch(new_arr, target)
    when 1
        new_arr = arr[middle_index+1..-1]
        answer = bsearch(new_arr, target)
        return nil if answer.nil?
        answer + middle_index + 1
    when 0
        return middle_index
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(arr)
    return arr if arr.length <= 1
    # define middle element where array will be split
    case arr.length % 2 == 0
    when true
        middle_index = (arr.length - 1) / 2
    when false
        middle_index = arr.length / 2
    end

    left_half = arr[0..middle_index]
    right_half = arr[middle_index + 1..-1]
    sorted_left = merge_sort(left_half)
    sorted_right = merge_sort(right_half)
    merge(sorted_left, sorted_right)
end

def merge(arr1, arr2)
    merged = []
    until arr1.empty? || arr2.empty? do
        if arr1[0] <= arr2[0]
            merged << arr1.shift
        else
            merged << arr2.shift
        end
    end
    merged + arr1 + arr2
end

# p merge_sort([9,5,2])
# p merge_sort([2,3,1,4])
# p merge_sort([4,2,9,10,5])

class Array
    def subsets
        return [[]] if empty?
        
        # get subsets of count - 1, excluse last element
        subset = take(count-1).subsets
        # append last element to every subset, and concatenate with original subset
        subset.concat(subset.map {|sub| sub + [last]})
    end
end

# p [].subsets
# p [1].subsets
# p [1,2].subsets
# p [1,2,3].subsets

def permutations(arr)
    # return nil if arr.empty?
    return [arr] if arr.length == 1
    # grab first element to append to all perms of smaller array
    first_el = arr.shift
    # get permutations of shrunken array
    subset_perms = permutations(arr)
    total_permutations = []
    # iterate through all smaller perms
    subset_perms.each do |sub|
    # add first element to all possible indices of perms array
    # and add to total_perms array
    (0..sub.length).each do |i|
        subset = sub[0...i] + [first_el] + sub[i..-1]
        total_permutations << subset
    end
    end
    total_permutations
end

# p [1,2].permutation.to_a
# p [1,2,3].permutation.to_a
# p permutations([1])
# p permutations([1,2])
# p permutations([1,2,3])

def greedy_make_change(total, coins)
    return [] if total == 0
    change = []
    # sort coins largest to smallest
    coins.sort!{|a,b| b <=> a}
    # remove first coin from array
    coin = coins.shift
    # calculate how many fit into total 
    coin_count = total / coin
    # add coin to change as many times as calculated above
    coin_count.times { change << coin}
    # current coin change and recursive call to remaining total using remaining coins
    change + greedy_make_change(total-(coin * coin_count), coins)
end

# p greedy_make_change(14, [1,5,10,25])
# p greedy_make_change(36, [1,5,10,25])
# p greedy_make_change(24, [1,5,10,25])
# p greedy_make_change(47, [1,5,10,25])

def make_better_change(total, coins = [1,5,10,25])
    # base case once total reaches 0
    return [] if total == 0

    # array to hold current best change
    best_change = nil

    # sort high to low, unnecessary for this function
    coins.sort!{|a,b| b <=> a}

    # since best change method unknown, we cycle through coins, grabbing
    # one of current coin and making best change with remainder.
    coins.each do |coin|
        next if coin > total # coin is unusable
        rest_of_change = make_better_change(total - coin, coins)
        change = [coin] + rest_of_change
        # if best change array empty or current change uses less coins, replace
        if best_change.nil? || change.count < best_change.count
            best_change = change
        end
    end
    best_change
end

p make_better_change(14,[1,7,10])