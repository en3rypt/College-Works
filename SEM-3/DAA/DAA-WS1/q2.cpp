
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

void Search(Node *root, int value) {

   int search_times = 0;
   Node *temp = new Node;
   temp = root;
   while(temp != NULL) {
      search_times++;
      if(temp->key == value) {
         cout<< "Number of searches took to find "<<value << " : " << search_times<< endl;
         return;
      } else if(temp->key > value)
         temp = temp->left;
         else
            temp = temp->right;
   }
   cout<< value << " not present in BST" << endl;
   return;
}



int main()
{
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};
    Node* root = NULL;

    for(int i=0;i<10;i++){
        root = insert(root, arr[i]);
    }
    Search(root,10);

	return 0;
}


