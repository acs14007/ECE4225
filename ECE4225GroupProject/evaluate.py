# 12/2/2020: Written By Aaron Spaulding

import os

import numpy as np
import matplotlib.pyplot as plt

def plot_band_diagram(data, header, Vg):
    #for i in range(data.shape[1]):
    for i in [1,3,5,7]:
        label = str(header[i])
        label = label[:label.find('(')]
        plt.plot(data[:, i-1], data[:, i], label=label)
    plt.title(f'Band diagram for the {Vg}V case') 
    plt.xlabel('Distance (nm)')
    plt.ylabel('Energy (eV)')
    plt.legend(frameon=False, loc='lower center', ncol=2)
    plt.show()
    
def plot_this(data, header):
    labels = [0,0,1,1,3,3]
    for i in [0,2,4]:
        label = labels[i]
        plt.plot(data[:, i], data[:, i+1], label = f'Vg = {label}V')
    plt.title('Drain Current vs. Voltage for default design')
    xlim1 = plt.axhline(6e-4,linestyle ='dashed',color='red',label='Target')
    xlim2 = plt.axhline(1e-12,linestyle ='dashed',color='red',label='Target')
    plt.axhspan(6e-4, 1e-12, facecolor='red', alpha=0.5)
    plt.xlabel('Drain Source Voltage (V)')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower center', ncol=2)
    plt.yscale('log')
    plt.show()


def plot_this2(data, header):
    #labels = [0,0,1,1,3,3]
    labels = ['Default device', 'Default device', 'Proposed Device', 'Proposed Device']
    for i in [0,2]:
        label = labels[i]
        plt.plot(data[:, i], data[:, i+1], label = label)
    slope1 = 1.633015555555554e-16
    slope2 = 0
    plt.title('Drain current vs. gate voltage')
    plt.xlabel('Gate Source Voltage')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower right', ncol=1)
    plt.yscale('log')
    plt.show()

def plot_this2der(data, header):
    
    #labels = [0,0,1,1,3,3]
    labels = ['Default device', 'Default device', 'Proposed Device', 'Proposed Device']
    for i in [0,2]:
        label = labels[i]
        deriv = np.diff(data[:, i+1]) / np.diff(data[:, i])
        plt.plot(data[:-1, i], deriv, label = label)
    slope1 = 1.633015555555554e-16
    slope2 = 0
    plt.title('Derivative of drain current vs. gate voltage')
    plt.xlabel('Gate Source Voltage')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower right', ncol=1)
    plt.yscale('log')
    plt.show()


def plot_this3(data, header):
    labels = [0,0,1,1,3,3]
    for i in [0,2,4]:
        label = labels[i]
        plt.plot(data[:, i], data[:, i+1], label = f'Vg = {label}V')
    plt.title('Drain Current vs. Voltage for proposed design')
    xlim1 = plt.axhline(6e-4,linestyle ='dashed',color='red',label='Target')
    xlim2 = plt.axhline(1e-12,linestyle ='dashed',color='red',label='Target')
    plt.axhspan(6e-4, 1e-12, facecolor='red', alpha=0.5)
    plt.xlabel('Drain Source Voltage (V)')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower center', ncol=2)
    plt.yscale('log')
    plt.show()

def plot_this5(data, header):
    labels = [0,0,1,1,3,3]
    for i in [0]:
        label = labels[i]
        plt.plot(data[:, i], data[:, i+1], label = f'Vg = {label}V')
    xlim = plt.axhline(1e-12,linestyle ='dashed',color='red',label='Target')
    plt.title('Drain Current vs. Voltage for the "OFF"(Vg=0V) Case')
    plt.xlabel('Drain Source Voltage (V)')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower center', ncol=2)
    plt.yscale('log')
    
    plt.show()

def plot_this6(data, header):
    labels = [0,0,1,1,3,3]
    for i in [4]:
        label = labels[i]
        plt.plot(data[:, i], data[:, i+1], label = f'Vg = {label}V')
    xlim = plt.axhline(6e-4,linestyle ='dashed',color='red',label='Target')
    plt.title('Drain Current vs. Voltage for the "ON"(Vg=3V) Case')
    plt.xlabel('Drain Source Voltage (V)')
    plt.ylabel('Drain Current (A)')
    plt.legend(frameon=False, loc='lower center', ncol=2)
    plt.yscale('log')
    plt.show()





if __name__ == "__main__":
    #file = 'BandDiagramVG0V.csv'
    #file = 'banddigramVg1vreally.csv'
    #file = 'BanddigramVG1v.csv'
    #file = 'lg36IDVDS.csv'
    file = 'LG36LG11transfercurve.csv'
    #file = 'LG110nmTransfercurve.csv'
    


    cwd = os.getcwd()
    file = os.path.join(cwd, 'dataFromSayers',  file)
    
    data = np.loadtxt(file,delimiter=",",skiprows=1, dtype=np.unicode_)
    data = np.char.strip(data,'"')
    header = np.loadtxt(file,delimiter=",",comments="\n",dtype=np.unicode_,max_rows=1)
    header = np.char.strip(header,'"')

    #data = data[:,[
    #    np.where(header == "wrf_lat")[0][0],
    #    np.where(header == "wrf_lon")[0][0],
    #    np.where(header == "dmg_wCv")[0][0],
    #    -1]]
    data = data.astype(np.dtype(float))
    print("imported the data")


    #plot_band_diagram(data, header, 1)
    #plot_this(data, header)
    #plot_this2(data, header)
    plot_this2der(data, header)
    #plot_this3(data, header)

    #plot_this6(data,header)







    
    #we make the threshold 0
    if False:
        data = np.hstack((data,np.zeros((data.shape[0],2))))
        data[np.where(data[:,2] != 0),4] = np.log(data[np.where(data[:,2] != 0),2])
        data[np.where(data[:,3] != 0),5] = np.log(data[np.where(data[:,3] != 0),3])
        data[np.where(data[:,2] == 0),4] = -100
        data[np.where(data[:,3] == 0),5] = -100
    if False:
        data = np.hstack((data,np.zeros((data.shape[0],2))))
        places = np.where(data[:,2] != 2)
        data[places,5] = data[places,3]
        data[places,6] = data[places,4]
        np.savetxt("forarcgis.csv", data, delimiter = ",")
    if False:
        # This plots the false negatives chart
        thresholds = np.arange(0,1,0.001);
        outputNegs = []
        outputPos = []
        truth = data[:,-1]
        truth[np.where(truth != 0)] = 1
        for i in thresholds:
            # We want to minimize the false negative rate, this makes the most sense
            u = np.copy(data[:, -2])
            u[np.where(u <  i)] = 0
            u[np.where(u >= i)] = 1
            u = u-truth
            numberOfFalseNegatives = np.where(u == 1)[0].shape[0]
            numberOfFalsePositives = np.where(u == -1)[0].shape[0]
            outputNegs.append(numberOfFalseNegatives)
            outputPos.append(numberOfFalsePositives)
        print(outputNegs)
        print(outputPos)
        fig, (ax1, ax2) = plt.subplots(1, 2)
        fig.suptitle('UConn dataset')
        ax1.plot(thresholds, outputNegs)
        ax2.plot(thresholds, outputPos)
        ax1.set_title("Number of false negatives vs. threshold")
        ax2.set_title("Number of false positives vs. threshold")

        ax1.set(xlabel="Threshold", ylabel="Number of false negatives")
        ax2.set(xlabel="Threshold", ylabel="Number of false positives")

        plt.show()
    if False:
        # This plots the CDF of the variables
        x1 = np.sort(data[:,-2])
        x2 = np.sort(data[:,-3])
        y1 = np.arange(len(x1)) / float(len(x1))
        #y2 = np.arange(len(x2)) / float(len(x2))
        plt.plot(x1, y1)
        #plt.plot(x2, y2)
        plt.xlabel("Predicted Damage from Zero Model")
        plt.ylabel("CDF")
        plt.title("UCONN CDF")
        plt.show()

