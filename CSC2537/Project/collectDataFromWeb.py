# ===> Import Libraries
import requests
from bs4 import BeautifulSoup

skip = 12
count = 0

address = "http://cgi.csc.liv.ac.uk/~ped/teachadmin/COMP202/annotated_np.html"

page = requests.get(address)
soup = BeautifulSoup(page.text, 'html.parser')

allAnchor = soup.find_all('a')
block1 = allAnchor[12]
for entry in block1:
    if count < skip:
        print("===> BLOCK <===")
        print(entry.contents[0])
    count += 1


#for anchor in allAnchor:
#    if count < skip:
#        print("===> ANCHOR <===")
#        print(anchor.prettify())
#    count += 1

#print(allAnchor[12])
#print("#Body: {}".format(len(main)))
print("#Anchor: {}".format(len(allAnchor)))
print("#Block1: {}".format(len(block1)))
