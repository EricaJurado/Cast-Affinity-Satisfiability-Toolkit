from shutil import copyfile
#num_chars = str(12) ##TODO: automate this? and instance file?
num_chars = str(5) ##TODO: automate this? and instance file?

facet_names = []
interest_names = []

folder_name = input("enter folder name: ")

#get requested facets
#with open("persistent/amelia_facets.txt", 'r') as file:
with open(folder_name + "/facets.txt", 'r') as file:
    filedata = file.read()
    facet_names = filedata.rstrip('\n').split('\n')
    
with open(folder_name + "/interests.txt", 'r') as file:
    filedata = file.read()
    interest_names = filedata.rstrip('\n').split('\n')

facet_and_interests = facet_names + interest_names

#new_facet = input("enter the name of your first desired facet:")
#while new_facet:
#    facet_names.append(new_facet)
#    new_facet = input("enter the name of your next desired facet, or press enter to generate files:")

# Read in the template file
with open('persistent/facet_template.lp', 'r') as file :
    filedata = file.read()

for facet_name in facet_and_interests:
    if facet_name == "":
        continue

    # Replace the target string
    tempfiledata = filedata.replace('template', facet_name)

    # Write the file out again
    with open("generated/" + facet_name + '.lp', 'w') as file:
        file.write(tempfiledata)


with open("generated/similarity_generated.lp", 'w') as file:
    max_facets = str(len(facet_names))
    max_interests = str(len(interest_names))
    max = str(len(facet_and_interests))
    #file.write("#const max = " + max + ".\n")
    file.write("#const chars = " + num_chars + ".\n")
    file.write("similarity(-" + max + ".." + max + ").\n")
    file.write("facet_similarity(-" + max_facets + ".." + max_facets + ").\n")
    file.write("interest_similarity(-" + max_interests + ".." + max_interests + ").\n\n")


    file.write(":-pair_facet_similarity(A, B, F), character(A), character(B), facet_similarity(F),\n")
    i = 1
    for facet_name in facet_names:
        file.write("\tsim(" + facet_name + ",A,B,E" + str(i) + "),\n")
        i+=1
    final_string = "\t"

    for j in range(1,i-1):
        final_string = final_string + "E" + str(j) + "+"
    final_string = final_string + "E" + str(i-1) + "!=F.\n\n"
    file.write(final_string)


    file.write(":-pair_interest_similarity(A, B, I), character(A), character(B), interest_similarity(I),\n")
    i = 1
    for interest_name in interest_names:
        file.write("\tsim(" + interest_name + ",A,B,E" + str(i) + "),\n")
        i+=1
    final_string = "\t"

    for j in range(1,i-1):
        final_string = final_string + "E" + str(j) + "+"
    final_string = final_string + "E" + str(i-1) + "!=I.\n\n"
    file.write(final_string)

    file.write(":-pair_similarity(A, B, T), character(A), character(B), similarity(T),")
    file.write("\tfacet_similarity(F),\n")
    file.write("\tinterest_similarity(I),\n")
    file.write("\tpair_facet_similarity(A, B, F),\n")
    file.write("\tpair_interest_similarity(A, B, I),\n")
    file.write("\tI+F!=T.\n");


copyfile("persistent/similarity_persistant.lp", "generated/similarity_persistant.lp")
copyfile("persistent/affinity.lp", "generated/affinity.lp")
copyfile(folder_name + "/instance.lp", "generated/instance.lp")
copyfile(folder_name + "/affinity_rules.lp", "generated/affinity_rules.lp")


