#include<iostream>
using namespace std;
typedef struct Bst
{
    int key;
    int r;
   Bst *left;
   Bst *right;
}Bst;

Bst *root;

void Inorder(Bst* p)
    {
        if (p)
        {
            Inorder(p->left);
            cout << p->key << " ";
            Inorder(p->right);
        }
    }


Bst* Getnode(int a,int r)
{
   Bst *node= new Bst;
    node->key=a;
    node->left=NULL;
    node->right=NULL;
    node->r=r;
    return node;
}

void Insert(int key,int r)
{
    if(root==NULL)
    {
        root=Getnode(key,r);
    }
    else
    {
       Bst *temp=root;
        while(temp!=NULL)
        {
            if(key==temp->key)
            {
                cout<<"Value already exists!";
                return;
            }
            //inserting element in left is value is less
            else if((key<temp->key)&&(temp->left==NULL))
            {
                temp->left=Getnode(key,r);
                break;
            }
            //traversing if element already exists
            else if(key<temp->key)
            {
                temp=temp->left;
            }
            //inserting element in right is value is greater
            else if((key>temp->key)&&(temp->right==NULL))
            {
                temp->right=Getnode(key,r);
                break;
            }
            //traversing if element already exists
            else if(key>temp->key)
            {
                temp=temp->right;
            }
        }
    }
}

int Search(int key)
{
    if (root==NULL)
        return 0;
    else
    {
       Bst *temp=root;
        while(temp!=NULL)
        {
            if(key==temp->key)
            {
                return temp->r;
            }
            else if(key<temp->key)
            {
                temp=temp->left;
            }
            else if(key>temp->key)
            {
                temp=temp->right;
            }
        }
        return 0;
    }
}
int main()
{
    int n,candy,m;
    int i=1;
    cout<<"Enter value of n:";
    cin>>n;

    for(i=1;i<=n;i++)
    {
        cout<<"enter the no. of candies for A"<<i<<" :";
        cin>>candy;
        Insert(candy,i);
    }

    cout<< "tree traversal" << endl;
    Inorder(root);
    cout << endl<<endl;
    cout<<"Enter value of m: ";
    cin>>m;

    for(int i=0;i<=m;i++)
    {
        cout<<"enter the no. of candies for M"<<i<<":";
        cin>>candy;
        int f=Search(candy);
        if(f!=0)
        {
            cout << "YES"<<endl;
        }else{
            cout<<"NO"<<endl;
        }
    }
}
