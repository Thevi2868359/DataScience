class Node:
    def __init__(self, data: int):
        self.data = data
        self.leftchild = None
        self.rightchild = None


class BinarySearchTree:
    def __init__(self):
        self.root = None

    def insert(self, data):
        newnode = Node(data)
        if self.root is None:
            self.root = newnode
            return
        current = self.root
        while True:
            if data < current.data:
                if current.leftchild is None:
                    current.leftchild = newnode
                    break
                current = current.leftchild
            else:
                if current.rightchild is None:
                    current.rightchild = newnode
                    break
                current = current.rightchild

    def inorder_traversal(self):
        current = self.root
        stack = []
        while True:
            while current is not None:
                print(current.data)
                stack.append(current)
                current = current.leftchild

            if not stack:
                break

            current = stack.pop()
            current = current.rightchild


def main():
    bst = BinarySearchTree()
    bst.insert(8)
    bst.insert(3)
    bst.insert(4)
    bst.insert(10)
    bst.inorder_traversal()


if __name__ == "__main__":
    main()
