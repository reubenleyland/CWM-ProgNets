# !/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt

# parameters to modify
filename="pingdataform.txt"
label='pingtest'
xlabel = 'xlabel'
ylabel = 'ylabel'
title='Ping:i0.01'
fig_name='test1.png'


t = np.loadtxt(filename, delimiter=" ", dtype="float")



plt.plot(t[:,0], t[:,1], label=label)  # Plot some data on the (implicit) axes.
plt.xlabel(xlabel)
plt.ylabel(ylabel)
plt.title(title)
plt.legend()
plt.savefig(fig_name)
plt.show()
