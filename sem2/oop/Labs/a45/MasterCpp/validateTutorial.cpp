#include "validateTutorial.h"

const char* TutorialValidator::validateTutorial(Tutorial t) {
	if (t.getLink() == "" || t.getTitle() == "" || t.getPresenter() == "")return "Link, Title and Presenter fields cannot be empty !";
	if (t.getLikes() < 0) return "Nr of likes should be a natural number !";
	if (t.getDuration().first < 0 || t.getDuration().second < 0 || t.getDuration().second > 59)
		return "Duration is invalid !";
	return "";
}