# Cluster job files

These files are supposed to help running SpineOpt on a cluster.


## Folder strucure

### `DTU`

This folder contains the .job file which runs the different scenarios defined in the database in a loop. The .submit file contains the server settings. Each job calls the .julia file. The results are written to the output database, the model can be printed. You will need an input folder containing the input database and an output folder containing the output database (there is also another input folder in there saving the used input database). This might not be most efficient but it works (for me).


### `ETH`

(Hopefully to come.)


