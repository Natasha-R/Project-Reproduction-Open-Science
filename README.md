# Project Reproduction: Open Science

The purpose of this work is to attempt to reproduce a study by re-using a published dataset, for the final project of the TH Köln (https://www.th-koeln.de/) module "Open Science" as part of the Digital Sciences Master's Degree. 

Original dataset: https://doi.org/10.5061/dryad.9bg43   
Original paper: https://doi.org/10.1371/journal.pone.0110497    

**The main Jupyter Notebooks used for analyses are located here:** https://github.com/Natasha-R/Project-Reproduction-Open-Science/tree/main/Reproduction%20Project/Reproduction%20Project%20Code
These can be viewed on Github, or the project can be downloaded and worked on locally. Guidelines to run the notebooks are included within the code.

1. [Cleaning and Exploring the Data](https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Reproduction%20Project/Reproduction%20Project%20Code/1.%20Cleaning%20and%20Exploring%20Data.ipynb)  
2. [Masculinity Preferences by Priming Group](https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Reproduction%20Project/Reproduction%20Project%20Code/2.%20Masculinity%20preferences%20by%20priming%20group.ipynb)  
3. [Masculinity Preferences over Time](https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Reproduction%20Project/Reproduction%20Project%20Code/3.%20Masculinity%20over%20'time'.ipynb)  
4. [Modelling the Data](https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Reproduction%20Project/Reproduction%20Project%20Code/4.%20Modelling%20the%20data.ipynb)  

**Our data management plan (DMP) is located here:** https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Data%20Management%20Plan.pdf

Our modified dataset is released under Creative Commons Attribution 4.0 International (CC BY 4.0).  
Our research software is released under the MIT licence.  

## Description of project directory structure:

The project directory contains:

| Object                         | Description                                                                                                            |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------|
| Folder: “Original Files”       | The original study files as provided by the original researchers.                                                      |
| Folder: “Reproduction Project” | Our re-structuring and modifying of the original files, as well as additional datasets and software (code).            |
| PDF: “Data Management Plan”.   | Our current data management plan. Contains information about the datasets, software, metadata and contact information. |

The “Reproduction Project” folder contains:

| Object                                                                                               | Description                                                                                                                                                                                  |
|------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 4 folders corresponding to the 2 “main studies” and 2 “supplementary studies” described in the paper | Each folder contains its respective data, e.g. “main_study_face_data.csv” and any re-used and modified datasets, e.g.  “main_study_face_data_modified.csv”.                                  |
| The folder “Reproduction Project Code”                                                               | Contains the code and Jupyter notebooks used to analyse the data, numbered in order. The notebooks containing an incorrect analysis (labelled “WRONG DATA”) are included for transparency.   |
| The xlsx file: “Downloaded Data (All Studies)”.                                                      | The form of the original dataset, included for reference.                                                                                                                                    |
| The pdf file “Published Article”.                                                                    | The original journal article associated with the dataset, included for reference.                                                                                                            |
| The docx file “Description of Supplementary Studies”.                                                | An explanation of the supplementary studies as provided by the original researchers, included for reference.                                                                                 |

## Description of the modified dataset:

The purpose of the original data collection, structure of the associated study, and meaning of the attributes in the dataset is described in the journal article: (https://doi.org/10.1371/journal.pone.0110497).

In our modified dataset, [“main_study_face_data_modified.csv”](https://github.com/Natasha-R/Project-Reproduction-Open-Science/blob/main/Reproduction%20Project/Main%20Study%20(Face)/main_study_face_data_modified.csv) the contents of each of the attributes are:

| Attribute Name        | Attribute Meaning                                                                                                                                                                                                 | Attribute Contents                                                                         |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| participant_id        | The unique ID identifier for each of the participants in the study.                                                                                                                                               | String of 331 possible values, e.g. “13” or “211b”.                                        |
| prime_condition       | A number representing the priming condition group each participant was assigned to.                                                                                                                               | Integer in range: 1 to 5                                                                   |
| prime_condition_names | The name (mapped from the prime condition number) of the relevant priming condition group.                                                                                                                        | String of possible values: “neutral”, “male/male”, “male/group”, “male/female”, “pathogen” |
| trial_number          | Each row in the dataset corresponds to each trial for each particular participant, where they choose whether they prefer an image of a masculinised or feminised face.                                            | Integer in range: 1 to 40                                                                  |
| image                 | The image shown to the participant, containing a masculinised and feminised face.                                                                                                                                 | String of form Slide{}.bmp, where {} is the number of the slide, e.g. Slide13.bmp          |
| pre_post_prime        | An indicator of whether this particular trial occurs before (0) or after (1) the participant has been shown their respective priming images. All trials ≥ 20 are post prime (1), the remainder are pre-prime (0). | Integers: 0 or 1                                                                           |
| chose_masc            | An indicator of whether on this particular trial the participant chose the masculinised face (1) or feminised face (0).                                                                                           | Integers: 0 or 1                                                                           |
