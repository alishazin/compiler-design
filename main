
import re

class LexicalAnalyzer:
    
    keywords = ["#include", "using", "namespace", "std", "int", "return", "if", "endl", "cout"]
    operators = ["+", "-", "*", "/", "<", ">", "=", "<<", ">>"]
    punctuation = ["{", "}", "(", ")", ":", ";"]
    literals = [r"^\d+$", r"""^('|")\w*('|")$"""]
    identifier = r'^[a-z|A-Z|_]\w*$'
    
    
    def __init__(self, filename):
        self.filename = filename
        self.content = open(filename).read()
        
    def tokenize(self):
        
        keyword_count = 0
        keyword_set = set()
        
        operator_count = 0
        operator_set = set()
        
        punctuation_count = 0
        punctuation_set = set()
        
        literals_count = 0
        literals_set = set()
        
        identifier_count = 0
        identifier_set = set()
        
        misshits = 0
        
        for i in self.content.split():
            
            if i in self.keywords:
                keyword_count += 1
                keyword_set.add(i)
                continue
                
            if i in self.operators:
                operator_count += 1
                operator_set.add(i)
                continue
            
            if i in self.punctuation:
                punctuation_count += 1
                punctuation_set.add(i)
                continue
            
            valid = 0
            
            for j in self.literals:    
                
                if re.search(j, i):
                    literals_count += 1
                    literals_set.add(i)
                    valid = 1
                    break
                
            if valid: continue
            
            if re.search(self.identifier, i):
                identifier_count += 1
                identifier_set.add(i)
                continue
            
            misshits += 1                
                
        print("Keywords:")
        print(f"Count: {keyword_count}")
        print([i for i in keyword_set])
        print()
                
        print("Operators:")
        print(f"Count: {operator_count}")
        print([i for i in operator_set])
        print()
                
        print("Punctuation:")
        print(f"Count: {punctuation_count}")
        print([i for i in punctuation_set])
        print()
                
        print("Literals:")
        print(f"Count: {literals_count}")
        print([i for i in literals_set])
        print()
                
        print("identifier:")
        print(f"Count: {identifier_count}")
        print([i for i in identifier_set])
        print()
        
        print(f"Miss hits: {misshits}")
        
c = LexicalAnalyzer("main.cpp")

c.tokenize()
