#include <iostream>
#include "../Headers/DoublyLL.hpp"
#include <string>
#include <iomanip>
using namespace std;


//make a new node and add it to the end of the list
void DoublyLL::createNode(string mName, Status mStatus = PlanningToWatch, int mRating = 0, string Remarks = "-")
{
    struct Node *s, *temp;
    temp = new(struct Node); 
    temp->mName = mName;
    temp->mStatus = mStatus;
    temp->mRating = mRating;
    temp->mRemarks = Remarks;

    temp->next = NULL;
    if (start == NULL)
    {
        temp->prev = NULL;
        start = temp;
    }
    else
    {
        s = start;
        while (s->next != NULL)
            s = s->next;
        s->next = temp;
        temp->prev = s;
    }
}

//modify a node from the linked list
void DoublyLL::modifyElement(string mName)
{
    struct Node *tmp, *q;
    int innerChoice,movieRating;
    //first element detection
    if (start->mName == mName)
    {
        cout<<"Enter the  status of the movie :\n0-Watched\n1-Watching\n2-PlanningToWatch\n";
            cin>>innerChoice;
            cin.get();
            switch(innerChoice)
            {
                case 0:
                    start->mStatus = Watched;
                    break;
                case 1:
                    start->mStatus = Watching;
                    break;
                case 2:
                    start->mStatus = PlanningToWatch;
                    break;
                default:
                    cout<<"Invalid choice. Exiting to Menu...";
                    return;
            }
        cout<<"Enter your rating for the movie (1 - 10):"<<endl;
        cin>>movieRating;
        cin.get();
        if (movieRating < 1 || movieRating > 10)
        {
            cout<<"Invalid rating. Exiting to Menu...";
            return;
        }
        else
        {
            start->mRating = movieRating;
        }
        cout<<"Enter any remarks for the movie in one line:";
        getline(cin,start->mRemarks);
        cout<<"Remarks Noted.";
        return;
    }

    q = start;
    while (q->next->next != NULL)
    {   
        //element modification
        if (q->next->mName == mName)  
        {
            tmp = q->next;
            cout<<"Enter the  status of the movie :\n0-Watched\n1-Watching\n2-PlanningToWatch\n";
            cin>>innerChoice;
            cin.get();
            switch(innerChoice)
            {
                case 0:
                    tmp->mStatus = Watched;
                    break;
                case 1:
                    tmp->mStatus = Watching;
                    break;
                case 2:
                    tmp->mStatus = PlanningToWatch;
                    break;
                default:
                    cout<<"Invalid choice. Exiting to Menu...";
                    return;
            }
        cout<<"Enter your rating for the movie (1 - 10):"<<endl;
        cin>>movieRating;
        cin.get();
        if (movieRating < 1 || movieRating > 10)
        {
            cout<<"Invalid rating. Exiting to Menu...";
            return;
        }
        else
        {
            tmp->mRating = movieRating;
        }
        cout<<"Enter any remarks for the movie in one line:";
        getline(cin,tmp->mRemarks);
        cout<<"Remarks Noted.";
        }
        q = q->next;
    }

    //element modification at the end
    if (q->next->mName == mName)    
    { 	
        tmp = q->next;
        cout<<"Enter the  status of the movie :\n0-Watched\n1-Watching\n2-PlanningToWatch\n";
            cin>>innerChoice;
            cin.get();
            switch(innerChoice)
            {
                case 0:
                    tmp->mStatus = Watched;
                    break;
                case 1:
                    tmp->mStatus = Watching;
                    break;
                case 2:
                    tmp->mStatus = PlanningToWatch;
                    break;
                default:
                    cout<<"Invalid choice. Exiting to Menu...";
                    return;
            }
        cout<<"Enter your rating for the movie (1 - 10):"<<endl;
        cin>>movieRating;
        cin.get();
        if (movieRating < 1 || movieRating > 10)
        {
            cout<<"Invalid rating. Exiting to Menu...";
            return;
        }
        else
        {
            tmp->mRating = movieRating;
        }
        cout<<"Enter any remarks for the movie in one line:";
        getline(cin,tmp->mRemarks);
        cout<<"Remarks Noted.";
        return;
    }

    cout<<"Movie "<<mName<<" not found in the list."<<endl;
    return;
}


//delete a node from the linked list
void DoublyLL::delElement(string mName)
{
    struct Node *tmp, *q;
    //first element deletion
    if (start->mName == mName)
    {
        tmp = start;
        start = start->next;  
        start->prev = NULL;
        cout<<mName<<" deleted from the list."<<endl;
        free(tmp);
        return;
    }

    q = start;
    while (q->next->next != NULL)
    {   
        //element deletion inbetween
        if (q->next->mName == mName)  
        {
            tmp = q->next;
            q->next = tmp->next;
            tmp->next->prev = q;
            cout<<mName<<" deleted from the list."<<endl;
            free(tmp);
            return;
        }
        q = q->next;
    }
    //element deletion at the end
    if (q->next->mName == mName)    
    { 	
        tmp = q->next;
        free(tmp);
        q->next = NULL;
        cout<<mName<<" deleted from the list."<<endl;
        return;
    }
    cout<<"Movie "<<mName<<" not found in the list."<<endl;
}


 
//display the movie list in the double linked list format
void DoublyLL::displayDLL() const
{
    struct Node *q;
    if (start == NULL)
    {
        cout<<"The list is empty, add some movies to delete."<<endl;
        return;
    }

    q = start;
    cout<<"The Doubly Link List is :"<<endl;
    while (q != NULL)
    {
        cout<<q->mName<<" <-> ";
        q = q->next;
    }
    cout<<"NULL"<<endl;
}
 
//display the count of the movies in the list
int DoublyLL::count()
{ 	
    struct Node *q = start;
    int cnt = 0;
    while (q != NULL)
    {
        q = q->next;
        cnt++;
    }
    return cnt;
}

//to display the actual status from the status number
string DoublyLL::getStatus(Status mStatus)
{
    switch (mStatus)
    {
        case Watched:
            return "Watched";
            break;
        case Watching:
            return "Watching";
            break;
        case PlanningToWatch:
            return "Planning to watch";
            break;
        default:
            return "ERROR";
    }
}

//display the entire movie list
void DoublyLL::displayMovieList() 
{
    struct Node *q;
    if (start == NULL)
    {
        cout<<"The list is empty, add some movies to view."<<endl;
        return;
    }

    q = start;
    cout<<"Your movie list:"<<endl;
    cout<<"Name"<<setw(26)<<" | "<<"Status"<<setw(24)<<" | "<<"Rating"<<setw(24)<<" | "<<"Remarks"<<endl;
    while (q != NULL)
    {
        cout<<q->mName<<setw(30-q->mName.length())<<" | "<<getStatus(q->mStatus)<<setw(30-getStatus(q->mStatus).length())<<" | "<<q->mRating<<setw(28)<<" | "<<q->mRemarks<<endl;
        q = q->next;
    }
}

//display the the movies watched
void DoublyLL::displayWatchedList() 
{
    struct Node *q;
    if (start == NULL)
    {
        cout<<"The list is empty, add some movies to view."<<endl;
        return;
    }

    q = start;
    cout<<"Your watched movie list:"<<endl;
    cout<<"Name"<<setw(26)<<" | "<<"Status"<<setw(24)<<" | "<<"Rating"<<setw(24)<<" | "<<"Remarks"<<endl;
    while (q != NULL)
    {
        if(q->mStatus == Watched)
            cout<<q->mName<<setw(30-q->mName.length())<<" | "<<getStatus(q->mStatus)<<setw(30-getStatus(q->mStatus).length())<<" | "<<q->mRating<<setw(28)<<" | "<<q->mRemarks<<endl;
        q = q->next;
    }
}

//display the movies watching
void DoublyLL::displayWatchingList() 
{
    struct Node *q;
    if (start == NULL)
    {
        cout<<"The list is empty, add some movies to view."<<endl;
        return;
    }

    q = start;
    cout<<"Your watching movie list:"<<endl;
    cout<<"Name"<<setw(26)<<" | "<<"Status"<<setw(24)<<" | "<<"Rating"<<setw(24)<<" | "<<"Remarks"<<endl;
    while (q != NULL)
    {
        if(q->mStatus == Watching)
            cout<<q->mName<<setw(30-q->mName.length())<<" | "<<getStatus(q->mStatus)<<setw(30-getStatus(q->mStatus).length())<<" | "<<q->mRating<<setw(28)<<" | "<<q->mRemarks<<endl;
        q = q->next;
    }
}

//display the movies planned to watch
void DoublyLL::displayPTWList() 
{
    struct Node *q;
    if (start == NULL)
    {
        cout<<"The list is empty, add some movies to view."<<endl;
        return;
    }

    q = start;
    cout<<"Your PlanningToWatch movie list:"<<endl;
    cout<<"Name"<<setw(26)<<" | "<<"Status"<<setw(24)<<" | "<<"Rating"<<setw(24)<<" | "<<"Remarks"<<endl;
    while (q != NULL)
    {
        if(q->mStatus == PlanningToWatch)
            cout<<q->mName<<setw(30-q->mName.length())<<" | "<<getStatus(q->mStatus)<<setw(30-getStatus(q->mStatus).length())<<" | "<<q->mRating<<setw(28)<<" | "<<q->mRemarks<<endl;
        q = q->next;
    }
}