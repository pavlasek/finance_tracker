import matplotlib.pyplot as plt
import json
import sys
from datetime import datetime

input_data = sys.stdin.read()

converted = json.loads(input_data)

dates = []
sums = []

for data in converted:
    date_raw = data["date"]
    #convert the dates to the datetime format
    date = datetime.strptime(date_raw, "%d-%m-%Y")
    dates.append(date)
    sums.append(data["sum"])

# plot the graph
plt.figure(figsize=(8, 4))
plt.plot(dates, sums, marker='o')

plt.xlabel("Date")
plt.ylabel("Net Worth Summary")
plt.title("NETWORTH OVER TIME")
plt.xticks(rotation=45)
plt.tight_layout()

plt.show()
