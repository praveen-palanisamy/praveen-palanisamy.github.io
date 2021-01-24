---
layout: post
title: TensorFlow 2.x Reinforcement Learning Cookbook
category: Deep Reinforcement Learning, TensorFlow 2.x, RL, DRL
tags: [TensorFlow 2.x, Deep RL code, Cross-platform RL Apps, mobile Deep RL]
---

#### TFRL Cookbook is a practical guide with over 50 short-&-sweet recipes to help you build, train and deploy learning agents for real-world applications

![TF-RL-Cookbook]({{site.url}}/blog/images/tfrl-ckbk-cover-focused.jpg){:class="img-responsive"}

## What is this book about?

With deep reinforcement learning, you can build intelligent agents, products, and services that can go beyond computer vision or perception to perform actions. TensorFlow 2.x is the latest major release of the most popular deep learning framework used to develop and train deep neural networks (DNNs). This book contains easy-to-follow recipes for leveraging TensorFlow 2.x to develop artificial intelligence applications.

Starting with an introduction to the fundamentals of deep reinforcement learning and TensorFlow 2.x, the book covers OpenAI Gym, model-based RL, model-free RL, and how to develop basic agents. You'll discover how to implement advanced deep reinforcement learning algorithms such as actor-critic, deep deterministic policy gradients, deep-Q networks, proximal policy optimization, and deep recurrent Q-networks for training your RL agents. As you advance, you’ll explore the applications of reinforcement learning by building cryptocurrency trading agents, stock/share trading agents, and intelligent agents for automating task completion. Finally, you'll find out how to deploy deep reinforcement learning agents to the cloud and build cross-platform apps using TensorFlow 2.x.

By the end of this TensorFlow book, you'll be able to:

|                                                                                                                                                                                                   |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Build**: Deep RL agents from scratch using the all-new and powerful TensorFlow 2.x framework and Keras API                                                                                      |
| **Implement**: Deep RL algorithms (DQN, A3C, DDPG, PPO, SAC etc.) with minimal lines of code                                                                                                      |
| **Train**: Deep RL agents in simulated environments (gyms) beyond toy-problems and games to perform real-world tasks like cryptocurrency trading, stock trading, tweet/email management and more! |
| **Scale**: Distributed training of RL agents using TensorFlow 2.x, Ray + Tune + RLLib                                                                                                             |
| **Deploy**: RL agents to the cloud and edge for real-world testing by creating cloud services, web apps and Android mobile apps using TensorFlow Lite, TensorFlow.js, ONNX and Triton             |
|                                                                                                                                                                                                   |

This book covers the following exciting features:

- Build deep reinforcement learning agents from scratch using the all-new TensorFlow 2.x and Keras API
- Implement state-of-the-art deep reinforcement learning algorithms using minimal code
- Build, train, and package deep RL agents for cryptocurrency and stock trading
- Deploy RL agents to the cloud and edge to test them by creating desktop, web, and mobile apps and cloud services
- Speed up agent development using distributed DNN model training
- Explore distributed deep RL architectures and discover opportunities in AIaaS (AI as a Service)

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/183898254X) today!

The chapter-wise recipes covered in the book are listed below with direct links to the code:

## TFRL Cookbook recipes

### Chapter 1: Developing building blocks for Deep RL using TensorFlow 2.x & Keras

- 1.1 Building environment and reward mechanism for training RL agents

- 1.2 Implementing neural-network-based RL policies for discrete action spaces and decision-making problems

- 1.3 Implementing neural-network-based RL policies for continuous action spaces and continuous-control problems

- 1.4 Working with OpenAI Gym for RL training environments

- 1.5 Building a neural agent

- [1.6 Building a neural evolutionary Agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter01/06_neural_evolutionary_agent.py)

### Chapter 2: Implementing value-based, policy gradients and actor-critic Deep RL algorithms

- 2.1 Building stochastic environmnts for training RL agents

- [2.2 Building value-based Reinforcement Learning agent algorithms](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/2_value_based_rl.py)

- [2.3 Implementing Temporal Difference (TD) Learning](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/3_temporal_difference_learning.py)

- [2.4 Building Monte-Carlo prediction and control for RL](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/4_monte_carlo_prediction_and_control_rl.py)

- [2.5 Implementing SARSA algorithm and SARSA agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/5_sarsa_sarsa_lambda.py)

- [2.6 Building a Q-Learning agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/6_q_learning.py)

- [2.7 Implementing Policy Gradients (PG) and a PG agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/7_policy_gradients.py)

- [2.8 Implementing Actor-Critic Algorithms and agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter02/8_actor_critic_agent.py)

### Chapter 3: Implementing Advanced (Deep) RL algorithms

- [3.1 Implementing Deep Q-Learning, DQN and Double-DQN agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/1_double_dqn.py)

- [3.2 Implementing Dueling DQN agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/2_dueling_dqn.py)

- [3.3 Implementing Double Dueling DQN algorithm and the DDDQN agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/3_dueling_double_dqn.py)

- [3.4 Implementing Deep Recurrent Q-Learning algorithm and the DRQN Agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/4_drqn.py)

- [3.5 Implementing Asynchronous Advantage Actor-Critic algorithm and the A3C agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/5_a3c_continuous.py)

- [3.6 Implementing Proximal Policy Optimization algorithm and the PPO agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/6_ppo_continuous.py)

- [3.7 Implementing Deep Deterministic Policy Gradient algorithm and the DDPG agent](https://github.com/PacktPublishing/Tensorflow-2-Reinforcement-Learning-Cookbook/blob/master/Chapter03/7_ddpg.py)

### Chapter 4: RL in real-world: Building cryptocurrency trading agents

- 4.1 Building Bitcoin trading RL platform using real market data

- 4.2 Building Ethereum tradingRL platform using price charts

- 4.3 Building advanced cryptocurrency trading platform for RL agents

- 4.4 Training cryptocurrency trading bot using RL

### Chapter 5: RL in real-world: Building stock/share trading agents

- 5.1 Building stock-market trading RL platform using real stock-exchange data

- 5.2 Building stock-market trading RL platform using price charts

- 5.3 Building advanced stock trading RL platform to train agents that trade like human pros

### Chapter 6: RL in real-world: Building intelligent agents to complete your To-Dos

- 6.1 Building learning environments for real-world RL

- 6.2 Building an RL agent to complete tasks on the web: Call to Action bot

- 6.3 Building a visual auto-login bot

- 6.4 Training an RL agent to automate flight booking for your travel

- 6.5 Training an RL agent to manage your emails

- 6.6 Training an RL agent to automate your social-media account management

### Chapter 7: Deploying Deep RL agents to the cloud

- 7.1 Implementing RL agent's runtime components

- 7.2 Building RL environment simulator as a service

- 7.3 Training RL agents using remote simulator instances

- 7.4 Ealuating/testing RL agents

- 7.5 Packaging RL agents for deployment: A trading bot

- 7.6 Deploying RL agents to the cloud: Trading-Bot-as-a-Service

### Chapter 8: Distributed training for accelerated development of Deep RL agents

- 8.1 Building distributed deep learning models using TensorFlow 2.x: Multi-GPU training

- 8.2 Scaling up and out: Multi-machine, multi-GPU training

- 8.3 Training Deep RL agents at scale: Multi-GPU PPO agent

- 8.4 Building blocks for distributed Deep Reinforcement learning for accelerated training

- 8.5 Large-scale Deep RL agent training using Ray, Tune and RLLib

### Chapter 9: Deploying Deep RL agents on multiple platforms

- 9.0 Runtime options for cross-platform deployments

- 9.1 Packaging Deep RL agents for mobile and IoT devices using TensorFlow Lite

- 9.2 Deploying RL agents on mobile devices

- 9.3 Packaging Deep RL agents for the web and Node.js using TensorFlow.js

- 9.4 Deploying Deep-RL-Agent-as-a-Service

- 9.5 Packaging Deep RL agents for cross-platform deployments
