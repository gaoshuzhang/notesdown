RSA
function (Data, N_subset, Stepscale, Total_Iteration, Warm) 
{
    DataCol = ncol(Data)
    DataNum = nrow(Data)
    beta = rep(0, DataCol - 2)
    phi = 0
    sigmasq = 0
    tausq = 0
    RetVec2 = .C("RSAc", as.numeric(Data), as.integer(DataCol), 
        as.integer(DataNum), as.integer(N_subset), as.integer(Stepscale), 
        as.integer(Total_Iteration), as.integer(Warm), as.numeric(beta), 
        as.numeric(phi), as.numeric(sigmasq), as.numeric(tausq))
    beta = RetVec2[[8]]
    phi = RetVec2[[9]]
    sigmasq = RetVec2[[10]]
    tausq = RetVec2[[11]]
    Z = NULL
    z = list(beta = beta, phi = phi, sigmasq = sigmasq, tausq = tausq)
    z
}


####code used to generate gdata####
require("geoR")
require("RandomFields")
DataNum=1000;
gData=grf(DataNum,grid="irreg",DataNum,DataNum,xlims=c(0,100),ylims=c(0,100),nsim=1,mean=0,
cov.mode="powered.exponential",cov.par=c(1,25),nugget=1,kappa=1)
l=gData$coords
y=gData$data
x=rnorm(DataNum)
y2=y+.5+x
gdata=cbind(l,y2,x)


data(gdata)
## This is an illustration of the function.
## In practice, Total_Iteration is recommended to be set to 2500 or higher.
## N_subset is recommemded to be set to 300 or higher.
RSA(gdata,N_subset=50,Stepscale=40,Total_Iteration=100,Warm=20)


A Resampling-based Stochastic Approximation Method for Analysis of
Large Geostatitical Data


data(gdata)
## This is an illustration of the function.
## In practice, Total_Iteration is recommended to be set to 2500 or higher.
## N_subset is recommemded to be set to 300 or higher.
RSA(gdata,N_subset=50,Stepscale=40,Total_Iteration=100,Warm=20)

