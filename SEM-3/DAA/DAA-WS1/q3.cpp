
#include <iostream>
#include <bits/stdc++.h>


using namespace std;

int lcount =0;
struct Node{
    int key;
    struct Node *left,*right;
};

Node* newNode(int item)
{
	Node* temp = new Node;
	temp->key = item;
	temp->left = temp->right = NULL;
	return temp;
}


Node* insert(Node* node, int key)
{

	if (node == NULL)
		return newNode(key);

	if (key < node->key)
		node->left = insert(node->left, key);
	else
		node->right = insert(node->right, key);

	return node;
}


int leafnodes(Node *newnode)
{
    if(newnode != NULL)
    {
        leafnodes(newnode->left);
        if((newnode->left == NULL) && (newnode->right == NULL))
        {
            lcount++;
        }
        leafnodes(newnode->right);
    }
    return lcount;
}

int main()
{
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};
    int c;
    Node* root = NULL;

    for(int i=0;i<10;i++){
        root = insert(root, arr[i]);
    }
    c = leafnodes(root);
    cout << "Number of Leaf nodes in BST: " << c << endl;

	return 0;
}
