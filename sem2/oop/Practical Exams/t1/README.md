# Hi, Gene!
A biologist needs an application to manage the list of genes she is studying. Each **Gene** has an `organism` it belongs to, a `name` and the associated `sequence`. The gene sequence is composed only of letters from the alphabet {`A, C, G, T`}. See below some examples of genes (attributes are organism name, gene name and gene sequence, in that order, separated by `|`):

`E_Coli_K12 | yqgE | ATGACATCATCATTG`\
`M_tuberculosis | ppiA | TCTTCATCATCATCGG`\
`Mouse | Col2a1 | TTAAAGCATGGCTCTGTG`\
`E_Coli_ETEC | yqgE | GTGACAGCGCCCTTCTTTCCACG`\
`E_Coli_K12 | hokC | TTAATGAAGCATAAGCTTGATTTC`

Write a C++ console-based gene manager application which allows to:
1. Add a new gene. The combination of organism and gene name is unique. A message is shown if the gene was successfully added **[1p]**, or in case another gene with the same organism and the same name exists **[1p]**.
2. Show all the genes, with all their information, sorted in decreasing order of sequence length **[1p]**. Organism and gene name must be left-justified, and the sequence must be right justified **[1p]**, as shown below:

`E_Coli_K12     | hokC   | TTAATGAAGCATAAGCTTGATTTC`\
`E_Coli_ETEC    | yqgE   |  GTGACAGCGCCCTTCTTTCCACG`\
`Mouse          | Col2a1 |       TTAAAGCATGGCTCTGTG`\
`M_tuberculosis | ppiA   |         TCTTCATCATCATCGG`\
`E_Coli_K12     | yqgE   |          ATGACATCATCATTG`

3. Show all the genes that include the sequence entered by the user **[1p]**. Use the rules from the point above regarding gene ordering and text justification **[1p]**. For example, the `CATC` sequence can be found in the `E_Coli_K12/yqgE` and `M_tuberculosis/ppiA` genes.

4. Given a pair of organism and gene names, display their longest common subsequence **[2p]**. For example, for the pair `M_tuberculosis/ppiA` and `E_Coli_K12/yqgE`, this is `CATCATCAT`.

Write specifications and tests for the following repository/service functions:
- Function which adds a gene **[0.5p]**
- Function which calculates the longest common subsequence **[0.5p]**

Have at least 5 genes in your repository. You may use those provided here. The application must use layered architecture in order for functionalities to be graded.

default **[1p]**.
