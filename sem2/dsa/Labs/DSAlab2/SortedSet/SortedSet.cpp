#include "SortedSet.h"
#include "SortedSetIterator.h"
#include <stdio.h>


SortedSet::SortedSet(Relation r): rel(r){
	this->head = NULL;
	this->tail = NULL;
	this->length = 0;
}//Theta(1)


bool SortedSet::add(TComp elem) {
	if (this->search(elem) == true) return false;

	Node* currentNode = this->head;
	while (currentNode != NULL && this->rel(currentNode->value, elem)) {
		currentNode = currentNode->next;
	}
	if (currentNode == this->head && currentNode != NULL) {// 1.Insert at the begining & set is not empty.
		Node* newNode = new Node;
		newNode->value = elem;
		newNode->prev = NULL;
		newNode->next = this->head;
		this->head->prev = newNode;
		this->head = newNode;
	}
	else if (currentNode == NULL) { // 2.Insert at the end.
		Node* newNode = new Node;
		newNode->value = elem;
		newNode->prev = this->tail;
		newNode->next = NULL;
		if (this->head == NULL)
		{//a. Set is empty
			this->head = newNode;
			this->tail = newNode;
		}
		else {//b. Set is not empty
			this->tail->next = newNode;
			this->tail = newNode;
		}
	}
	else { // 3. Not at the end/begining & set is not empty
		Node* newNode = new Node;
		newNode->value = elem;
		newNode->prev = currentNode->prev;
		newNode->next = currentNode;
		currentNode->prev->next = newNode;
		currentNode->prev = newNode;
	}

	this->length++;
	return true;
}//O(n)


bool SortedSet::remove(TComp elem) {
	if (this->head == NULL) return false;
	if (this->head == this->tail && this->head->value == elem) {//1. only one elem, and it's removed
		this->tail = NULL;
		delete this->head;
		this->head = NULL;
		this->length--;
		return true;
	}
	if (this->head->value == elem) {//2. remove head
		this->head = this->head->next;
		delete this->head->prev;
		this->head->prev = NULL;
		this->length--;
		return true;
	}
	else if (this->tail->value == elem) {//3. remove tail
		this->tail = this->tail->prev;
		delete this->tail->next;
		this->tail->next = NULL;
		this->length--;
		return true;
	}
	Node* currentNode = this->head->next;
	while (currentNode != NULL) {
		if (currentNode->value == elem) {//4. remove other node.
			currentNode->prev->next = currentNode->next;
			currentNode->next->prev = currentNode->prev;
			delete currentNode;
			this->length--;
			return true;
		}
		currentNode = currentNode->next;
	}
	return false; // 5. Node is not in set 
}


bool SortedSet::search(TComp elem) const {
	Node* currentNode = this->head;
	if (this->head == NULL) return false;
	if (this->tail->value == elem) return true;
	while (currentNode != NULL) {
		if (currentNode->value == elem) return true;
		currentNode = currentNode->next;
	}
	return false;
}// O(length)


int SortedSet::size() const {
	return this->length;
}//Theta(1)


bool SortedSet::isEmpty() const {
	if (this->head == NULL && this->tail == NULL)
		return true;
	return false;
}//Theta(1)


SortedSetIterator SortedSet::iterator() {
	return SortedSetIterator(*this);
}


SortedSet::~SortedSet() {
	Node* currentNode = this->head;
	if (this->head == NULL) return;
	while (currentNode != NULL) {
		delete currentNode->prev;
		currentNode = currentNode->next;
	}
}//Theta(length)
