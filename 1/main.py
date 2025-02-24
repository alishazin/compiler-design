
char_count = 0
line_count = 0
word_count = 0

with open("input.txt", 'r') as f:

    for line in f:

        line_count += 1
        char_count += len(line)

        word_count += len(line.split(" "))

print(f"Character Count: {char_count}")
print(f"Line Count: {line_count}")
print(f"Word Count: {word_count}")