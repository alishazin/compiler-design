import re

# Define C Keywords
C_KEYWORDS = {
    "int", "float", "double", "char", "if", "else", "for", "while", "return", "void",
    "do", "switch", "case", "default", "break", "continue", "struct", "typedef", "union",
    "enum", "const", "static", "goto", "sizeof", "volatile", "extern", "register", "signed",
    "unsigned", "short", "long", "auto", "inline"
}

# Regular expressions for token classification
TOKEN_REGEX = re.compile(r"""
    (?P<keyword>\b(?:""" + "|".join(C_KEYWORDS) + r""")\b) |
    (?P<identifier>\b[a-zA-Z_][a-zA-Z0-9_]*\b) |            
    (?P<number>\b\d+(\.\d+)?\b) |                              
    (?P<string>\".*?\"|'.*?') |                                
    (?P<operator>\+\+|--|==|!=|<=|>=|\+=|-=|\*=|/=|%=|&&|\|\||[+\-*/=<>!&|^%]) | 
    (?P<punctuation>[{}()\[\],;])                              
""", re.VERBOSE)

def classify_tokens(code):
    keywords, identifiers, literals, operators, punctuation = [], [], [], [], []

    for match in TOKEN_REGEX.findall(code):
        
        token_type = match.lastgroup
        token = match.group(token_type)
        
        if token_type == "keyword":
            keywords.append(token)
        elif token_type == "identifier":
            identifiers.append(token)
        elif token_type == "number" or token_type == "string":
            literals.append(token)
        elif token_type == "operator":
            operators.append(token)
        elif token_type == "punctuation":
            punctuation.append(token)

    return keywords, identifiers, literals, operators, punctuation

# Read input from a C file
with open("main.c", "r") as file:
    code = file.read()

# Classify tokens
keywords, identifiers, literals, operators, punctuation = classify_tokens(code)

# Print results
print("\nKeywords:", set(keywords))
print("Occurences:", len(keywords))

print("\nIdentifiers:", set(identifiers))
print("Occurences:", len(identifiers))

print("\nLiterals:", set(literals))
print("Occurences:", len(literals))

print("\nOperators:", set(operators))
print("Occurences:", len(operators))

print("\nPunctuation:", set(punctuation))
print("Occurences:", len(punctuation))

