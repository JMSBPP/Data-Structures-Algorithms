from sys import stdin
import re
class Solution(object):
    def __init__(self):
        self.counter = {}

    def goodNumbers(self,arr):
        index =  0
        while  arr:
            counter = 0
            a  = arr.pop(0)
            for i in range(len(arr)):
                if a==arr[i]:
                    counter+=1
            self.counter[index] = counter
            index+=1
        return sum(self.counter.values())

if __name__ == '__main__':
    s = Solution()
    with open('input.txt', 'r') as f:
        for line in f:
            items = line.strip().split(',')

            numbers = [int(re.findall(r'\d+', item)[0]) for item in items]

            print(s.goodNumbers(numbers))