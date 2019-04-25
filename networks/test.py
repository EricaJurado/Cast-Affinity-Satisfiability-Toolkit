import networkx as nx
import matplotlib.pyplot as plt

G = nx.Graph()

print("adding nodes")
G.add_node("kirsten")
G.add_node("erica")
G.add_node("arunpreet")
G.add_node("josh")
G.add_node("ariel")
G.add_node("zee")

print("adding edges")
G.add_edge("kirsten", "erica")
G.add_edge("kirsten", "arunpreet")
G.add_edge("kirsten", "zee")
G.add_edge("erica", "arunpreet")
G.add_edge("erica", "josh")
G.add_edge("erica", "zee")
G.add_edge("arunpreet", "josh")
G.add_edge("zee", "josh")
G.add_edge("ariel", "josh")

print("clustering:")
print(nx.clustering(G))


print("drawing?")
nx.draw(G, with_labels=True, font_weight='bold')
plt.show()



