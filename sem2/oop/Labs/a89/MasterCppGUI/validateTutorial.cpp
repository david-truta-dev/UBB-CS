#include "validateTutorial.h"

void TutorialValidator::validateTutorial(Tutorial t) {
	if (t.getLink() == "" || t.getTitle() == "" || t.getPresenter() == "")
		throw TutorialValidatorException("Link, Title and Presenter fields cannot be empty !");
	if (t.getLikes() < 0) 
		throw TutorialValidatorException("Nr of likes should be a natural number !");
	if (t.getDuration().first < 0 || t.getDuration().second < 0 || t.getDuration().second > 59)
		throw TutorialValidatorException("Duration is invalid !");
}