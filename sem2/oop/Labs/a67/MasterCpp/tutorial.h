#pragma once
#include <iostream>

typedef std::pair<int, int> Duration;

class Tutorial {
	
	private:
		std::string link;
		std::string title;
		std::string presenter;
		Duration duration;
		int likes = 0;
		std::string& id = link;
		bool watched = false;

	public:
		Tutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes);
		Tutorial(const Tutorial&);
		std::string getId();
		std::string getLink();
		std::string getTitle();
		void setTitle(std::string newTitle);
		std::string getPresenter();
		void setPresenter(std::string newPresenter);
		Duration getDuration();
		void setDuration(Duration d);
		int getLikes();
		void setLikes(int likes);
		bool getWatched();
		void setWatched(bool);
		void toString(char str[]);

		Tutorial& operator=(const Tutorial& t);
		bool operator== (Tutorial t);

		friend std::ostream& operator<<(std::ostream& os, const Tutorial& t);
		friend std::istream& operator>>(std::istream& is, Tutorial& t);
		
};