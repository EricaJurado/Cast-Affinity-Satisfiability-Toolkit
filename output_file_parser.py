import linecache
import re
import json

important = ["human", "pair_similarity", "pair_affinity", "level"]

line = linecache.getline('sample_output.txt', 5)

facts = line.split()

for i, line in enumerate(facts):
  line = line.replace('(', ',')
  line = line.replace(')', '')
  facts[i] = line.split(",")


with open("partial_history.json", "r") as history_file:
  history = json.loads(history_file.read())
  list = history["history"][0]["data"]
  
  for fact in facts:
    if fact[0] == "level":
      #cast[fact[2]][fact[1]] = fact[3]
      dic = {"class" : "attribute",
	"type" : fact[1],
	"first" : fact[2],
	"value" : int(fact[3])}
      list.append(dic)      


#print(json.dumps(history))

with open("history.json", "w") as file:
  json.dump(history, file, sort_keys=True, indent=4, separators=(',', ': '))


