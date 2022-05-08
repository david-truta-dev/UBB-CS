#pragma once
#include "tutorial.h"

class TutorialValidatorException : public std::exception {
private:
	std::string message;
public:
	TutorialValidatorException() {};
	TutorialValidatorException(std::string m) {
		this->message = m;
	};
	std::string what() { return this->message; };
};

class TutorialValidator {

public:
	void validateTutorial(Tutorial t);

};