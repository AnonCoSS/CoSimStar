# CoSimStar

# Overview

This repository contains code and scripts for testing various algorithms for time efficiency, memory usage, and accuracy. It is structured into three main folders:

- **`Datasets`**: Contains the datasets used for algorithm testing.
- **`Time and Memory`**: Scripts to test the time and memory efficiency of each algorithm.
- **`Accuracy`**: Scripts to test the accuracy of CoSS and POW algorithms.

## Folders

### `Datasets`

This folder contains the datasets used in the experiments. The datasets used are:

| Dataset           | Abbr. | \|V\| Nodes   | \|E\| Edges    | Avg. Degree (\|E\|/\|V\|)  | Download Link                                                                                       |
|-------------------|-------|--------------:|---------------:|--------------------:|-----------------------------------------------------------------------------------------------------|
| email-Eu-core     | EE    |         1,005 |         25,571 | 25.44378109         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/email-Eu-core.mat)         |
| p2p-Gnutella08    | P2P   |         6,301 |         20,777 | 3.297413109         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/p2p-Gnutella08.mat)        |
| cit-HepPh         | HP    |        34,546 |        421,578 | 12.203381           | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/cit-HepPh.mat)             |
| email-EuAll       | EA    |       265,214 |        420,045 | 1.583796481         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/email-EuAll.mat)           |
| com-Youtube       | YT    |     1,134,890 |      5,975,248 | 5.265045952         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/com-Youtube.mat)           |
| soc-LiveJournal1  | LJ    |     4,847,571 |     68,993,773 | 14.23264827         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/soc-LiveJournal1.mat)      |
| twitter7          | TW    |    41,652,230 |  1,468,365,182 | 35.25297882         | [Download](https://suitesparse-collection-website.herokuapp.com/mat/SNAP/twitter7.mat)              |
| uk-2002           | UK    |    18,520,486 |     298,113,762 | 16.096433           | [Download](https://law.di.unimi.it/datasets.php)                                                    |
| eu-2015-host      | EU    |    11,264,052 |     386,915,963 | 34.34962507         | [Download](https://law.di.unimi.it/datasets.php)                                                    |

**Note**: 
- The `uk-2002` and `eu-2015-host` datasets need to be converted to `.mat` format before use, and then use the **Dataset_Convert.m** to convert LAW format into the same format with other datasets (Problem.A). 


### `Time and Memory`

This folder contains scripts for testing the time and memory efficiency of each algorithm. Five algorithms are included:

- **RPCS** (abbr. `RPCS`) 
- **CoSimStar** (abbr. `CoSS`) 
- **PowerIter** (abbr. `POW`) 
- **CoSimMate** (abbr. `CoSM`) 
- **CoSimSVD** (abbr. `CoSSVD`) 

Each algorithm can be run with different datasets to obtain time and memory usage values. 
- **`RPCS.m`**
- **`CoSS.m `** with the arnaldi.m, to test the time and memory in phases. 
- **`POW.m`**
- **`CoSM.m`**
- **`CoSSVD.m`**

### `Accuracy`

This folder is used to test the accuracy of the CoSS and POW algorithms. The testing process is as follows:

1. Run `CoSS.m` to generate queries and results in the respective dataset folder.
2. Run `POW.m` to extract the corresponding queries in the dataset folder and generate results.
3. Run `Acc.m` to batch test the accuracy.

