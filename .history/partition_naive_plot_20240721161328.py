import matplotlib.pyplot as plt

n_values = []
partition_values = []

with open("runtime_data.txt", "r") as file:
    next(file)
    for line in file:
        parts = line.strip().split('\t')
        n = int(parts[0])
        partition = int(parts[1])
        n_values.append(n)
        partition_values.append(partition)

plt.figure(figsize=(10, 6))
plt.plot(n_values, partition_values, marker='o', linestyle='-', color='b', linewidth=0.1, markersize=1)
plt.xlabel('n')
plt.ylabel('partition(n)')
#plt.yscale('log')
plt.grid(True)
plt.savefig("partition_plot.png")
plt.show()