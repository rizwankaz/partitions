import matplotlib.pyplot as plt

n_values = []
runtime_values = []

with open("naive_runtime_data.txt", "r") as file:
    next(file)
    for line in file:
        parts = line.strip().split('\t')
        n = int(parts[0])
        runtime = float(parts[2])
        n_values.append(n)
        runtime_values.append(runtime)

plt.figure(figsize=(10, 6))
plt.plot(n_values, runtime_values, marker='o', linestyle='-', color='b', linewidth=0.25, markersize=1)
plt.xlabel('n')
plt.ylabel('runtime(n)')
plt.title('Runtime of partition_naive(n)')
plt.grid(True)
plt.savefig("runtime_plot.png")
plt.show()