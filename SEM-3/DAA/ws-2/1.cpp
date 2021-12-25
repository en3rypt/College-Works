#include <iostream>
using namespace std;

struct node
{
    int data;
    node* left;
    node* right;
    int height;
};

class avlTree
{
    public:
    node* root;

    avlTree()
    {
        root = nullptr;
    }


    int height(node* p)
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

    int getBalanceFactor(node* p)
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

    node* ll_Rotation(node* p)
    {
        node* l = p->left;
        node* lr = l->right;

        l->right = p;
        p->left = lr;


        p->height = height(p);
        l->height = height(l);

        if (root == p)
        {
            root = l;
        }
        return l;
    }

    node* rr_Rotation(node* p)
    {
        node* r = p->right;
        node* rl = r->left;

        r->left = p;
        p->right = rl;


        p->height = height(p);
        r->height = height(r);


        if (root == p)
        {
            root = r;
        }
        return r;
    }


    node* Insert(node* p, int key)
    {
        node* temp;
        if (p == nullptr)
        {
            temp = new node;
            temp->data = key;
            temp->left = nullptr;
            temp->right = nullptr;
            temp->height = 1;
            return temp;
        }

        if (key < p->data)
        {
            p->left = Insert(p->left, key);
        }
        else if (key > p->data)
        {
            p->right = Insert(p->right, key);
        }

        p->height = height(p);


        node* R = nullptr;
        if (getBalanceFactor(p) >1 && getBalanceFactor(p->left) == 1)
        {
            R = ll_Rotation(p);
            cout << "Tree after LL rotation" << endl;
            Inorder();
            cout<< endl;
            return R;
        }
        else if (getBalanceFactor(p) >1 && getBalanceFactor(p->left) == -1)
        {

            p->left = ll_Rotation(p->left);
            R = rr_Rotation(p);

            cout << "Tree after LR rotation" << endl;
            Inorder();
            cout<<endl;
            return R;
        }
        else if (getBalanceFactor(p) <-1 && getBalanceFactor(p->right) == -1)
        {

            R = rr_Rotation(p);

            cout << "Tree after RR rotation" << endl;
            Inorder();
            cout<<endl;
            return R;
        }
        else if (getBalanceFactor(p) <-1 && getBalanceFactor(p->right) == 1)
        {


            p->right = rr_Rotation(p->right);
            R = ll_Rotation(p);

            cout << "Tree after RL rotation" << endl;
            Inorder();
            cout<<endl;
            return R;
        }

        return p;
    }

    // Traversals
    void Inorder(node* p)
    {
        if (p)
        {
            Inorder(p->left);
            cout << p->data << " ";
            Inorder(p->right);
        }
    }

    void Inorder()
    {
        Inorder(root);
    }

    node* getRoot()
    {
        return root;
    }

};

int main()
{
    avlTree tree;
    int n,k;
    cout << "Enter number of elements: ";
    cin >> n;
    for(int i=0 ;i<n;i++){
        cout << "Enter Element A" <<i << ": ";
        cin >> k;
        cout << "Inserting " << k << endl;
        tree.root = tree.Insert(tree.root,k);
        cout << "tree after Inserting "<<k << endl;
        tree.Inorder();
        cout<< endl;
        cout << endl;

    }

    return 0;
}


