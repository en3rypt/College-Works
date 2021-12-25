from tkinter import *


#?TERNARY NODE
class Node():
    def __init__(self, value=None, endOfWord=False):

        self.value = value
        self.left = None
        self.right = None
        self.equal = None
        self.endOfWord = endOfWord


#?AUTO COMPLETE CLASS
class acTST():
    def __init__(self, word_list):

        self.n = Node()
        for word in word_list:
            self.insert(word, self.n)

    #?POPULATING THE TREE
    def insert(self, word, node):

        char = word[0]
        if not node.value:
            node.value = char

        if char < node.value:
            if not node.left:
                node.left = Node()
            self.insert(word, node.left)
        elif char > node.value:
            if not node.right:
                node.right = Node()
            self.insert(word, node.right)
        else:
            if len(word) == 1:
                node.endOfWord = True
                return

            if not node.equal:
                node.equal = Node()
            self.insert(word[1:], node.equal)

    #?TREE TRAVERSAL FUNCTION
    def all_suffixes(self, word, node):

        if node:
            if node.endOfWord:
                yield f"{word}{node.value}"

            if node.left:
                for wrd in self.all_suffixes(word, node.left):
                    yield wrd
            if node.right:
                for wrd in self.all_suffixes(word, node.right):
                    yield wrd
            if node.equal:
                for wrd in self.all_suffixes(word + node.value, node.equal):
                    yield wrd

    #?FIND FUNCTION
    def find(self, w):

        word = self.find_(w)
        if word == None:
            return None
        return list(set(word))

    #?NODE TRAVERSAL FUNCTION
    def find_(self, word):

        node = self.n
        for char in word:
            while True:
                if char > node.value:
                    node = node.right
                elif char < node.value:
                    node = node.left
                else:
                    node = node.equal
                    break
                if not node:
                    return None

        return self.all_suffixes(word, node)


#? TKINTER KEYBIND FUNCTIONS


def process_list():
    k = []
    w = word.get()
    k = tree.find(w)
    if k:
        k.sort()
        k.sort(key=len)
        near = k[index]
    return k


def up(event):

    global index

    if k:

        text_field.delete(text_field.index(INSERT), END)
        w = word.get()

        if index > 0:
            index -= 1
        else:
            index = len(k) - 1

        text_field.delete(0, END)
        text_field.insert(0, k[index])
        text_field.icursor(len(w))
        text_field.select_range(len(w), len(word.get()))


def down(event):
    global index

    if k:

        text_field.delete(text_field.index(INSERT), END)
        w = word.get()

        if index < len(k) - 1:
            index += 1
        else:
            index = 0

        text_field.delete(0, END)
        text_field.insert(0, k[index])
        text_field.icursor(len(w))
        text_field.select_range(len(w), len(word.get()))


def right(event):
    global k, index

    try:
        start, end = text_field.index("sel.first"), text_field.index(
            "sel.last")
    except:
        start, end = 0, 0

    if end != start:
        index = 0
        text_field.icursor(text_field.index("sel.last"))
        k = process_list()


#? ENTRY BOX UPDATE FUNCTION
def find(event):
    global k, index

    cevent = event.keysym
    if event == 'Return':
        k = process_list()
        return
    if cevent == 'BackSpace':
        k = process_list()
        return

    elif cevent == 'Up':
        return

    elif cevent == 'Down':
        return

    elif cevent == 'Right':
        return

    elif cevent == 'Left':
        return

    index = 0
    w = word.get()
    k = process_list()
    if k:
        near = k[index]
        text_field.delete(0, END)
        text_field.insert(0, near)
        text_field.icursor(len(w))
        text_field.select_range(len(w), len(word.get()))


def file_operation(word):
    f = open('words.txt', 'a')
    f.write('\n' + word)
    f.close()


#? list updation
def insert_fn(event):
    global tree
    w = word.get()
    tree.insert(w, tree.n)
    file_operation(w)


#? DATA PROCESSING
f = open('words.txt')
word_list = f.read().splitlines()
tree = acTST(word_list)
f.close()

#? TKINTER MAIN LOOP
global k
k = []
root = Tk()
root.title("AUTO COMPLETE")
root.geometry('500x200')

word = StringVar()
title = Label(root, text="AUTO COMPLETE USING TST", font=('tacoma', 15))
title.pack()

text_field = Entry(root, font=('tacoma', 30), textvariable=word)
text_field.pack()

text_field.bind("<KeyRelease>", find)
text_field.bind('<Up>', up)
text_field.bind('<Down>', down)
text_field.bind("<Right>", right)
text_field.bind("<Return>", insert_fn)
root.mainloop()