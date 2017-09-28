import matplotlib.pyplot as plt

# ===> Simple Plotting <===
# ---> y Plot
# plt.plot([1,2,3,4])

# ---> x-y Plot
# plt.plot([1,2,3,4], [1,4,9,16])

# ---> x-y Plot Pretty
plt.plot([1,2,3,4], [2, 5, 10, 17], 'r*')

# ---> Manipulating the Axis
# [xmin, xmax, ymin, ymax]
plt.axis([0, 5, -1, 25])

plt.title('Look! A graph!')
plt.ylabel('some numbers')
plt.xlabel('more numbers')
plt.show()
