
vowels_count = 0
consonants_count = 0

vowels = ['a', 'e', 'i', 'o', 'u']

with open("input.txt", 'r') as f:

    for char in f.read():

        if char.isalpha():

            if char.lower() in vowels:
                vowels_count += 1
            
            else:
                consonants_count += 1

print(f"Vowels count: {vowels_count}")
print(f"Consonants count: {consonants_count}")