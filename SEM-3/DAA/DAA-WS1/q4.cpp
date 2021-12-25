#include <iostream>
#include <bits/stdc++.h>

using namespace std;



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

int height(Node* node)
{
    if (node == NULL)
        return 0;
    else
    {

        int lheight = height(node->left);
        int rheight = height(node->right);

        if (lheight > rheight)
        {
            return(lheight + 1);
        }
        else {
          return(rheight + 1);
        }
    }
}

void printCurrentLevel(Node* root, int level)
{
    if (root == NULL)
        return;
    if (level == 1)
        cout << root->key << " ";
    else if (level > 1)
    {
        printCurrentLevel(root->left, level-1);
        printCurrentLevel(root->right, level-1);
    }
}


void printLevelOrder(Node* root)
{
    int h = height(root);
    for (int i = 1; i <= h; i++)
        printCurrentLevel(root, i);
}




int main()
{
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};
    Node* root = NULL;

    for(int i=0;i<10;i++){
        root = insert(root, arr[i]);
    }
    printLevelOrder(root);

	return 0;
}
