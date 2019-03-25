import linecache
import re
import json

important = ["human", "pair_similarity", "pair_affinity", "level"]

line = linecache.getline('sample_output.txt', 5)

facts = line.split()

print(facts[1])

for i, line in enumerate(facts):
  line = line.replace('(', ',')
  line = line.replace(')', '')
  facts[i] = line.split(",")

#for fact in facts:
#  if fact[0] in important:
#    print(fact)

cast = {}

for fact in facts:
  if fact[0] == "human":
    cast[fact[1]] = {}


for fact in facts:
  if fact[0] == "level":
    cast[fact[2]][fact[1]] = fact[3]


with open("cast.json", "w") as file:
  print(json.dump(cast, file, sort_keys=True, indent=4, separators=(',', ': ')))


