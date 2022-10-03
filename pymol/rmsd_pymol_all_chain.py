import os
import pandas as pd
import pymol
from pymol import cmd
import numpy as np
from functools import reduce

rmsd_matrix = pd.DataFrame()
os.chdir(r'/doctorai/noaheh/per_conda/Pymol/data/')
chains = ("H", "L", "paired")
for chain in chains:
    #takes input sources and inner join to find the common structures
    ABB = "/doctorai/noaheh/per_conda/Pymol/data/ABB/" + chain + "/"
    AF2 = "/doctorai/noaheh/per_conda/Pymol/data/AF2/" + chain + "/"
    IgFold = "/doctorai/noaheh/per_conda/Pymol/data/IgFold/" + chain + "/"

    data1 = pd.DataFrame(({"ID":os.listdir(ABB)}))
    data2 = pd.DataFrame(({"ID":os.listdir(ABB)}))
    data3 = pd.DataFrame(({"ID":os.listdir(IgFold)}))

    names_of_files = reduce(lambda left, right:     # Merge three pandas DataFrames
                     pd.merge(left , right,
                              on = ["ID"]),
                     [data1, data2, data3])
    print(names_of_files + chain)
    # THis line is new
    rmsd_chain_python = pd.DataFrame(columns = ["crystal_vs_ABB","crystal_vs_AF2","crystal_vs_IGFold","ABB_vs_AF2","ABB_vs_IGFold","IGFold_vs_AF2"], index =[names_of_files["ID"]])
    print(rmsd_chain_python)
    file_name = "rmsd_" + chain + "_python.csv"
    file_name_np = "rmsd_" + chain + "_python_np.csv"

    for element in names_of_files["ID"]:

        crystal_file_name = "crystal/" + chain + "/" + element
        ABB_file_name = "ABB/" + chain+ "/" + element
        AF2_file_name = "AF2/" + chain+ "/" + element
        IgFold_file_name = "IgFold/" + chain+ "/" + element

        crystal_log_name = "crystal_" + element
        ABB_log_name = "ABB_" + element
        AF2_log_name = "AF2_" + element
        IgFold_log_name = "IgFold_" + element

        cmd.load(str(crystal_file_name), str(crystal_log_name))
        cmd.load(str(ABB_file_name), str(ABB_log_name))
        cmd.load(str(AF2_file_name), str(AF2_log_name))
        cmd.load(str(IgFold_file_name), str(IgFold_log_name))

        rmsd1=cmd.align(crystal_log_name, ABB_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["crystal_vs_ABB"]] = rmsd1[0]

        rmsd2=cmd.align(crystal_log_name, AF2_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["crystal_vs_AF2"]] = rmsd2[0]

        rmsd3=cmd.align(crystal_log_name, IgFold_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["crystal_vs_IGFold"]] = rmsd3[0]

        rmsd4=cmd.align(ABB_log_name, AF2_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["ABB_vs_AF2"]] = rmsd4[0]

        rmsd5=cmd.align(ABB_log_name, IgFold_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["ABB_vs_IGFold"]] = rmsd5[0]

        rmsd6=cmd.align(AF2_log_name, IgFold_log_name, cycles = 0)
        rmsd_chain_python.loc[[element],["IGFold_vs_AF2"]] = rmsd6[0]


        cmd.delete(str(crystal_log_name))
        cmd.delete(str(ABB_log_name))
        cmd.delete(str(AF2_log_name))
        cmd.delete(str(IgFold_log_name))
        
    print(chain + "finished")
    np.savetxt(str(file_name_np),rmsd_chain_python, delimiter=',')
    rmsd_chain_python.to_csv(str(file_name))


##########
