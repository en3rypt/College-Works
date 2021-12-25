#include<iostream>
using namespace std;



typedef struct node
{
    int data;
    node *left;
    node *right;
    node *pa;
}node;
node *root;


node* newnode(int dat)
{
    node *n=new node;
    n->data=dat;
    n->pa=n->left=n->right=nullptr;
    return n;
}


node* zig(node *y)
{
    node *x=y->left;
    node *r=x->right;
    x->right=y;
    y->left=r;
    x->pa=y->pa;
    y->pa=x;
    if(y->left !=nullptr)
    {
        y->left->pa = y;
    }
    return x;
}

node* zag(node *y)
{
    node *x=y->right;
    node *l=x->left;
    x->left=y;
    y->right=l;
    x->pa=y->pa;
    y->pa=x;
    if(y->right !=nullptr)
    {
        y->right->pa = y;
    }
    return x;
}

node *splay(node *p,node *k)
{
    node *gpp;
    while (k->pa!=nullptr)
    {
        if (k->pa == p)
        {
            if(p->left == k)
            {
                p = zig(p);

            }
            else
            {
                p = zag(p);

            }
        }
        else
        {
            node *par = k->pa;
            node *g = par->pa;
            if (k->data < par->data && par->data < g->data)
            {
                if(g==p)
                {
                    p = zig(g);
                    p = zig(p);
                }
                else
                {
                    gpp=g->pa;
                    if(g->data<gpp->data)
                    {
                        gpp->left = zig(g);
                        gpp->left = zig(gpp->left);
                    }
                    else
                    {
                        gpp->right = zig(g);
                        gpp->right = zig(gpp->right);
                    }
                }

            }
            else if(k->data > par->data && par->data > g->data)
            {
                if(g==p)
                {
                    p = zag(g);
                    p = zag(p);
                }
                else
                {
                    gpp=g->pa;
                    if(g->data>gpp->data)
                    {
                        gpp->right = zag(g);
                        gpp->right = zag(gpp->right);
                    }
                    else
                    {
                        gpp->left = zag(g);
                        gpp->left = zag(gpp->left);
                    }
                }
            }
            else if(k->data < par->data && par->data > g->data)
            {
                g->right= zig(par);
                if(g==p)
                    p=zag(g);
                else
                    {
                        gpp=g->pa;
                        if(g->data>gpp->data)
                        {
                            gpp->right = zag(g);
                        }
                        else
                        {
                            gpp->left = zag(g);
                        }
                    }
            }
            else
            {
                g->left = zag(par);
                if(g==p)
                    p = zig(g);
                else
                    {
                        gpp=g->pa;
                        if(g->data<gpp->data)
                            gpp->left=zig(g);
                        else
                            gpp->right=zig(g);
                    }
            }

        }
    }
    return p;
}
int height(node* nod)
{
    if (nod == NULL)
        return 0;
    else
    {
        int lheight = height(nod->left);
        int rheight = height(nod->right);

        if (lheight > rheight)
        {
            return(lheight + 1);
        }
        else
        {
          return(rheight + 1);
        }
    }
}

void CurrentLevel(node* rot, int level)
{
    if (rot == NULL)
        return;
    if (level == 1)
        cout << rot->data << " ";
    else if (level > 1)
    {
        CurrentLevel(rot->left, level-1);
        CurrentLevel(rot->right, level-1);
    }
}
void LevelOrder(node* rot)
{
    int h = height(rot);
    int i;
    for (i = 1; i <= h; i++)
        CurrentLevel(rot, i);
}

node *Insert(node *p, int d)
{
    node *temp = p;
    node *y = NULL;
    node *k = newnode(d);
    while (temp!= NULL)
        {
            y = temp;
            if (d<y->data)
            {
                temp = y->left;
            }
            else
            {
                temp =y->right;
            }
        }

    if (y == NULL)
    {
        return k;
    }
    else if (d < y->data)
    {
        y->left = k;
        k->pa = y;
    }
    else
    {
        y->right = k;
        k->pa = y;
    }
    p = splay(p,k);
    return p;

}

void inorder(node *r)
{
    if(r != NULL)
    {
        inorder(r->left);
        cout << r->data << " ";
        inorder(r->right);
    }
}

node *Search(node *p,int k)
{
    node *y=p;
    while (y!= nullptr)
        {
            if (k<y->data)
            {
                y = y->left;
            }
            else if (k>y->data)
            {
                y =y->right;
            }
            else
            {
                p=splay(p,y);
                return(p);
            }
        }

    return y;


}
node* pre(node* nod)
{
    while(nod->right!=nullptr)
        nod=nod->right;
    return nod;
}

node* Delete(node *p,int k)
{
    node *lc,*rc;
    node *m;
    node *dtemp;
    node *temp;
    temp = Search(p,k);
    if(temp==nullptr)
    {
        cout<<"Element not found\n";
        return nullptr;
    }
    else
    {
        if(temp->left==nullptr || temp->right==nullptr)
        {
            if(temp->left==temp->right)
                temp=nullptr;
            else if(temp->left==nullptr)
            {
                dtemp=temp;
                temp=temp->right;
                delete(dtemp);
                temp->pa=nullptr;
            }
            else
            {
                dtemp=temp;
                temp=temp->left;
                delete(dtemp);
                temp->pa=nullptr;
            }
        }
        else
        {
            dtemp=temp;
            lc=dtemp->left;
            rc=dtemp->right;
            m=pre(lc);
            lc->pa=nullptr;
            rc->pa=nullptr;
            lc=splay(lc,m);
            lc->right=rc;
            rc->pa=lc;
            delete(dtemp);
            return(lc);
        }
    }
    return(temp);
}


//KEYS COUNT FUNCTION
int get_count(node *root, int Start, int End)
{
    if (root == nullptr){
        return 0;
    }

    if (root->data <=  End && root->data >= Start)
         return 1 + get_count(root->left, Start,  End) +
                    get_count(root->right, Start,  End);

    else if (root->data < Start){
        return get_count(root->right, Start, End);
    }

    else {
        return get_count(root->left, Start, End);
            }
}

int get_count(node *root)
{
    int c=1;

    if (root ==NULL)
        return 0;

    else
    {
        c += get_count(root->left);
        c += get_count(root->right);
        return c;
    }
}


int main()
{
    int elt,data,h,a,b,n;
    node *s;
    node* root = NULL;

    cout << "Enter number of elements: ";
    cin >> n;
    for (int i=0;i<n;i++){
        cout << "Enter element " << i+1 << ": ";
        cin >> data;
        root = Insert(root,data);
    }


    /*inorder traversal*/
    inorder(root);
    cout << endl;
    /*height of tree*/
    h = height(root);
    cout <<endl<< "height of tree: " << h << endl<<endl;


    /*Search element*/
    cout << "Enter element to search : ";
    cin >> elt;
    s = Search(root,elt);

    if(s){
        root = s;
        LevelOrder(root);
        cout << endl;
    }else{
        cout << "Element: " << elt << " not found"<<endl<<endl;
    }


    //count keys in given range
    cout << "Enter lower limit(a): ";
    cin >> a;
    cout << "Enter upper limit(b): ";
    cin >> b;
    h = get_count(root,a,b);
    cout << "Count of elements between the given range [" << a << " , " << b << "]" << " : " <<h << endl <<endl;

    /*largest key in the tree*/
    s = pre(root);
    data = s->data;
    cout << "Largest key: " << data << endl << endl;


    /* delete Largest key*/
    cout << "Tree before Deleting " << data<<endl;
    LevelOrder(root);
    cout << endl;
    root = Delete(root,s->data);
    cout << "Tree after Deleting " << data <<endl;
    LevelOrder(root);
    cout<<endl << endl;


    /* deleting tree until only 3 element remains */
    h = get_count(root);
    while (h>3){
        s = pre(root);
            data = s->data;
            root = Delete(root,s->data);
            cout << "Deleted: " << data<< endl;
            h-=1;
    }
    cout << "Final tree: " << endl;
    LevelOrder(root);
    cout << endl;


    return 0;
}
