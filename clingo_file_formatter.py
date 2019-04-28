from shutil import copyfile
#num_chars = str(12) ##TODO: automate this? and instance file?
num_chars = str(5) ##TODO: automate this? and instance file?

facet_names = []

folder_name = input("enter folder name: ")

#get requested facets
#with open("persistent/amelia_facets.txt", 'r') as file:
with open(folder_name + "/facets.txt", 'r') as file:
    filedata = file.read()
    facet_names = filedata.rstrip('\n').split('\n')
    
with open(folder_name + "/interests.txt", 'r') as file:
    filedata = file.read()
    facet_names = facet_names + filedata.rstrip('\n').split('\n')

#new_facet = input("enter the name of your first desired facet:")
#while new_facet:
#    facet_names.append(new_facet)
#    new_facet = input("enter the name of your next desired facet, or press enter to generate files:")

# Read in the template file
with open('persistent/facet_template.lp', 'r') as file :
    filedata = file.read()

for facet_name in facet_names:
    if facet_name == "":
        continue

    # Replace the target string
    tempfiledata = filedata.replace('template', facet_name)

    # Write the file out again
    with open("generated/" + facet_name + '.lp', 'w') as file:
        file.write(tempfiledata)


with open("generated/similarity_generated.lp", 'w') as file:
    max = str(len(facet_names))
    file.write("#const max = " + max + ".\n")
    file.write("#const chars = " + num_chars + ".\n")
    file.write("similarity(-" + max + ".." + max + ").\n\n")
    #file.write(":-pair_similarity(A, B, T), human(A), human(B), similarity(T),\n")
    file.write(":-pair_similarity(A, B, T), human(A), human(B), similarity(T),\n")
    #file.write("X = #sum{L : sim(F,A,B,L), facet(F)},\n	X!=T.")	

    i = 1
    for facet_name in facet_names:
        file.write("\tsim(" + facet_name + ",A,B,E" + str(i) + "),\n")
        i+=1
    final_string = "\t"

    for j in range(1,i-1):
        final_string = final_string + "E" + str(j) + "+"
    final_string = final_string + "E" + str(i-1) + "!=T."
    file.write(final_string)

#with open("generated/similarity_instance.lp", 'w') as file:
#    #file.write("#show pair_similarity/3.\n")
#    file.write("%problem instance\n")
#    file.write("human(1.." + num_chars + ").\n\n")
#    file.write("%add more rules here\n")
#    file.write("%example:\npair_similarity(1,2,2).\n")

copyfile("persistent/similarity_persistant.lp", "generated/similarity_persistant.lp")
copyfile("persistent/affinity.lp", "generated/affinity.lp")
copyfile(folder_name + "/instance.lp", "generated/instance.lp")
copyfile(folder_name + "/affinity_rules.lp", "generated/affinity_rules.lp")


