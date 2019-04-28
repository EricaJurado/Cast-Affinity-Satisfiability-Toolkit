import linecache
import re
import json
import networkx as nx
import matplotlib.pyplot as plt

important = ["character", "pair_similarity", "pair_affinity", "level"]

file_name = input("enter the name of the file to analyze: ")
line = linecache.getline(file_name, 5)

facts = line.split()

for i, line in enumerate(facts):
  line = line.replace('(', ',')
  line = line.replace(')', '')
  facts[i] = line.split(",")

DiG = nx.DiGraph()
G = nx.Graph()

for fact in facts:
  if fact[0] == "charcater":
     DiG.add_node(fact[1])
     print(fact)
  if fact[0] == "pair_affinity":
     print(fact)
     myWeight = int(fact[3])
     DiG.add_edge(fact[1],fact[2],weight=myWeight)	

print("drawing?")
pos=nx.spring_layout(DiG)
labels=nx.get_edge_attributes(DiG,'weight')
#nx.draw(DiG, with_labels=True, font_weight='bold', edge_labels=labels)
#nx.draw_networkx_edge_labels(DiG, pos, edge_labels=labels)
#plt.show()

loners = []

for node in nx.nodes(DiG):
  in_edges = DiG.in_edges(node)
  out_edges = DiG.out_edges(node)
  in_weight = 0
  out_weight = 0
  pos_in_relations = []
  neg_in_relations = []
  pos_out_relations = []
  neg_out_relations = []

  for edge in in_edges:
    data = DiG.get_edge_data(edge[0], edge[1])
    curr_weight = data["weight"]
    in_weight += curr_weight
    if(curr_weight >= 0):
      pos_in_relations = pos_in_relations + [edge[0]]
    else:
      neg_in_relations = neg_in_relations + [edge[0]]
	
  for edge in out_edges:
    data = DiG.get_edge_data(edge[0], edge[1])
    curr_weight = data["weight"]
    out_weight += curr_weight 
    if(curr_weight >= 0):
      pos_out_relations = pos_out_relations + [edge[1]]
    else:
      neg_out_relations = neg_out_relations + [edge[1]]

  pos_relations = [value for value in pos_out_relations if value in pos_in_relations]
  neg_relations = [value for value in neg_out_relations if value in neg_in_relations]
  mixed_relations = [value for value in pos_in_relations if value not in pos_out_relations]
  mixed_relations = mixed_relations + [value for value in neg_in_relations if value not in neg_out_relations]

  print(node)
  print("incoming total: " + str(in_weight))
  print("outgoing total: " + str(out_weight))
  print("positive relationships: " + str(pos_relations))
  print("negative relationships: " + str(neg_relations))
  print("mixed relationships: " + str(mixed_relations))

  if(len(pos_relations) == 0):
    loners = loners + [node]

  for relation in pos_relations:
    print(relation)
    if(not G.has_edge(node, relation)):
      G.add_edge(node, relation)




#nx.draw(G, with_labels=True, font_weight='bold', edge_labels=labels)
#plt.show()

print("num of cliques of size > 1: " , nx.graph_number_of_cliques(G))
cliques = list(nx.find_cliques(G))
print("cliques: " , cliques)

print("num loners: ", len(loners))
print("loners: ", loners)

print("eccentricity: ", nx.eccentricity(G))

G.add_nodes_from(loners)

nx.draw(G, with_labels=True, font_weight='bold', edge_labels=labels)
plt.show()



