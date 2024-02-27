#https://stackoverflow.com/questions/318888/solving-who-owns-the-zebra-programmatically
from constraint import AllDifferentConstraint, InSetConstraint, Problem

# variables
colors        = "blue red green white yellow".split()
nationalities = "Norwegian German Dane Swede English".split()
pets          = "birds dog cats horse zebra".split()
drinks        = "tea coffee milk beer water".split()
cigarettes    = "Blend, Prince, Blue Master, Dunhill, Pall Mall".split(", ")

# There are five houses.
minn, maxn = 1, 5
problem = Problem()
# value of a variable is the number of a house with corresponding property
variables = colors + nationalities + pets + drinks + cigarettes
problem.addVariables(variables, range(minn, maxn+1))

# Each house has its own unique color.
# All house owners are of different nationalities.
# They all have different pets.
# They all drink different drinks.
# They all smoke different cigarettes.
for vars_ in (colors, nationalities, pets, drinks, cigarettes):
    problem.addConstraint(AllDifferentConstraint(), vars_)

# In the middle house they drink milk.
#NOTE: interpret "middle" in a numerical sense (not geometrical)
problem.addConstraint(InSetConstraint([(minn + maxn) // 2]), ["milk"])
# The Norwegian lives in the first house.
#NOTE: interpret "the first" as a house number
problem.addConstraint(InSetConstraint([minn]), ["Norwegian"])
# The green house is on the left side of the white house.
#XXX: what is "the left side"? (linear, circular, two sides, 2D house arrangment)
#NOTE: interpret it as 'green house number' + 1 == 'white house number'
problem.addConstraint(lambda a,b: a+1 == b, ["green", "white"])

def add_constraints(constraint, statements, variables=variables, problem=problem):
    for stmt in (line for line in statements if line.strip()):
        problem.addConstraint(constraint, [v for v in variables if v in stmt])

and_statements = """
They drink coffee in the green house.
The man who smokes Pall Mall has birds.
The English man lives in the red house.
The Dane drinks tea.
In the yellow house they smoke Dunhill.
The man who smokes Blue Master drinks beer.
The German smokes Prince.
The Swede has a dog.
""".split("\n")
add_constraints(lambda a,b: a == b, and_statements)

nextto_statements = """
The man who smokes Blend lives in the house next to the house with cats.
In the house next to the house where they have a horse, they smoke Dunhill.
The Norwegian lives next to the blue house.
They drink water in the house next to the house where they smoke Blend.
""".split("\n")
#XXX: what is "next to"? (linear, circular, two sides, 2D house arrangment)
add_constraints(lambda a,b: abs(a - b) == 1, nextto_statements)

def solve(variables=variables, problem=problem):
    from itertools  import groupby
    from operator   import itemgetter

    # find & print solutions
    for solution in problem.getSolutionIter():
        for key, group in groupby(sorted(solution.iteritems(), key=itemgetter(1)), key=itemgetter(1)):
            print(key)
            for v in sorted(dict(group).keys(), key=variables.index):
                print(v.ljust(9))
            print

if __name__ == '__main__':
    solve()
 	