#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>

#include <iostream>

using namespace std;

SMIterator::SMIterator(const SortedMap& m) : map(m){
	this->first();
}

void SMIterator::first(){
	this->inOrder.clear();
	this->inOrderTraversal(this->map.root);

	if (this->inOrder.size() == 0)
		this->currentNode = NULL;
	else {
		this->currentNode = this->inOrder.back();
		this->inOrder.pop_back();
	}
}

void SMIterator::inOrderTraversal(BSTNode* n){
	if (n != NULL) {
		this->inOrderTraversal(n->left);
		this->inOrder.push_back(n);
		this->inOrderTraversal(n->right);
	}
}

void SMIterator::next(){
	if (!this->valid())
		throw std::exception();
	if (this->inOrder.size() == 0)
		this->currentNode = NULL;
	else {
		this->currentNode = this->inOrder.back();
		this->inOrder.pop_back();
	}
}

bool SMIterator::valid() const{
	if (this->currentNode == NULL)
		return false;
	return true;
}

TElem SMIterator::getCurrent() const{
	if (!this->valid())
		throw std::exception();
	return this->currentNode->info;
}


