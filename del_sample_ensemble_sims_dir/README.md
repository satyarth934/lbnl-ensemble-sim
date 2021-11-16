# Sample Ensemble Simulations Directory

The files are directories in this sample directory are not usable and are only for demonstration purposes.

Following is the expected directory structure:
```
sample_ensemble_sims_dir
├── shared_files
│   ├── farea_3D_barriers.exo
│   ├── farea_tritium.bdg
│   └── run_amanzi.sh
├── sim0
│   ├── farea_3d_tritium.xml
│   └── run_sim0.sh
├── sim1
│   ├── farea_3d_tritium.xml
│   └── run_sim1.sh
├── sim2
│   ├── farea_3d_tritium.xml
│   └── run_sim2.sh
└── sim3
    ├── farea_3d_tritium.xml
    └── run_sim3.sh
```

The `run_simN.sh` files are same as the `run_amanzi.sh` file that are copied to the respective simulation directory for isolating simulations.
The [`run_ensembles.sh`](../run_ensembles.sh) file generates these `simN/run_simN.sh` files from the `shared_files/run_amanzi.sh` file.

The `simN/farea_3d_tritium.xml` files contain the different simulation configurations that are generated from the [`generate_input_files.py`](../src/generate_input_files.py) file.
