## Abstract

[Taija](https://github.com/JuliaTrustworthyAI) is a growing ecosystem of packages geared towards *T*rustworthy *A*rtificial *I*ntelligence in *J*uli*a*. This talk will provide an update on recent developments of some of our core packages. In particular, the focus will be on contributions made by two groups of students from TU Delft, as well as ongoing JSoC work.

## Description

Julia's ecosystem for Artificial Intelligence (AI) and Machine Learning (ML) has been growing at a relatively rapid pace, perhaps most notably so in the [SciML](https://sciml.ai/) domain but also more broadly (e.g. [Flux](https://fluxml.ai/), [MLJ](https://juliaai.github.io/MLJ.jl/stable/), [JuliaGenAI](https://github.com/JuliaGenAI/juliagenai.org), ...). The goal of Taija is to make AI models more trustworthy, where we have so far focused primarily on the interplay with packages in the latter category.

## 🏠 About 

Taija currently covers a range of approaches towards making AI systems more trustworthy:

- Model Explainability ([CounterfactualExplanations.jl](https://github.com/JuliaTrustworthyAI/CounterfactualExplanations.jl))
- Algorithmic Recourse ([CounterfactualExplanations.jl](https://github.com/JuliaTrustworthyAI/CounterfactualExplanations.jl), [AlgorithmicRecourseDynamics.jl](https://github.com/JuliaTrustworthyAI/AlgorithmicRecourseDynamics.jl))
- Predictive Uncertainty Quantification ([ConformalPrediction.jl](https://github.com/JuliaTrustworthyAI/ConformalPrediction.jl), [LaplaceRedux.jl](https://github.com/JuliaTrustworthyAI/LaplaceRedux.jl))
- Effortless Bayesian Deep Learning ([LaplaceRedux.jl](https://github.com/JuliaTrustworthyAI/LaplaceRedux.jl))
- Hybrid Learning ([JointEnergyModels.jl](https://github.com/JuliaTrustworthyAI/JointEnergyModels.jl))

Various meta packages can be used to extend the core functionality:

- Plotting ([TaijaPlotting.jl](https://github.com/JuliaTrustworthyAI/TaijaPlotting.jl))
- Datasets for testing and benchmarking ([TaijaData.jl](https://github.com/JuliaTrustworthyAI/TaijaData.jl))
- Parallelization ([TaijaParallel.jl](https://github.com/JuliaTrustworthyAI/TaijaParallel.jl))
- Interoperability with other programming languages ([TaijaInteroperability.jl](https://github.com/JuliaTrustworthyAI/TaijaInteroperability.jl))

The [TaijaBase.jl](https://github.com/JuliaTrustworthyAI/TaijaBase.jl) package provides common symbols, types and functions that are used across all or multiple Taija packages.

## 🧑‍🎓 Student Projects

During the past year, various groups of undergraduate students at TU Delft have contributed to some of our packages. The talk will present the high-level outcomes of this and discuss some of the experiences we've had.

### CounterfactualExplanations.jl

`CounterfactualExplanations.jl` is a package for Counterfactual Explanations and Algorithmic Recourse in Julia. 

### LaplaceRedux.jl

`LaplaceRedux.jl` is a package for effortless Bayesian Deep Learning through Laplace Approximation for `Flux.jl` neural networks.

### Experiences

## 🎯 Ongoing and Future Projects

Taija has been running two Julia Season of Code projects this summer.

1. (*Conformal Bayes*) Bridging the gap between Bayesian and frequentist approaches to Predictive Uncertainty Quantification.
2. (*Causal Recourse*) From minimal perturbations to minimal interventions for Algorithmic Recourse.