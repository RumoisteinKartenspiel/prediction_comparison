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

chains = ("H", "L", "paired")
for chain in chains:
    #takes input sources and inner join to find the common structures
    ABB_join = "ABB/" + chain + "/"
    AF2_join = "AF2/" + chain + "/"
    IgFold_join = "IgFold/" + chain + "/"

    data1 = pd.DataFrame(({"ID":os.listdir(ABB_join)}))
    data2 = pd.DataFrame(({"ID":os.listdir(ABB_join)}))
    data3 = pd.DataFrame(({"ID":os.listdir(IgFold_join)}))

    names_of_files = reduce(lambda left, right:     # Merge three pandas DataFrames
                     pd.merge(left , right,
                              on = ["ID"]),
                     [data1, data2, data3])
    print(names_of_files + chain)
    # THis line is new
    rmsd_chain_python = pd.DataFrame(columns = ["crystal_vs_ABB","crystal_vs_AF2","crystal_vs_IgFold","ABB_vs_AF2","ABB_vs_IgFold","AF2_vs_IgFold"], index =[names_of_files["ID"]])
    file_name = "rmsd_" + chain + "_python.csv"
    
    for element in names_of_files["ID"]:

        crystal = "crystal/" + chain + "/" + element
        ABB = "ABB/" + chain + "/" + element
        AF2 = "AF2/" + chain + "/" + element
        IgFold = "IgFold/" + chain+ "/" + element

        

        print(ABB)
        ######################
        #crstal_VS_ABB
        ######################
        model_path = ABB
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
        
        rmsd_chain_python.loc[[element],["crystal_vs_ABB"]] = rmsd1

        ######################
        #crstal_VS_AF2
        ######################
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
        

        rmsd2=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        
        rmsd_chain_python.loc[[element],["crystal_vs_AF2"]] = rmsd2
        ######################
        #crstal_VS_IgFold
        ######################
        model_path = IgFold
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
        

        rmsd3=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        
        rmsd_chain_python.loc[[element],["crystal_vs_IgFold"]] = rmsd3
        ######################
        #ABB_VS_AF2
        ######################
        model_path = AF2
        reference_path = ABB
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
        

        rmsd4=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        
        rmsd_chain_python.loc[[element],["ABB_vs_AF2"]] = rmsd4
        ######################
        #ABB_VS_IgFold
        ######################
        model_path = IgFold
        reference_path = ABB
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
        

        rmsd5=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        
        rmsd_chain_python.loc[[element],["ABB_vs_IgFold"]] = rmsd5
        ######################
        #AF2_VS_IgFold
        ######################
        model_path = IgFold
        reference_path = AF2
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
        

        rmsd6=LocalDistDiffTest(model_view,
                          references,
                          rdmap,
                          settings)
        
        rmsd_chain_python.loc[[element],["AF2_vs_IgFold"]] = rmsd6
        print(rmsd_chain_python)



    print(chain + "finished")
    
    rmsd_chain_python.to_csv(str(file_name))