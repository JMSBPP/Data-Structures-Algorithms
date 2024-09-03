import re


class Solution(object):
    s =""
    t = ""

    def findPermutationDifference(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: int
        """
        sDict, tDict = {c: i for i, c in enumerate(s)}, {c: i for i, c in enumerate(t)}
        commonKeys = list(set(sDict.keys()) & set(tDict.keys()))
        res = {}
        for key in commonKeys:
            res[key] = abs(sDict[key] - tDict[key])
        return sum(res.values())


if __name__ == '__main__':
    with open('input.txt', 'r') as file:
        for line in file:
            inp = line.strip().split(',')
            arr = [re.findall(r'"([^"]*)"', i) for i in inp]
            sol = Solution()
            sol.s, sol.t = str(arr[0][0]), str(arr[1][0])
            print(sol.findPermutationDifference(sol.s, sol.t))