#ifndef __DOUBLYLL_H__
#define __DOUBLYLL_H__
#include <iostream>
#include <string>
enum Status 
{
    Watched, Watching, PlanningToWatch
};


struct Node
{
    std::string mName;
    Status mStatus;
    int mRating;
    std::string mRemarks;
    struct Node *next;
    struct Node *prev;
}*start;


class DoublyLL
{
    public:
        DoublyLL()
        {
            start = NULL;  
        }
        void createNode(std::string mName, Status mStatus,int mRating, std::string Remarks);
        void delElement(std::string mName);
        void modifyElement(std::string mName);
        int count();
        std::string getStatus(Status);
        void displayDLL() const;
        void displayMovieList();
        void displayPTWList();
        void displayWatchedList();
        void displayWatchingList();
        
};

#endif // __DOUBLYLL_H__