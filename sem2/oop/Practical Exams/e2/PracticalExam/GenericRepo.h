#pragma once
#pragma once
#include <iostream>
#include <vector>

class RepoException : public std::exception {

private:
	const std::string message;

public:

	RepoException() : message("") {}

	RepoException(const std::string& str) : message(str) {}

	const char* what() const noexcept {
		return this->message.c_str();
	}

};

template <typename T>
class Repo {
protected:
	std::vector<T> elems;

public:
	virtual void add(T e);

	virtual void remove(T e);

	bool elemExists(T e);

	T getElem(int pos);

	int size();

	std::vector<T> getElems();

	virtual ~Repo() {}
};

template<typename T>
inline void Repo<T>::add(T e) {
	if (this->elemExists(e))
		throw RepoException("Element allready exists");
	this->elems.push_back(e);
};

template<typename T>
inline void Repo<T>::remove(T e) {
	for (int i = 0; i < this->elems.size(); i++)
		if (e == this->elems[i]) {
			this->elems.erase(this->elems.begin() + i);
			return;
		}
	//thorw RepoException("Element does not exist!");
};

template<typename T>
inline bool Repo<T>::elemExists(T e) {
	for (int i = 0; i < this->elems.size(); i++)
		if (e == this->elems[i]) return true;
	return false;
}

template<typename T>
inline T Repo<T>::getElem(int pos) {
	if (pos < 0 || pos >= this->size())
		throw RepoException("The position is not valid!");
	return this->elems[pos];
}

template<typename T>
inline int Repo<T>::size() {
	return this->elems.size();
}

template<typename T>
inline std::vector<T> Repo<T>::getElems() {
	return this->elems;
};

//============== Other useful stuff ====================

//void save() {
//	std::ofstream file(this->file);
//	for (auto tut : this->data) {
//		file << tut << "\n";
//	}
//	file.close();
//}
//
//void load() {
//	std::ifstream file(this->file);
//	Entity* e = new Entity{ };
//	while (file >> *e) {
//		this->add(e);
//		Entity* e = new Entity{ };
//	}delete e;
//	file.close();
//}
//
//std::ostream& operator<<(std::ostream& os, const Tutorial& t) {
//	os << t.link << ";" << t.title << ";" << t.presenter << ";" << t.duration.first
//		<< ";" << t.duration.second << ";" << t.likes << ";" << t.watched;
//	return os;
//}
//
//std::istream& operator>>(std::istream& is, Tutorial& t) {
//	std::string line, atribute; int i = 0, j = 0;
//	std::stringstream conversion;
//	std::getline(is, line);
//	while (i < line.size()) {
//		atribute = "";
//		while (line[i] != ';' && i < line.size()) {
//			atribute += line[i];
//			i++;
//		}
//		j++;
//		if (j == 1) {
//			t.link = atribute;
//		}
//		else if (j == 2) {
//			t.title = atribute;
//		}
//		else if (j == 3) {
//			t.presenter = atribute;
//		}
//		else if (j == 4) {
//			conversion.clear();
//			conversion << atribute;
//			conversion >> t.duration.first;
//		}
//		else if (j == 5) {
//			conversion.clear();
//			conversion << atribute;
//			conversion >> t.duration.second;
//		}
//		else if (j == 6) {
//			conversion.clear();
//			conversion << atribute;
//			conversion >> t.likes;
//		}
//		else if (j == 7) {
//			if (atribute == "1") {
//				t.watched = true;
//			}
//			else t.watched = false;
//		}
//		i++;
//	}
//	return is;
//}
