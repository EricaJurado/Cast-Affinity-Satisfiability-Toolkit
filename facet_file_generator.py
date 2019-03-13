
facet_names = []

#get requested facets
new_facet = input("enter the name of your first desired facet:")
while new_facet:
    facet_names.append(new_facet)
    new_facet = input("enter the name of your next desired facet, or press enter to generate files:")

# Read in the template file
with open('templates/facet_template', 'r') as file :
  filedata = file.read()

for facet_name in facet_names:
    # Replace the target string
    tempfiledata = filedata.replace('facet', facet_name)

    # Write the file out again
    with open("generated/" + facet_name + '.lp', 'w') as file:
        file.write(tempfiledata)


with open("generated/similarity_generated.pl", 'w') as file:
    header = "#const high=1.\n#const neutral=0.\n#const low=-1.\n\nsimilarity(-" + str(len(facet_names)) + ".." + str(len(facet_names)) + ").\n\n"
    file.write(header)
    file.write("1{pair_similarity(A,B,X) : similarity(X)}1:- human(A), human(B), A!=B.\n\n")
    file.write(":-pair_similarity(A, B, T), human(A), human(B), similarity(T),\n")

    i = 1
    for facet_name in facet_names:
        file.write("\t" + facet_name + "_sim(A,B,E" + str(i) + "),\n")
        i+=1
    final_string = "\t"

    for j in range(1,i-1):
        final_string = final_string + "E" + str(j) + "+"
    final_string = final_string + "E" + str(i-1) + "!=T."
    file.write(final_string)

with open("generated/similarity_instance.pl", 'w') as file:
    #file.write("#show pair_similarity/3.\n")
    file.write("%problem instance\n")
    file.write("human(1..3).\n\n")
    file.write("%add more rules here\n")
    file.write("%example:\npair_similarity(1,2,2).\n")

