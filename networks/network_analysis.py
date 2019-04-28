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
plt.show()

for node in nx.nodes(G):
  in_edges = G.in_edges(node)
  out_edges = G.out_edges(node)
  in_weight = 0
  out_weight = 0
  pos_in_relations = []
  neg_in_relations = []
  pos_out_relations = []
  neg_out_relations = []

  for edge in in_edges:
    data = G.get_edge_data(edge[0], edge[1])
    curr_weight = data["weight"]
    in_weight += curr_weight
    if(curr_weight >= 0):
      pos_in_relations = pos_in_relations + [edge[0]]
    else:
      neg_in_relations = neg_in_relations + [edge[0]]
	
  for edge in out_edges:
    data = G.get_edge_data(edge[0], edge[1])
    curr_weight = data["weight"]
    out_weight += curr_weight 
    if(curr_weight >= 0):
      pos_out_relations = pos_out_relations + [edge[1]]
    else:
      neg_out_relations = neg_out_relations + [edge[1]]

  #pos_relations = list(set(pos_in_relations) & set(pos_out_relations))
  pos_relations = [value for value in pos_out_relations if value in pos_in_relations]
  #neg_relations = list(set(neg_in_relations) & set(neg_out_relations))
  neg_relations = [value for value in neg_out_relations if value in neg_in_relations]
  mixed_relations = [value for value in pos_in_relations if value not in pos_out_relations]
  mixed_relations = mixed_relations + [value for value in neg_in_relations if value not in neg_out_relations]

  print(node)
  print("incoming total: " + str(in_weight))
  print("outgoing total: " + str(out_weight))
  #print("positive in relationships: " + str(pos_in_relations))
  #print("positive out relationships: " + str(pos_out_relations))
  print("positive relationships: " + str(pos_relations))
  print("negative relationships: " + str(neg_relations))
  print("mixed relationships: " + str(mixed_relations))
  #print(neg_in_relations)
  #print(neg_out_relations)



