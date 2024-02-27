# todd8 on May 13, 2014 | https://news.ycombinator.com/item?id=7734998

from itertools import permutations as perms

for brit, swede, dane, norwegian, german in perms(range(5)):
    if norwegian != 0: continue
    for red, green, white, yellow, blue in perms(range(5)):
        if brit != red: continue
        if green != white - 1: continue
        if norwegian not in [blue-1, blue+1]: continue
        for tea, coffee, milk, beer, water in perms(range(5)):
            if milk != 2: continue
            if dane != tea: continue
            if green != coffee: continue
            for pallmall, dunhill, marlboro, winfield, rothmans in perms(range(5)):
                if dunhill != yellow: continue
                if winfield != beer: continue
                if rothmans != german: continue
                if marlboro not in [water-1, water+1]: continue
                for dogs, birds, cats, horses, fish in perms(range(5)):
                    if swede != dogs: continue
                    if pallmall != birds: continue
                    if marlboro not in [cats-1, cats+1]: continue
                    if dunhill not in [horses-1, horses+1]: continue

nation =  {brit: "Brit", swede: "Swede", dane: "Dane", norwegian: "Norwegian", german: "German"}
print("The {} owns the fish".format(nation[fish]))