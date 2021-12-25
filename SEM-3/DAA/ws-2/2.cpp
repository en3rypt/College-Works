#include <iostream>
#include <vector>
using namespace std;

struct Node
{
    int data;
    Node* left;
    Node* right;
    int height;
};

class avl
{
    public:
        Node* root;
        int leafcount;


    avl()
    {
        root = nullptr;
        leafcount = 0;
    }

    // helpers
    int height(Node* p)
    {
        int hl;
        int hr;
        if(p && p->left){
            hl =p->left->height;
        }else{
            hl = 0;
        }

        if(p && p->right){
            hr =p->right->height;
        }else{
            hr = 0;
        }

        if(hl>hr){
            return hl +1;
        }else{
            return hr+1;
        }
    }

    int balanceFactor(Node* p)
    {
        int hl;
        int hr;


        if(p && p->left){
            hl =p->left->height;
        }else{
            hl = 0;
        }

        if(p && p->right){
            hr =p->right->height;
        }else{
            hr = 0;
        }

        return hl - hr;
    }
    Node* LLRotation(Node* p)
    {
        Node* pl = p->left;
        Node* plr = pl->right;

        pl->right = p;
        p->left = plr;

        // Update height
        p->height = height(p);
        pl->height = height(pl);

        // Update root
        if (root == p)
        {
            root = pl;
        }
        return pl;
    }

    Node* RRRotation(Node* p)
    {
        Node* pr = p->right;
        Node* prl = pr->left;

        pr->left = p;
        p->right = prl;

        // Update height
        p->height = height(p);
        pr->height = height(pr);

        // Update root
        if (root == p)
        {
            root = pr;
        }
        return pr;
    }

    Node* LRRotation(Node* p)
    {
        Node* pl = p->left;
        Node* plr = pl->right;

        pl->right = plr->left;
        p->left = plr->right;

        plr->left = pl;
        plr->right = p;

        //Update height
        pl->height = height(pl);
        p->height = height(p);
        plr->height = height(plr);

        //Update root
        if (p == root)
        {
            root = plr;
        }
        return plr;
    }

    Node* RLRotation(Node* p)
    {
        Node* pr = p->right;
        Node* prl = pr->left;

        pr->left = prl->right;
        p->right = prl->left;

        prl->right = pr;
        prl->left = p;

        //Update height
        pr->height = height(pr);
        p->height = height(p);
        prl->height = height(prl);

        //Update root
        if (root == p)
        {
            root = prl;
        }
        return prl;
    }


    // Insert
    Node* Insert(Node* p, int key)
    {
        Node* t;
        if (p == nullptr)
        {
            t = new Node;
            t->data = key;
            t->left = nullptr;
            t->right = nullptr;
            t->height = 1;  // Starting height from 1
            return t;
        }

        if (key < p->data)
        {
            p->left = Insert(p->left, key);
        }
        else if (key > p->data)
        {
            p->right = Insert(p->right, key);
        }

        // Update height
        p->height = height(p);

        // Balance Factor and Rotation
        Node* R = nullptr;
        if (balanceFactor(p) == 2 && balanceFactor(p->left) == 1)
        {
            R = LLRotation(p);
            return R;
        }
        else if (balanceFactor(p) == 2 && balanceFactor(p->left) == -1)
        {
            R = LRRotation(p);
            return R;
        }
        else if (balanceFactor(p) == -2 && balanceFactor(p->right) == -1)
        {
            R = RRRotation(p);
            return R;
        }
        else if (balanceFactor(p) == -2 && balanceFactor(p->right) == 1)
        {
            R = RLRotation(p);
            return R;
        }

        return p;
    }

    Node* InPre(Node* p)
    {
        while(p && p->left != nullptr)
        {
            p = p->left;
        }
        return p;
    }
    Node* InSucc(Node* p)
    {
        while(p && p->right != nullptr)
        {
            p = p->right;
        }
        return p;
    }

    Node* deleteNode(Node* p, int key)
    {
        Node* q;

        if (p == nullptr)
        {
            return nullptr;
        }

        if (p->left == nullptr && p->right == nullptr)
        {
            if (p == root)
            {
                root = nullptr;
            }
            delete p;
            return nullptr;
        }

        if (key < p->data)
        {
            p->left = deleteNode(p->left, key);
        }
        else if (key > p->data)
        {
            p->right = deleteNode(p->right, key);
        }
        else
        {
            if (height(p->left) > height(p->right))
            {
                q = InPre(p->left);
                p->data = q->data;
                p->left = deleteNode(p->left, q->data);
            }
            else
            {
                q = InSucc(p->right);
                p->data = q->data;
                p->right = deleteNode(p->right, q->data);
            }
        }

        //Updating the height of  the current node.
        p->height = height(p);

        //Performing  rotations after the deletions.
        Node* R = nullptr;
        if (balanceFactor(p) == 2 && balanceFactor(p->left) == 1)
        {
            R = LLRotation(p);
            return R;
        }
        else if (balanceFactor(p) == 2 && balanceFactor(p->left) == -1)
        {
            R = LRRotation(p);
            return R;
        }
        else if (balanceFactor(p) == -2 && balanceFactor(p->right) == -1)
        {
            R = RRRotation(p);
            return R;
        }
        else if (balanceFactor(p) == -2 && balanceFactor(p->right) == 1)
        {
            R = RLRotation(p);
            return R;
        }

        //return the root
        return p;
    }

    // Traversals
    void Inorder(Node* p)
    {
        if (p)
        {
            Inorder(p->left);
            cout << p->data << " ";
            Inorder(p->right);
        }
    }
    void range(Node* p, int a, int b)
    {
        if (p)
        {
            range(p->left,a,b);
            if(p->data > a && p->data < b)
                cout << p->data << " ";
            range(p->right,a,b);
        }
    }
    void Inorder()
    {
        Inorder(root);
    }
    Node* getRoot()
    {
        return root;
    }

    void printCurrentLevel(Node* root, int level)
    {
        if (root == NULL)
            return;
        if (level == 1)
            cout << root->data << " ";
        else if (level > 1)
        {
            printCurrentLevel(root->left, level-1);
            printCurrentLevel(root->right, level-1);
        }
    }
    void print_Level_Order(Node* root)
    {
        int h = height(root);
        int i;
        for (i = 1; i <= h; i++)
            printCurrentLevel(root, i);
    }

    //Searches
    Node* searchNode(Node *p, int key)
    {
        if (p == nullptr)
        {
            cout<<"Element not found"<<endl;
            return nullptr;
        }

        if (key == p->data)
        {
            cout<<"Element found."<<endl;
            return p;
        }
        else if (key < p->data)
        {
            return searchNode(p->left, key);
        }
        else
        {
            return searchNode(p->right, key);
        }
    }
    int minValue(Node* p)
    {
        return InPre(p)->data;
    }

    //Counts
    int no_of_Leafs(Node* p)
    {
        if(p)
        {
            no_of_Leafs(p->left);
            if(p->left == nullptr && p->right == nullptr)
            {
                leafcount++;
            }
            no_of_Leafs(p->right);
        }
        return leafcount;
    }
    int no_of_Leafs()
    {
        return no_of_Leafs(root);
    }
};


int main()
{
    avl tree;

    tree.root = tree.Insert(tree.root,10);
    tree.root = tree.Insert(tree.root,20);
    tree.root = tree.Insert(tree.root,30);
    tree.root = tree.Insert(tree.root,40);
    tree.root = tree.Insert(tree.root,25);
    tree.root = tree.Insert(tree.root,45);

    cout << "Initial tree structure: " <<endl;
    tree.Inorder(tree.root);
    cout<<endl<<endl;



    //2a
    int min = tree.minValue(tree.root);
    tree.root = tree.deleteNode(tree.root,min);
    cout<<"\nAfter deletion of min."<<endl;
    tree.Inorder(tree.root);
    cout<<endl<<endl;


    //2b
    tree.root = tree.deleteNode(tree.root,35);
    cout<<"\nTree after deleting node with only left child "<<endl;
    tree.print_Level_Order(tree.root);
    cout<<endl<<endl;


    //2c
    int rootdata = tree.root->data;
    tree.root = tree.deleteNode(tree.root,rootdata);
    cout<<"\nTree after deleting of the root node " << rootdata<<endl;
    tree.Inorder(tree.root);
    cout<<endl<<endl;


    //2d
    int elt;
    cout << "Enter element to search: ";
    cin >> elt;
    tree.searchNode(tree.root,elt);
    cout<<endl<<endl;


    //2e
    cout<<"Inorder Traversal:"<<endl;
    tree.Inorder(tree.root);
    cout<<endl;


    cout<<endl;
    cout<<endl;


    //2f
    cout<<"Height of the AVL tree : "<<tree.root->height<<endl;

    cout<<endl;
    cout<<endl;

    //2g
    cout<<"Keys inbetween 10 and 100:"<<endl;
    tree.range(tree.root,10,100);
    cout<<endl;

    cout<<endl;
    cout<<endl;


    //2h
    cout<<"No of leaf nodes in the tree :"<<tree.no_of_Leafs()<<endl;


    cout<<endl;
    cout<<endl;






    return 0;
}

