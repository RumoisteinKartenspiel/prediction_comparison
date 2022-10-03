
#run this script after this command
#docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest try.py >> output_single_residue_cry_ABB_L_lddt.txt
from ost.io import LoadPDB
from ost.mol.alg import (CleanlDDTReferences,
                         PreparelDDTGlobalRDMap,
                         lDDTSettings,
                         CheckStructure,
                         LocalDistDiffTest,
                         GetlDDTPerResidueStats,
                         PrintlDDTPerResidueStats,
                         ResidueNamesMatch)
from ost.io import ReadStereoChemicalPropsFile
import os
import pandas as pd
import numpy as np
from functools import reduce

###########################################################
# L-chain & crystal_AF2
###########################################################
chains = ("L")
for chain in chains:
    #takes input sources and inner join to find the common structures
    ABB_join = "ABB/" + chain + "/"
    AF2_join = "AF2/" + chain + "/"
    IgFold_join = "IgFold/" + chain + "/"

    data1 = pd.DataFrame(({"ID":os.listdir(ABB_join)}))
    data2 = pd.DataFrame(({"ID":os.listdir(AF2_join)}))
    data3 = pd.DataFrame(({"ID":os.listdir(IgFold_join)}))

    names_of_files = reduce(lambda left, right:     # Merge three pandas DataFrames
                     pd.merge(left , right,
                              on = ["ID"]),
                     [data1, data2, data3])
    
    # TLis line is new
    per_residue_names = pd.DataFrame(columns = ["crystal_vs_ABB","crystal_vs_AF2","crystal_vs_IgFold","ABB_vs_AF2","ABB_vs_IgFold","AF2_vs_IgFold"], index =[names_of_files["ID"]])
    
    ############################################################################################
    #                                !!!!!!!!!!      IMPORTANT      !!!!!!!!
    ############################################################################################
    file_name = "name_single_res_lldt_" + chain + "_crystal_AF2.csv"
    ##############################################################################################
    #										Please change the above file name 
    #										to adapt it to current analysis runnning

    ############################################################################################
    
    for element in names_of_files["ID"]:

        crystal = "crystal/" + chain + "/" + element
        ABB = "ABB/" + chain + "/" + element
        AF2 = "AF2/" + chain + "/" + element
        IgFold = "IgFold/" + chain+ "/" + element

        
        ######################
        #crstal_VS_ABB
        ######################
        per_residue_names.loc[[element],["crystal_vs_ABB"]] = element

        model_path = AF2
        reference_path = crystal
        structural_checks = True
        bond_tolerance = 12
        angle_tolerance = 12
        cutoffs = [0.5, 1.0, 2.0, 4.0]
        # Load model and prepare its view
        model = LoadPDB(model_path)
        model_view = model.GetChainList()[0].Select("peptide=true")
        #
        # Prepare references - it should be alist of EntityView(s)
        references = [LoadPDB(reference_path).CreateFullView()]
        #
        # Initialize settings with default parameters and print them
        settings = lDDTSettings()
        settings.PrintParameters()

        #
        # Clean up references
        CleanlDDTReferences(references)
        #
        # Prepare residue map from references
        rdmap = PreparelDDTGlobalRDMap(references,
                                       cutoffs=cutoffs,
                                       sequence_separation=settings.sequence_separation,
                                       radius=settings.radius)
        #
        # Calculate lDDT
        

        rmsd1=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        local_scores = GetlDDTPerResidueStats(model_view,
                                      rdmap,
                                      structural_checks,
                                      settings.label)
        #
        # Pring local scores
        PrintlDDTPerResidueStats(local_scores, structural_checks, len(cutoffs))
        
    
    per_residue_names.to_csv(str(file_name))