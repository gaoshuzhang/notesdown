
# 随机模拟

## 随机数

产生重复的随机数，octave 实现，随机数生成的详细介绍请看统计之都文章 [随机数生成及其在统计模拟中的应用](https://cosx.org/2017/05/random-number-generation/)


```octave
%% copy from https://stackoverflow.com/questions/13735096/python-vs-octave-random-generator
function state = mtstate(seed)
state = uint32(zeros(625,1));
state(1) = uint32(seed);
for i=1:623,
   tmp = uint64(1812433253)*uint64(bitxor(state(i),bitshift(state(i),-30)))+i;
   state(i+1) = uint32(bitand(tmp,uint64(intmax('uint32'))));
end
state(625) = 1;
end

rand('state',mtstate(4));
rand(1,5)
rand('state',mtstate(4));
rand(1,5)
#> ans =
#> 
#>    0.96703   0.54723   0.97268   0.71482   0.69773
#> 
#> ans =
#> 
#>    0.96703   0.54723   0.97268   0.71482   0.69773
```

- [dqrng: Fast Pseudo Random Number Generators](https://github.com/daqana/dqrng)

## 随机过程

### 随机游走


### 遍历定理


### M-H 算法


### Gibbs 算法

### HMC 算法

汉密尔顿蒙特卡罗算法


## 分布式

### Rmpi

安装配置 <http://www.stats.uwo.ca/faculty/yu/Rmpi/>

### Rhpc

<https://prs.ism.ac.jp/~nakama/Rhpc/>

Function of apply style using 'MPI' provides better 'HPC' environment on R. And this package supports long vector, can deal with slightly big data.




