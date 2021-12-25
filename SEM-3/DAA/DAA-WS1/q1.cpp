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





Node* deleteNode(Node* root, int k)
{

	if (root == NULL)
		return root;


	if (root->key > k) {
		root->left = deleteNode(root->left, k);
		return root;
	}
	else if (root->key < k) {
		root->right = deleteNode(root->right, k);
		return root;
	}


	if (root->left == NULL) {
		Node* temp = root->right;
		delete root;
		return temp;
	}
	else if (root->right == NULL) {
		Node* temp = root->left;
		delete root;
		return temp;
	}

	else {

		Node* succParent = root;

		Node* succ = root->right;
		while (succ->left != NULL) {
			succParent = succ;
			succ = succ->left;
		}

		if (succParent != root)
			succParent->left = succ->right;
		else
			succParent->right = succ->right;


		root->key = succ->key;


		delete succ;
		return root;
	}
}

int minValue(Node* node)
{
Node* current = node;


while (current->left != NULL)
{
    current = current->left;
}
return(current->key);
}

int maxValue(Node* node)
{
Node* current = node;

while (current->right != NULL)
{
    current = current->right;
}
return(current->key);
}

void Search(Node *root, int value) {
   int depth = 0;
   Node *temp = new Node;
   temp = root;
   while(temp != NULL) {
      depth++;
      if(temp->key == value) {
         cout<< value <<"found at depth: "<<depth << endl;
         return;
      } else if(temp->key > value)
         temp = temp->left;
         else
            temp = temp->right;
   }
   cout<< value << " not found" << endl;
   return;
}

void get_left_child(Node *root, int value) {
   Node *temp = new Node;
   temp = root;

   while(temp != nullptr) {
      if(temp->key == value) {
          temp = temp->left;
          if(temp->key){
            cout <<"Left child of given node : "<< temp->key << endl;
          }else{
              cout << "No left child for given node" << endl;
          }

         return;
      } else if(temp->key > value)
         temp = temp->left;
         else
            temp = temp->right;
   }
   cout<< value << " node not found" << endl;

   return;
}


void get_right_child(Node *root, int value) {
   Node *temp = new Node;
   temp = root;

   while(temp != nullptr) {
      if(temp->key == value) {
          temp = temp->right;
          if(temp->key){
            cout <<"Right child of given node : "<< temp->key << endl;
          }else{
              cout << "No left child for given node" << endl;
          }

         return;
      } else if(temp->key > value)
         temp = temp->left;
         else
            temp = temp->right;
   }
   cout<< value << " node not found" << endl;

   return;
}




void inorder(Node* root)
{
	if (root != NULL) {
		inorder(root->left);
		printf("%d ", root->key);
		inorder(root->right);
	}
}

void preorder(Node *ptr)
{
    if(ptr!=nullptr)
    {
        cout << ptr->key << " ";
        preorder(ptr->left);
        preorder(ptr->right);
    }

}

void postorder(Node *ptr)
{
    if(ptr!=nullptr)
    {
        postorder(ptr->left);
        postorder(ptr->right);
        cout << ptr->key << " ";
    }

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
    int i;
    for (i = 1; i <= h; i++)
        printCurrentLevel(root, i);
}





int main()
{
    int value;
	Node* root = NULL;
	root = insert(root, 50);
	root = insert(root, 30);
	root = insert(root, 20);
	root = insert(root, 40);
	root = insert(root, 70);
	root = insert(root, 60);
	root = insert(root, 80);

	int min_val = minValue(root);
	root = deleteNode(root, min_val);
	cout << min_val << " deleted from BST" << endl;
	cout << "Enter element to search: " ;
	cin >> value;
    Search(root,value);

    printf("Inorder traversal of the given tree \n");
	inorder(root);

    cout << "Max value in BST : " << maxValue(root) << endl;
    get_left_child(root,70);
    get_right_child(root,70);

    cout << "Inorder traversal:" << endl;
    inorder(root);
    cout << endl;

    cout << "Preorder traversal:" << endl;
    preorder(root);
    cout << endl;

    cout << "Postorder Traversal: " << endl;
    postorder(root);
    cout << endl;

    cout <<"Level order traversal: "<< endl;
    printLevelOrder(root);


	return 0;
}
