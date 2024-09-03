class Group:
    def __init__(self):
        self.size = 0
        self.availSlots = 0
        self.members = []

    def postSize(self, size: int):
        self.size = size
        self.availSlots = size

    def addMember(self, memberId: int):
        if self.availSlots > 0:
            self.members.append(memberId)
            self.availSlots -= 1
            return True
        else:
            return False

class Groups:
    def __init__(self):
        self.groups = []

    def addGroup(self, size: int):
        new_group = Group()
        new_group.postSize(size)
        self.groups.append(new_group)
        return True

    def checkGroup(self):
        if self.groups and self.groups[0].availSlots > 0:
            return True
        else:
            return False

    def completeGroup(self):
        if self.checkGroup():
            group = self.groups.pop(0)
            return group.members
        return []

class Solution:
    def __init__(self):
        self.result = []

    def groupThePeople(self, groupSizes: list[int]) -> list[list[int]]:
        """
        :type groupSizes: List[int]
        :rtype: List[List[int]]
        """
        _groups = Groups()
        for person, size in enumerate(groupSizes):
            # If there is no group that can accommodate this person, create a new group
            if not _groups.checkGroup() or not _groups.groups[0].addMember(person):
                if _groups.checkGroup():
                    self.result.append(_groups.completeGroup())
                _groups.addGroup(size)
                _groups.groups[0].addMember(person)
        
        if _groups.checkGroup():
            self.result.append(_groups.completeGroup())

        return self.result
