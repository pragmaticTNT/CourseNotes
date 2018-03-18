import csv

def readfile(fileName):
    # NOTE: Old way of reading lines
    #data = []
    #with open(fileName, 'r') as f:
    #    for line in f:
    #        if len(line) > 1:
    #            fLine = line.lstrip()
    #            fLine = fLine.rstrip('\n')
    #            data.append(fLine)

    # NOTE: More pythonic way
    dataFile = open(fileName, 'r')
    data = dataFile.readlines()
    dataFile.close()

    data = [line.lstrip().rstrip('\n')  for line in data if len(line) > 1]
    #print("Data:", data)
    #print("===> # Lines in File:", len(data))
    return data


def parse(data, headings):
    cleanData = []
    tags = {heading:'' for heading in headings}
    headingCount = -1

    for entry in data:
        if entry.startswith(headings):
            if entry.startswith(headings[0]):
                row = [tags[heading] for heading in headings]
                #print("===> row:", row)
                cleanData.append(row)
                headingCount = -1
                tags = {heading:'' for heading in headings}
            firstColon = entry.index(':')
            headingCount += 1
            tags[entry[0:firstColon]] = entry[firstColon + 2:]
        else:
            currentHeading = headings[headingCount]
            tags[currentHeading] += entry

    row = [tags[heading] for heading in headings]
    #print("===> row:", row)
    cleanData.append(row)
    return cleanData[1:]


def writeFile(data, headings, fileName):
    outputFile = csv.writer(open(fileName, 'w'))
    outputFile.writerow(headings)
    for entry in data:
        outputFile.writerow(entry)
    return

#======================
#===> Python Setup <===
#======================
def main():
    readFilePath = "npc.txt"
    writeFilePath = "data.csv"
    # NOTE: It is important that the heading be a tuple since it is used as the input for a call to the 'startswith' method of the string function. Further, the last heading should be something that appears in your data (otherwise the code won't know when to stop collecting data for one row.
    headings = ('Number', 'Name', 'Input', 'Reference', 'Tags', 'Comments')

    print("===> Reading File ...")
    data = readfile(readFilePath)
    print("===> File Read!")
    print("===> Parsing Data ...")
    data = parse(data, headings)
    print("===> Data Parsed!")
    print("===> Writing Data to", writeFilePath, "...")
    writeFile(data, headings, writeFilePath)
    print("===> Data Written! Please check:", writeFilePath)

if __name__ == "__main__":
    main()
