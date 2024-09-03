import re


class Solution(object):
    def __init__(self):
        self.jewels = ''
        self.stones =  ''
    def numJewelsInStones(self, jewels, stones):
        """
        :type jewels: str
        :type stones: str
        :rtype: int
        """
        self.jewels = jewels
        self.stones = stones
        return sum(stone in self.jewels for stone in self.stones)
    

if __name__ == '__main__':
    with open('input.txt', 'r') as file:
        for line in file:
            inp = line.strip().split(',')
            arr = [re.findall(r'"([^"]*)"', i) for i in inp]
            sol = Solution()
            sol.jewels, sol.stones = str(arr[0][0]), str(arr[1][0])
            print(sol.numJewelsInStones(sol.jewels, sol.stones))
