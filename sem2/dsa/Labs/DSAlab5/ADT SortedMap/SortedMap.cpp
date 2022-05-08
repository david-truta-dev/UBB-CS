#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>
using namespace std;

SortedMap::SortedMap(Relation r) {
	this->r = r;
	this->root = NULL;
	this->nrOfNodes = 0;
}

BSTNode* SortedMap::initNode(TElem e){
	BSTNode* newNode = new BSTNode;
	newNode->info = e;
	newNode->left = NULL;
	newNode->right = NULL;
	return newNode;
}

TValue SortedMap::add(TKey k, TValue v) {
	BSTNode* currentNode = this->root;
	BSTNode* prevNode = NULL;
	bool found = false;

	while (currentNode != NULL && !found) {
		if (currentNode->info.first == k)
			found = true;
		else if (this->r(currentNode->info.first, k)) {
			prevNode = currentNode;
			currentNode = currentNode->left;
		}
		else {
			prevNode = currentNode;
			currentNode = currentNode->right;
		}
	}

	if (found) {
		TValue oldVal = currentNode->info.second;
		currentNode->info.second = v;
		return oldVal;
	} else {

		this->nrOfNodes++;

		BSTNode* newNode = this->initNode(TElem(k,v));
		if (NULL != prevNode) {
			if (this->r(prevNode->info.first, k)) 
				prevNode->left = newNode;
			else 
				prevNode->right = newNode;	
		}
		else {
			this->root = newNode; // The map was empty
		}
		return NULL_TVALUE;
	}
}

TValue SortedMap::search(TKey k) const {
	BSTNode* currentNode = this->root;
	bool found = false;

	while (currentNode != NULL && !found) {
		if (currentNode->info.first == k)
			found = true;
		else if (this->r(currentNode->info.first, k))
			currentNode = currentNode->left;
		else
			currentNode = currentNode->right;
	}
	if (found)
		return currentNode->info.second;
	else
		return NULL_TVALUE;
}

void SortedMap::maxLeftSubtree(BSTNode* n, BSTNode* max) {
	if(n!=NULL)
		if (this->r(n->info.first, max->info.first)) {
			maxLeftSubtree(n->left, n);
			maxLeftSubtree(n->right, n);
		}
		else {
			maxLeftSubtree(n->left, max);
			maxLeftSubtree(n->right, max);
		}
}

int SortedMap::getRange() const {
	if (this->root == NULL) return -1;
	return this->maxKey - this->minKey;
}

BSTNode* SortedMap::parent(BSTNode* n) {
	BSTNode* c = this->root;
	if (c == n)
		return NULL;
	else {
		while (c != NULL && c->left != n && c->right != n)
			if (c->info.first >= n->info.first)
				c = c->left;
			else
				c = c->right;
		return c;
	}
}

TValue SortedMap::remove(TKey k) {
	BSTNode* currentNode = this->root;
	BSTNode* prevNode = NULL;
	while(currentNode != NULL) {
		if (currentNode->info.first == k) { //remove
			if (currentNode->left == NULL && currentNode->right == NULL) {
				// LEAF and has no descendents
				if (prevNode != NULL) 
					if (prevNode->left == currentNode) {
						TValue oldVal = currentNode->info.second;
						delete prevNode->left;
						prevNode->left = NULL;
						this->nrOfNodes--;
						return oldVal;
					} else {
						TValue oldVal = currentNode->info.second;
						delete prevNode->right;
						prevNode->right = NULL;
						this->nrOfNodes--;
						return oldVal;
					}
				else { //root
					TValue oldVal = currentNode->info.second;
					delete this->root;
					this->root = NULL;
					this->nrOfNodes--;
					return oldVal;
				}
			} else if (currentNode->left != NULL && currentNode->right == NULL) {
				// node has 1 descendent (left)
				if (prevNode != NULL)
					if (prevNode->left == currentNode) {
						TValue oldVal = currentNode->info.second;
						prevNode->left = currentNode->left;
						delete currentNode;
						this->nrOfNodes--;
						return oldVal;
					}
					else {
						TValue oldVal = currentNode->info.second;
						prevNode->right = currentNode->left;
						delete currentNode;
						this->nrOfNodes--;
						return oldVal;
					}
				else { //root
					TValue oldVal = currentNode->info.second;
					this->root = this->root->left;
					delete currentNode;
					this->nrOfNodes--;
					return oldVal;
				}
			} else if (currentNode->left == NULL && currentNode->right != NULL) {
				// node has 1 descendent (right)
				if (prevNode != NULL)
					if (prevNode->left == currentNode) {
						TValue oldVal = currentNode->info.second;
						prevNode->left = currentNode->right;
						delete currentNode;
						this->nrOfNodes--;
						return oldVal;
					}
					else {
						TValue oldVal = currentNode->info.second;
						prevNode->right = currentNode->right;
						delete currentNode;
						this->nrOfNodes--;
						return oldVal;
					}
				else { //root
					TValue oldVal = currentNode->info.second;
					this->root = this->root->right;
					delete currentNode;
					this->nrOfNodes--;
					return oldVal;
				}
			} else {
				// node has 2 descendents
				TValue oldVal = currentNode->info.second;
				BSTNode* prevSuccessor = NULL;
				
				if(prevSuccessor != NULL)
					if (prevNode->left == currentNode) {
						TValue oldVal = currentNode->info.second;
						delete prevNode->left;

						BSTNode* max = NULL;
						maxLeftSubtree(currentNode->left, max);
						BSTNode* maxParent = parent(max);

						prevNode->left = max;

						if (maxParent->left == max) 
							maxParent->left = NULL;
						else if (maxParent->right == max)
							maxParent->right = NULL;

						this->nrOfNodes--;
						return oldVal;
					}
					else {
						TValue oldVal = currentNode->info.second;
						delete prevNode->right;

						BSTNode* max = NULL;
						maxLeftSubtree(currentNode->left, max);
						BSTNode* maxParent = parent(max);

						prevNode->right = max;

						if (maxParent->left == max)
							maxParent->left = NULL;
						else if(maxParent->right == max)
							maxParent->right = NULL;

						this->nrOfNodes--;
						return oldVal;
					}
				else { //root
					TValue oldVal = currentNode->info.second;
					delete this->root;

					BSTNode* max = NULL;
					maxLeftSubtree(this->root->left, max);
					BSTNode* maxParent = parent(max);

					this->root = max;

					if (maxParent->left == max)
						maxParent->left = NULL;
					else if (maxParent->right == max)
						maxParent->right = NULL;

					this->nrOfNodes--;
					return oldVal;
				}
				
			}
				
		}
		else if (this->r(currentNode->info.first, k)) {
			prevNode = currentNode;
			currentNode = currentNode->left;
		}
		else {
			prevNode = currentNode;
			currentNode = currentNode->right;
		}
	}
	return NULL_TVALUE;
}

int SortedMap::size() const {
	return this->nrOfNodes;
}

bool SortedMap::isEmpty() const {
	if (this->nrOfNodes == 0) 
		return true;
	return false;
}

SMIterator SortedMap::iterator() const {
	return SMIterator(*this);
}

void SortedMap::DestroyRecursive(BSTNode* node) {
	if (node != NULL) {
		DestroyRecursive(node->left);
		DestroyRecursive(node->right);
		delete node;
	}
}

SortedMap::~SortedMap() {
	this->DestroyRecursive(this->root);
}
