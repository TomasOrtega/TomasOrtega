**PhD Candidate**

**Center for Pervasive Communications and Computing (CPCC) at the University of California, Irvine**

Originally, I am from Sant Cugat (near Barcelona) but I've lived in Pasadena, Irvine (now), as well as Madison, WI.

My doctoral advisor is [Hamid Jafarkhani](https://www.ece.uci.edu/~hamidj/), and I have previously been at NASA's JPL with [Marc Sanchez-Net](https://scholar.google.com/citations?user=0C0EdK8AAAAJ&hl=en) and at the Vector Institute with [Xiaoxiao Li](https://xxlya.github.io/). 

[![Google Scholar](https://img.shields.io/badge/Google%20Scholar-4285F4?style=for-the-badge&logo=google-scholar&logoColor=white)
](https://scholar.google.com/citations?user=YElSNAIAAAAJ&hl=en)  [![X (Twitter)](https://img.shields.io/badge/X-000000.svg?style=for-the-badge&logo=X&logoColor=white)
](https://twitter.com/tomas__ortega)  [![CV](https://img.shields.io/badge/CV-009900?style=for-the-badge&logoColor=white)](https://tomasortega.github.io/CV.pdf)

# Research interests

My research is focused on making distributed algorithms work in communication-constrained networks, with an emphasis on privacy-preserving Machine Learning. I derive theoretical bounds and demonstrate my results with practical implementations. This includes algorithms for Federated Learning and Decentralized Control.

More broadly, I am interested in optimization, information theory and AI.

### Truly decentralized learning on directed graphs

Decentralized optimization algorithms typically require communication between nodes to be bi-directional. 

In the directed case, existing algorithms required nodes to know how many listeners they have (knowledge of their out-degree). We proposed a [series of works](https://github.com/TomasOrtega/DT-GO) that circumvent this requirement.

A nice property of this work is that it naturally accomodates networks with delays, as one can add imaginary nodes to the network to model delays, and use the same analysis framework to obtain convergence guarantees.

Currently, I'm interested in incorporating more aspects of real networks to bridge the gap between the practice and theory of decentralized learning.

### Proving stuff with Lean

On the side, I'm learning about theorem proving with Lean. In the future I would like to formalize more of my proofs using Lean, so far I have only done some [tests](https://github.com/TomasOrtega/test_dtgo). 


### Error correcting codes from Generalized Quadrangles

Together with Simeon Ball, we developed [a method](https://arxiv.org/pdf/2405.20524) to construct point-line incidence matrices for Generalized Quadrangles in polynomial time (polynomial to the 4th, 6th and 11th power for different GQs but hey, still better than existing exponential methods). 

This allowed us to construct [the largest point-line GQ incidence matrix repository](https://github.com/TomasOrtega/QuasiCyclicGQs) that currently exists. 
But, better than that, these point-line incidence matrices are quasi-cyclic! 
This is a really desireable property if you want to construct error correcting codes from GQs, which achieve a very good error rate to round of belief propagation decoding ratio. 
The repository also has .alist matrices to easily run LDPC simulations.


<!--
**TomasOrtega/TomasOrtega** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->
