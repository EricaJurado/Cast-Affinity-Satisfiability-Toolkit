from shutil import copyfile

facet_names = []
interest_names = []

folder_name = input("enter folder name: ")

##find number of characters
with open(folder_name + "/instance.lp", 'r') as file:
    num_chars = 0
    filedata = file.read()
    filedata = filedata.split("\n")
    for line in filedata:
        if line[0:9] == "character":
            temp = line.strip(".")
            temp = temp.replace(")", "")
            temp = temp.split('(')
            #print(temp)
            if(temp[1].find("..") > 0):
                nums = temp[1].replace("..", ",").split(",")
                num_chars += int(nums[1]) - int(nums[0]) + 1
            else:
                num_chars += 1

#get requested facets
#with open("persistent/amelia_facets.txt", 'r') as file:
with open(folder_name + "/facets.txt", 'r') as file:
    filedata = file.read()
    facet_names = filedata.rstrip('\n').split('\n')
    
with open(folder_name + "/interests.txt", 'r') as file:
    filedata = file.read()
    interest_names = filedata.rstrip('\n').split('\n')

facet_and_interests = facet_names + interest_names

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
    file.write("#const chars = " + str(num_chars) + ".\n")
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


