import linecache
import re
import json
import networkx as nx
import matplotlib.pyplot as plt
import numpy as np

def get_clingo_data():
  file_name = input("enter the name of the file to analyze: ")
  solution_number = input("enter the solution number you wish to view: ")
  line_num = 3 + int(solution_number)*2

  line = linecache.getline(file_name, line_num)

  facts = line.split()

  for i, line in enumerate(facts):
    line = line.replace('(', ',')
    line = line.replace(')', '')
    facts[i] = line.split(",")

  return facts

def make_directed_graph():
  print("Making Directed Graph")
  DiG = nx.DiGraph()

  for fact in facts:
    if fact[0] == "charcater":
       DiG.add_node(fact[1])
       #print(fact)
    if fact[0] == "pair_affinity":
       #print(fact)
       myWeight = int(fact[3])
       DiG.add_edge(fact[1],fact[2],weight=myWeight)	

  return DiG

def draw_directed_graph(DiG):
  print("Drawing Directed Graph")
  pos = nx.circular_layout(DiG)
  labels=nx.get_edge_attributes(DiG,'weight')
  nx.draw(DiG, pos, with_labels=True, font_weight='bold', edge_labels=labels)
  nx.draw_networkx_edge_labels(DiG, pos, edge_labels=labels)
  plt.show()
  return

def get_character_dict(DiG):
  cast_dict = {}

  for node in nx.nodes(DiG):
    char_dict = {}

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

    char_dict["name"] = node
    char_dict["incoming_affinity"] = in_weight
    char_dict["outgoing_affinity"] = out_weight
    char_dict["positive_relations"] = pos_relations
    char_dict["negative_relations"] = neg_relations
    char_dict["mixed_relations"] = mixed_relations

    cast_dict[node] = char_dict

  return cast_dict

  

def make_undirected_relation_graph(characters_dict, relation_type):
  G, loners = make_undirected_relation_graph_loners_separate(characters_dict, relation_type)
  G.add_nodes_from(loners) 
 
  return G

def make_undirected_relation_graph_loners_separate(characters_dict, relation_type):
  loners = []
  G = nx.Graph()

  for char_dict in characters_dict.values():
    relations = char_dict[relation_type]
    name = char_dict["name"]

    if(relations == []):
      loners = loners + [name]
    for relation in relations:
      if(not G.has_edge(name, relation)):
        G.add_edge(name, relation)

  return G, loners

def graph_affinity_bar_plot(char_names, in_vals, out_vals):
  barWidth = 0.3
  r1 = np.arange(len(char_names))
  r2 = [x + barWidth for x in r1]
  
  plt.bar(r1, in_vals, width=barWidth, color='blue', label="incoming affinity")
  plt.bar(r2, out_vals, width=barWidth, color='cyan', label="outgoing affinity")
  
  plt.xticks([r + barWidth for r in range(len(char_names))], char_names)
  plt.ylabel("affinity")
  plt.legend()
  
  plt.show()

def plot_relations(G):
  pos = nx.circular_layout(G)
  nx.draw(G, pos, with_labels=True, font_weight='bold') #, edge_labels=labels)
  plt.show()

def analyze_cliques(G):
  print("num of cliques: " , nx.graph_number_of_cliques(G))
  cliques = list(nx.find_cliques(G))
  print("cliques: " , cliques)

def analyze_cliques_of_nodes(G, nodes):
  print("cliques of nodes: ", nx.cliques_containing_node(G, nodes))

def analyze_eccentricity(dict, type):
  G, loners = make_undirected_relation_graph_loners_separate(dict, type) 
  print("eccentricity: ", nx.eccentricity(G))

def analyze_clustering(G):
  print("clustering:", nx.clustering(G))

def find_largest_clique(G):
  print("size of largest clique", nx.graph_clique_number(G))

facts = get_clingo_data()
DiG = make_directed_graph()
draw_directed_graph(DiG)

characters_dict = get_character_dict(DiG)
character_names = characters_dict.keys()

in_liked = [characters_dict[name]["incoming_affinity"] for name in character_names]
out_liked = [characters_dict[name]["outgoing_affinity"] for name in character_names]

graph_affinity_bar_plot(character_names, in_liked, out_liked)

pos_G = make_undirected_relation_graph(characters_dict, "positive_relations")
neg_G = make_undirected_relation_graph(characters_dict, "negative_relations")
mix_G = make_undirected_relation_graph(characters_dict, "mixed_relations")

plot_relations(pos_G)
plot_relations(neg_G)
plot_relations(mix_G)

analyze_eccentricity(characters_dict, "positive_relations")

no_loner_G, loners = make_undirected_relation_graph_loners_separate(characters_dict, "positive_relations")
analyze_cliques(no_loner_G)

analyze_cliques_of_nodes(pos_G, ["mario", "wario"])


