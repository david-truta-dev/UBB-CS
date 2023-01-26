class PIF:
    def __init__(self):
        self.elements = []
    
    def add_reserved(self, val):
        self.elements.append((val, (-1, -1)))
    
    def add_constant(self, pos):
        self.elements.append(("const", pos))

    def add_identifier(self, pos):
        self.elements.append(("id", pos))
    
    def save_to_file(self, path):
        with open(path, 'w') as file:
            file.write("PIF\n")
            for element in self.elements:
                file.write(str(element) + "\n")

    def __str__(self):
        return str(self.elements) 
