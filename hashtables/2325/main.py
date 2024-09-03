class Solution(object):
    def decodeMessage(self, key, message):
        """
        :type key: str
        :type message: str
        :rtype: str
        """
        cipher = {}
        next_char_code = 65  # ASCII code for 'A'
        
        for char in key:
            if char != ' ' and char not in cipher:
                cipher[char] = chr(next_char_code)
                next_char_code += 1
                if next_char_code > 90:  
                    break
        
        decoded_message = ''.join(cipher.get(char, char) for char in message).lower()
        return decoded_message
    

if __name__ == "__main__":
    with open("input.txt", 'r') as file:
        while True:
            key = file.readline().strip()
            if not key:  
                break
            message = file.readline().strip()
            print(Solution().decodeMessage(key, message))
