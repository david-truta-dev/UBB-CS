# SymbolTable Documentation
## ~ Implemented using a hash table
### Hash function:
- INPUT: element(any), index(int)
- OUTPUT: hash(int)
- uses the built-in python hash function, which creates a unique int for each value. 
- the hash is computed using an index and an element.

### Add method:
- INPUT: element(any)
- OUTPUT: element(any) OR position(int)
- in case the element was already added the function will return the element, otherwise it will iterate over the 
available positions, calling the hash function and trying to insert it.
- in case of collision the element the size will increase and the element will pe placed on the next available index.

### Get Method:
- INPUT: element(any)
- OUTPUT: index(int)
- returns -1 in case the element doesn't exist, returns the position in the SymbolTable