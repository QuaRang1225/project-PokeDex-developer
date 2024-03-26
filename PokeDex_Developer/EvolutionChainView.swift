import SwiftUI

// 트리의 노드를 나타내는 클래스 정의
class TreeNode: Identifiable {
    let id = UUID()
    var value: Int
    var children: [TreeNode]
    
    init(value: Int, children: [TreeNode] = []) {
        self.value = value
        self.children = children
    }
}

// 트리의 각 노드를 표시하는 SwiftUI 뷰 정의
struct TreeNodeView: View {
    let node: TreeNode
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Text("\(node.value)")
                        .foregroundColor(.white)
                        .font(.headline)
                )
            HStack {
                ForEach(node.children) { child in
                    TreeNodeView(node: child)
                }
            }
        }.padding()
    }
}

// ContentView에 트리 뷰 추가
struct EvolutionChainView: View {
    let treeRoot: TreeNode
    
    var body: some View {
        TreeNodeView(node: treeRoot)
    }
}

// 트리를 생성하여 ContentView를 미리보기
struct EvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        let node4 = TreeNode(value: 4)
        let node5 = TreeNode(value: 5)
        let node6 = TreeNode(value: 6)
        let node7 = TreeNode(value: 7)
        let node2 = TreeNode(value: 2, children: [node4, node5])
        let node3 = TreeNode(value: 3, children: [node6, node7])
        let treeRoot = TreeNode(value: 1, children: [node2, node3])
        return EvolutionChainView(treeRoot: treeRoot)
    }
}
