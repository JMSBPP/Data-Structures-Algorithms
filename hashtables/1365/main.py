
import re

class Solution(object):
    def smallerNumbersThanCurrent(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """

        return [sum(1 for i in nums if i < j) for j in nums]
    

if __name__ == '__main__':
    with open("input.txt", "r") as f:
        for line in f:
            nums = list(map(int, re.findall(r"\d+", line)))
            print(Solution().smallerNumbersThanCurrent(nums))