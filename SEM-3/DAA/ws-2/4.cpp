#include<iostream>
#include<stack>
#include<queue>
using namespace std;

typedef struct Node
{
    int key;
    Node* left;
    Node* right;
}Node;

Node *root,*root1,*root2;

Node* Create(int val)
{
    Node* n=new Node;
    n->key=val;
    n->left=n->right=nullptr;
    return n;
}

Node* Insert(Node* p,int val)
{
    if(p==nullptr)
        return Create(val);
    if(p->key<val)
        p->right=Insert(p->right,val);
    else if(p->key>val)
        p->left=Insert(p->left,val);
    return p;
}

Node* Zig(Node* p)
{
    Node* temp=p->left;
    p->left=temp->right;
    temp->right=p;
    return temp;
}

Node* Zag(Node* p)
{
    Node* temp=p->right;
    p->right=temp->left;
    temp->left=p;
    return temp;
}

Node* Zig_Zag(Node* p)
{
    p->left=Zag(p->left);
    Node* temp=Zig(p);
    return temp;
}

Node* Zag_Zig(Node* p)
{
    p->right=Zig(p->right);
    Node* temp=Zag(p);
    return temp;
}

int Height(Node* k)           //to get height
{
    int hl,hr;
    hl=(k && k->left) ? Height(k->left) : 0;
    hr=(k && k->right) ? Height(k->right) : 0;
    return hl>hr ? hl+1 : hr+1;
}

Node* splay(Node* root, int val)
{
    stack<Node *> s;
    Node *par, *gpar;
    Node *ptr = root;

    while(ptr!=nullptr && ptr->key!=val)
    {
        s.push(ptr);
        if(val < ptr->key)
            ptr = ptr->left;
        else if(val > ptr->key)
            ptr = ptr->right;
    }
    if(ptr == nullptr)
        return root;
    while(!s.empty())
    {
        par = s.top();
        if(ptr->key < par->key)
            par->left = ptr;
        else
            par->right = ptr;
        s.pop();
        if(s.size()!=0)
        {
            gpar = s.top();
            s.pop();
        }
        else
            gpar = nullptr;

        if(gpar == nullptr)
        {
            if(ptr->key > par->key)
            {
                par = Zag(par);
            }
            else
            {
                par = Zig(par);
            }
        }
        else
        {
            if(par->key < gpar->key && ptr->key < par->key)
            {
                gpar = Zig(gpar);
                gpar = Zig(gpar);
            }
            else if(par->key > gpar->key && ptr->key > par->key)
            {
                gpar = Zag(gpar);
                gpar = Zag(gpar);
            }

            else if(par->key< gpar->key && ptr->key > par->key)
            {
                gpar = Zig_Zag(gpar);
            }

            else if(par->key > gpar->key && ptr->key < par->key)
            {
                gpar = Zag_Zig(gpar);
            }
        }
    }
    return ptr;
}

void printLevelOrder(Node *node,int level)
{
    if(node==nullptr)
        return;
    else if(level==1)
        cout<<node->key<<" ";
    else if(level>1)
    {
        printLevelOrder(node->left,level-1);
        printLevelOrder(node->right,level-1);
    }
}
void LevelOrder(Node* root)
{
    int a=Height(root);
    int i;
    for(i=0;i<=a;i++)
        printLevelOrder(root,i);
}

Node* Currentlevel_splaying(Node* root1, Node* root2,int level)
{
    if (root2==nullptr)
        return root1;
    if (level==1)
        root1=splay(root1,root2->key);
    else if (level>1)
    {
        root1->left=Currentlevel_splaying(root1->left,root2->left,level-1);
        root1->right=Currentlevel_splaying(root1->right,root2->right,level-1);
    }
    return root1;
}
Node* Levelorder_splaying(Node* root1,Node* root2)
{
    int h = Height(root2);
    for (int i = 1; i <= h; i++)
        root1=Currentlevel_splaying(root1,root2,i);
    return root1;
}

int main()
{
    root1=root2=root=nullptr;  //insertion for 1st BST
    root1=Insert(root1,12);
    root1=Insert(root1,10);
    root1=Insert(root1,8);
    root1=Insert(root1,35);
    root1=Insert(root1,25);
    root1=Insert(root1,40);
    cout << "BST 1" << endl;
    LevelOrder(root1);
    cout<<endl<<endl;

    root2=Insert(root2,8);    //insertion for 2nd BST
    root2=Insert(root2,35);
    root2=Insert(root2,25);
    root2=Insert(root2,40);
    root2=Insert(root2,10);
    root2=Insert(root2,12);
    cout << "BST 2" << endl;
    LevelOrder(root2);
    cout<<endl<<endl;

    root1=Levelorder_splaying(root1,root2);
    cout << "After convertion" <<endl;
    LevelOrder(root1);
    cout<<endl;
}
