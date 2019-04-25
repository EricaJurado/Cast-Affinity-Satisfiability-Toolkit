import linecache
import re
import json
import networkx as nx
import matplotlib.pyplot as plt

important = ["human", "pair_similarity", "pair_affinity", "level"]

line = linecache.getline('sample_output.txt', 5)

facts = line.split()

for i, line in enumerate(facts):
  line = line.replace('(', ',')
  line = line.replace(')', '')
  facts[i] = line.split(",")


G = nx.DiGraph()


for fact in facts:
  if fact[0] == "human":
     G.add_node(fact[1])
     print(fact)
  if fact[0] == "pair_affinity":
     print(fact)
     myWeight = int(fact[3])
     G.add_edge(fact[1],fact[2],weight=myWeight)	

print("drawing?")
#pos=nx.get_node_attributes(G,'pos')
pos=nx.spring_layout(G)
labels=nx.get_edge_attributes(G,'weight')
nx.draw(G, with_labels=True, font_weight='bold', edge_labels=labels)
nx.draw_networkx_edge_labels(G, pos, edge_labels=labels)
#plt.show()

in_edges = G.in_edges("amelia")
out_edges = G.out_edges("amelia")
in_weight = 0
out_weight = 0

for edge in in_edges:
  data = G.get_edge_data(edge[0], edge[1])
  in_weight += data["weight"]

for edge in out_edges:
  data = G.get_edge_data(edge[0], edge[1])
  out_weight += data["weight"]

print("incoming: " + str(in_weight))
print("outgoing: " + str(out_weight))




