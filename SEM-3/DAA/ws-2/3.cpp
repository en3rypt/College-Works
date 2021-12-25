#include<iostream>
using namespace std;


typedef struct BST //BST struct
{
    int data;
    struct BST *right,*left;
}BST;

BST* BSTroot;


BST* newBSTNode(int item) //BST new node
{
	BST* temp = new BST;
	temp->data = item;
	temp->left = temp->right = NULL;
	return temp;
}

BST* insertBSTNode(BST* node, int data) // BST node insertion
{
	if (node == NULL)
		return newBSTNode(data);
	if (data < node->data)
		node->left = insertBSTNode(node->left, data);
	else if(data>node->data)
		node->right = insertBSTNode(node->right, data);
    else
        return node;
	return node;
}


typedef struct AVL   //AVLstruct
{
    int data;
    AVL *left;
    AVL *right;
    int height;
}AVL;
AVL *root;




AVL* newAVLNode(int dat)  //AVL new node
{
    AVL *n=new AVL;
    n->data=dat;
    n->height=1;
    n->left=n->right=nullptr;
    return n;
}


int max(int a,int b)  // to be used in combination with height calculation
{
    return (a>b)?a:b;
}
int height(AVL *node)
{
    if(node==nullptr)
        return 0;
    else
    {
        return node->height;
    }
}

int balance(AVL *node) // to calculate balance factor
{
    if(node==nullptr)
        return 0;
    else
    {
        int lh=0,rh=0;
        if(height(node->left)!=0)
            lh=height(node->left);
        if(height(node->right)!=0)
            rh=height(node->right);
        return lh-rh;
    }
}



AVL* LRot(AVL* node)  // Left rotation
{
    AVL* l=node->right;
    AVL* r=l->left;
    l->left=node;
    node->right=r;
    node->height=max(height(node->right),height(node->left))+1;
    l->height=max(height(l->right),height(l->left))+1;
    return l;
}



AVL* RRot(AVL* node) //Right rotation
{
    AVL* l=node->left;
    AVL* r=l->right;
    l->right=node;
    node->left=r;
    node->height=max(height(node->right),height(node->left))+1;
    l->height=max(height(l->right),height(l->left))+1;
    return l;
}

AVL* LRRot(AVL* p) // Left-Right rotation
{
    AVL* l = p->left;
    AVL* lr = l->right;

    l->right = lr->left;
    p->left = lr->right;

    lr->left = l;
    lr->right = p;

    l->height = max(height(l->right),height(l->left))+1;
    p->height = max(height(p->right),height(p->left))+1;
    lr->height = max(height(lr->right),height(lr->left))+1;

    if (p == root)
    {
        root = lr;
    }
    return lr;
}
AVL* RLRot(AVL* p) // Right-left rotation
{
    AVL* r = p->right;
    AVL* rl = r->left;

    r->left = rl->right;
    p->right = rl->left;

    rl->right = r;
    rl->left = p;

    r->height = max(height(r->right),height(r->left))+1;
    p->height = max(height(p->right),height(p->left))+1;
    rl->height = max(height(rl->right),height(rl->left))+1;

    if (root == p)
    {
        root = rl;
    }
    return rl;
}


AVL* insertAVLNode(AVL* node,int d) // AVL node insertion
{
    if(node==nullptr)
        return (newAVLNode(d));
    else if(node->data>d)
        node->left=insertAVLNode(node->left,d);
    else if(node->data<d)
        node->right=insertAVLNode(node->right,d);
    else
        return node;
    node->height=max(height(node->left),height(node->right))+1;
    int balanceFactor=balance(node);
    if(balanceFactor<-1 && d>node->right->data)
        return LRot(node);

    if(balanceFactor>1 && d<node->left->data)
        return RRot(node);
    if(balanceFactor<-1 && d<node->right->data)
    {
        node->right=RRot(node->right);
        return LRot(node);
    }
    if(balanceFactor>1 && d>node->left->data)
    {
        node->left=LRot(node->left);
        return RRot(node);
    }
    return node;
}

void bstInorder(BST *ptr) // Inorder traversal  of a BST
{
    if(ptr != nullptr)
    {
        bstInorder(ptr->left);
        cout << ptr->data <<" ";
        bstInorder(ptr->right);
    }
}


void currL(AVL* rot, int level)
{
    if (rot == NULL)
        return;
    if (level == 1)
        cout << rot->data << " ";
    else if (level > 1)
    {
        currL(rot->left, level-1);
        currL(rot->right, level-1);
    }
}
void lvlOrder(AVL* rot)
{
    int h = height(root);
    int i;
    for (i = 1; i <= h; i++)
        currL(rot, i);
}



void avlInorder(AVL *root)
{
    if(root != NULL)
    {
        avlInorder(root->left);
        cout << root->data << " " << root->height << endl;
        avlInorder(root->right);
    }
}


BST* mergeBST(BST *r1,BST *r2)
{
    BST *ptr=r1;
    if(ptr!=nullptr)
    {
        mergeBST(ptr->left,r2);
        r2=insertBSTNode(r2,ptr->data);
        mergeBST(ptr->right,r2);
    }
    return r2;
}

AVL* makeAVL(AVL *a, BST *b)
{
    BST *ptr=b;
    if(ptr!=nullptr)
    {
        a=makeAVL(a,ptr->left);
        a=insertAVLNode(a,ptr->data);
        a=makeAVL(a,ptr->right);
    }
    return a;
}


int main()
{
    root=nullptr;
    BST *r1=nullptr,*r2=nullptr,*r=nullptr;


    cout<<"BST 1"<<endl;
    r1=insertBSTNode(r1,1);
    r1=insertBSTNode(r1,2);
    r1=insertBSTNode(r1,3);
    bstInorder(r1);
    cout<<endl<<endl;


    cout<<"BST 2"<<endl;
    r2=insertBSTNode(r2,4);
    r2=insertBSTNode(r2,5);
    r2=insertBSTNode(r2,6);
    bstInorder(r2);
    cout<<endl<<endl;


    cout<<"Merging the BST, and making an AVL..."<<endl;
    r=mergeBST(r1,r2);
    cout<<endl<<endl;


    cout<<"AVL"<<endl;
    root=makeAVL(root,r);
    lvlOrder(root);
    cout<<endl<<endl;

    return 0; //return sucess
}
