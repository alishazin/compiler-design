
def length(text):

    count = 0
    for i in text:
        count += 1
    return count


def concat(text1, text2):

    for i in text2:
        text1 += i

    return text1

def substr(text, start, end):

    count = 0
    result = ''

    for i in text:

        if count >= start and count <= end:
            result += i

        count += 1

    return result

def reverse(text):

    result = ''

    for i in text:
        result = str(i) + result

    return result

def search_sub(text, sub):

    count = 0
    found_at = None

    for i in range(len(text)):

        if text[i] == sub[count]:

            count += 1

            if count == len(sub):
                found_at = i - len(sub) + 1
                break
        
        else:
            count = 0
    
    return found_at

def replace_sub(text, sub, new):

    index = search_sub(text, sub)

    if index == None:
        raise Exception("sub is not a valid substring")

    return f"{text[0:index]}{new}{text[index+len(sub)::]}"

def count_occ(text, sub):

    count = 0 

    index = search_sub(text, sub)
    
    while index != None:
        text = text[index+len(sub)::]
        count += 1
        index = search_sub(text, sub)

    return count

def lowercase(text):

    result = ''

    for i in range(len(text)):
        if ord(text[i]) >= 65 and ord(text[i]) <= 90:
            result += chr(ord(text[i]) + 32)
        else:
            result += text[i]
    
    return result

def uppercase(text):

    result = ''

    for i in range(len(text)):
        if ord(text[i]) >= 97 and ord(text[i]) <= 122:
            result += chr(ord(text[i]) - 32)
        else:
            result += text[i]
    
    return result

def title(text):

    result = ''

    for word in text.split(" "):
        result += f" {uppercase(word[0])}{lowercase(word[1::])}"

    return result[1::]


i1 = input("\nEnter a text: ")
print(f"Length: {length(i1)}")

i2 = input("\nEnter another text to concatenate: ")
print(f"Concatenated: {concat(i1, i2)}")

i3, i4 = (input("\nEnter a start index and end index for substring: ")).split(" ")
print(f"Substring: {substr(i1, int(i3), int(i4))}")

print(f"\nReversed: {reverse(i1)}")

i5 = input("\nEnter the substring to find: ")
print(f"Substring at: {search_sub(i1, i5)}")

i6 = input("\nEnter a string to replace with: ")
print(f"After replacing: {replace_sub(i1, i5, i6)}")

i7 = input("\nEnter a word/char to check: ")
print(f"Occurence count: {count_occ(i1, i7)}")

print(f"\nLowercase: {lowercase(i1)}")

print(f"\nUppercase: {uppercase(i1)}")

print(f"\nTitle: {title(i1)}")
