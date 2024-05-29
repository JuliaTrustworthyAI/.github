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

### [CounterfactualExplanations.jl]

### [LaplaceRedux.jl]

### Experiences

## 🎯 Ongoing and Future Projects



No trust without uncertainty estimation. We can hardly *trust* a system which is equally uncertain about is equally confident in all of its answers, correct or not, especially if people's money, time, health and safety are at stake. To make black-box-like neural networks more trustworthy, we need not necessarily aim for explainability, if we can embed uncertainty calibration in the model.

In the common deep learning setting however, the trained network weights serve as a point estimate of the (locally) optimal parameters, omitting weight posterior uncertainty estimation, leading to the resulting model being badly-calibrated, overconfident and non-robust, especially in out-of-distribution settings.

Bayesian inference was once the state-of-the-art for learning with neural networks, however, parameter posterior estimation quickly becomes intractable with large models, because of high dimensionality of the paramater space ([Izmailov et al. 2019](https://arxiv.org/abs/1907.07504v1)). Laplace approximations (LA) aim to be a highly scalable and modular method of tackling these issues for modern deep neural networks. LA can be applied *post hoc*, upon completion of the network training, thus requiring no expensive modification to the training procedure.

In their recent work, [Daxberger et al. (2021)](https://arxiv.org/abs/2106.14806) have introduced `laplace`, a high-quality PyTorch library providing an accessible API to all major variants of LAs.
The Julia world promptly followed suit, with [Patrick Altmeyer](https://www.paltmeyer.com/) presenting [LaplaceRedux.jl](https://github.com/JuliaTrustworthyAI/LaplaceRedux.jl) at [JuliaCon 2022](https://www.paltmeyer.com/content/talks/posts/2022-juliacon/).

Our team of five undergraduate CS&E students has made multiple enhancements to LaplaceRedux.jl,
under supervision of Patrick Altmeyer, as part of the course CSE2000 "Software Project" at TU Delft.
The team included Mark Ardman, Severin Bratus, Adelina Cazacu, Andrei Ionescu, and Ivan Makarov. This talk summarizes our contributions. Another summary of the project can be found on [Medium](https://medium.com/@sbratus/an-introduction-to-laplace-approximations-for-bayesian-deep-learning-in-julia-c5a30cfaf7b5).

We hope that this work will inspire broader adoption of Bayesian methods in applied deep learning, and more contributions to LaplaceRedux.jl.