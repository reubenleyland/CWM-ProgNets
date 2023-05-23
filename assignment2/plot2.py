# !/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt

# parameters to modify
filename="iperf2.log"
label='iperf'
xlabel = 'time (/0.1s)'
ylabel = 'bandwidth'
title='iperf'
fig_name='test5.png'
bins=5000 #adjust the number of bins to your plot


t = np.loadtxt(filename,)

plt.plot(t, label=label)  # Plot some data on the (implicit) axes.

plt.xlabel(xlabel)
plt.ylabel(ylabel)
plt.title(title)
plt.legend()
plt.savefig(fig_name)
plt.show()
